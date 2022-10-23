`timescale 1ns / 1ps

`include "axi_macros.svh"
`include "lynx_macros.svh"

import lynxTypes::*;

module random_read_data_path(
    // Clock and Reset
    input wire          aclk,
    input wire          aresetn,
    
    // The CSRs in the control reg file
    input wire [63:0]  num_requests,
    input wire [63:0]  base_addr [15:0],
    input wire [63:0]  bound,
    input wire [63:0]  req_size,
    input wire [63:0]  stride,
    input wire         access_pattern, // 1 - Random 0 - Stride
    input wire         ap_start,
    
    // Outputting the user requests
    reqIntf.m          rd_req_user
);

    reg [1:0]   state, state_n;
    reg [31:0]   count, count_n;
    
    reg [31:0]  rand_num;
    
    // Used to generate a pulse when ap_start is set high
    reg         ap_start_r;
    reg         ap_start_pulse_d1;
    wire        ap_start_pulse;
    
    reqIntf     rd_req_user_n(aclk);
    
    
    localparam WAIT_STATE = 0, REQ_STATE = 1, POST_REQ_STATE = 2;

    // Constants for all requests
    assign rd_req_user_n.req.len        = req_size;
    assign rd_req_user_n.req.sync       = 1'b0;
    assign rd_req_user_n.req.stream     = 1'b0;
    assign rd_req_user_n.req.rsrvd      = 0;
    assign rd_req_user_n.req.ctl        = 1;        // TODO: Check this, not sure if it is correct
    assign rd_req_user_n.req.cache_mode = STANDARD_CACHE;
    
    // Generating a pulse from ap_start to start the 
    always@(posedge aclk) begin
        if(~aresetn) begin
            ap_start_r          <= 1'b0;
            ap_start_pulse_d1   <= 1'b0;
        end
        else begin
            ap_start_r          <= ap_start;
            ap_start_pulse_d1   <= ap_start_pulse;
        end
    end
    assign ap_start_pulse = ap_start & ~ap_start_r;
    
    // Generating a count from 0 - 15 to pick which base address to use
    // This is just a workaround a problem with the driver where we 
    // can only allocate <= 4MiB
    reg [3:0] base_addr_count;
    always@(posedge aclk) begin
        if(~aresetn) begin
            base_addr_count <= 0;
        end
        else if(rd_req_user.ready & rd_req_user.valid) begin
            base_addr_count <= base_addr_count + 1;
        end
        else begin
            base_addr_count <= base_addr_count;
        end
    end
    
    // Generating random 32-bit number every cycle with LFSR
    wire feedback = rand_num[31] ^ rand_num[21] ^ rand_num[1] ^ rand_num[0] ;
    always @(posedge aclk) begin
        if (~aresetn) begin
            rand_num <= 32'hFFFFFFFF;
        end
        else begin
            rand_num <= {rand_num[30:0], feedback};
        end
    end
    
    // Flopping the multiplation we do to align the random address
    reg [31:0] rand_addr_offset_reg;
    always@(posedge aclk) begin
        if(~aresetn) begin
            rand_addr_offset_reg <= 0;
        end
        else begin
            rand_addr_offset_reg <= rand_num * req_size;
        end
    end
    
    // Flopping the calculation of the bound of address
    // we could generate
    reg [31:0] req_bound_reg;
    always@(posedge aclk) begin
        if(~aresetn) begin
            req_bound_reg <= 0;
        end
        else begin
            req_bound_reg <= bound - 1;
        end
    end
    
    // Flopping the calculation of the 
    // random address
    reg [63:0] rand_addr_reg;
    always@(posedge aclk) begin
        if(~aresetn) begin
            rand_addr_reg <= 0;
        end
        else begin
            // Implementing modulo with & -1 because it will always be a
            // power of 2
            rand_addr_reg <= rand_addr_offset_reg & req_bound_reg;
        end
    end
    
    // Flopping the calculation of count * stride 
    reg [63:0] count_times_stride_reg;
    always@(posedge aclk) begin
        if(~aresetn) begin
            count_times_stride_reg <= 0;
        end
        else begin
            count_times_stride_reg <= count * stride;
        end
    end

    // Registered Mealy FSM
    
    // Combinational logic
    always@(*) begin
        case(state)
            WAIT_STATE: begin
            
                // If we receive start, go to requesting state. Else stay here
                if(ap_start_pulse_d1) begin
                    state_n <= REQ_STATE;
                end
                else begin
                    state_n <= WAIT_STATE;
                end
                
                // Regardless what transition we take
                rd_req_user_n.valid     <= 1'b0;
                rd_req_user_n.req.vaddr <= 0;
                count_n                 <= 0;
                
            end

            REQ_STATE: begin
                if(rd_req_user.ready) begin
                    state_n                   <= POST_REQ_STATE;
                    // Generating address depending on the access pattern
                    if(access_pattern) begin
                        rd_req_user_n.req.vaddr <= base_addr[base_addr_count] + rand_addr_reg;
                    end
                    else begin
                        if( (count_times_stride_reg + req_size) < bound) begin
                            rd_req_user_n.req.vaddr   <= base_addr[base_addr_count] + count_times_stride_reg;                        
                        end
                        else begin
                            rd_req_user_n.req.vaddr   <= base_addr[base_addr_count];
                        end
                    end
                    
                    rd_req_user_n.valid       <= 1'b1;
                    count_n                   <= count + 1;
                end
                else begin
                    state_n                   <= REQ_STATE;
                    rd_req_user_n.valid       <= 1'b0;
                    rd_req_user_n.req.vaddr   <= 'hDEAD_EDED;
                    count_n                   <= count;
                end
            end

            POST_REQ_STATE: begin
                if(count < num_requests) begin
                    state_n                   <= REQ_STATE;
                end
                else begin
                    state_n                   <= WAIT_STATE;
                end
                
                // Regardless of what transition we take
                rd_req_user_n.valid           <= 1'b0;
                rd_req_user_n.req.vaddr       <= 'hBEEF_EDED;
                count_n                       <= count;
            end
            
            default: begin
                state_n <= WAIT_STATE;
                rd_req_user_n.valid     <= 1'b0;
                rd_req_user_n.req.vaddr <= 0;
                count_n                 <= 0;
            end
        endcase
    end

    
    // Sequential logic
    always@(posedge aclk) begin    
        if(~aresetn) begin
            state               <= WAIT_STATE;
            rd_req_user.valid   <= 1'b0;
            count               <= 0;
        end
        else begin
            state               <= state_n;
            count               <= count_n;
            rd_req_user.valid   <= rd_req_user_n.valid;
            rd_req_user.req     <= rd_req_user_n.req;
        end
    end
 


endmodule
