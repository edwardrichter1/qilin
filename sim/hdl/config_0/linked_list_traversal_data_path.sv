`timescale 1ns / 1ps

`include "axi_macros.svh"
`include "lynx_macros.svh"

import lynxTypes::*;

module linked_list_traversal_data_path (
    // Clock and Reset
    input wire          aclk,
    input wire          aresetn,
    
    // The CSRs in the control reg file
    input wire [63:0]  num_requests,
    input wire [63:0]  base_addr,
    input wire [63:0]  req_size,
    input wire         ap_start,
    input wire         independent, // 1 is traversal is independent of payload, 0 is dependent
    input wire         ptr,         // 1 is payload is pointed to by a ptr, 0 is payload is inlined with node
    
    
    // Outputting the user requests
    reqIntf.m          rd_req_user,
    
    // Input data of nodes as they come in
    AXI4SR.s            axis_host_sink
);

    reg [3:0]   state, state_n;
    reg [9:0]   count, count_n;
    reg [63:0]  addr, addr_n;
    reg [63:0]  payload_addr, payload_addr_n;
    reg         ptr_req, ptr_req_n;
    
    // Used to generate a pulse when ap_start is set high
    reg         ap_start_r;
    reg         ap_start_pulse_d1;
    wire        ap_start_pulse;
        
    reqIntf     rd_req_user_n(aclk);
    AXI4S       axis_host_sink_n(aclk);
        
    // Count the number of tlasts we received, necessary for the independent case
    reg [63:0] tlast_count;
    always@(posedge aclk) begin
        if(~aresetn) begin
            tlast_count <= 0;
        end
        else begin
            if(axis_host_sink.tlast & axis_host_sink.tvalid & axis_host_sink.tready) begin
                tlast_count <= tlast_count + 1;
            end
        end
    end
    
    
    localparam WAIT_STATE = 0, REQ_STATE = 1, POST_REQ_STATE_WAIT_FOR_VALID = 2, POST_REQ_STATE_WAIT_FOR_LAST = 3, POST_REQ_STATE_LAST = 4, INDEPENDENT_WAIT_STATE = 5, POINTER_REQ_STATE = 6, POINTER_WAIT_FOR_VALID_STATE = 6, WAIT_FOR_LAST = 7;
    

    // Constants for all requests
    //assign rd_req_user_n.req.len        = req_size;           // Each request will get a single node
    assign rd_req_user_n.req.rsrvd_high = 6'd0;
    assign rd_req_user_n.req.cache_mode = STANDARD_CACHE;             // Choosing the caching optimization
    assign rd_req_user_n.req.sync       = 1'b0;             
    assign rd_req_user_n.req.stream     = 1'b0;
    assign rd_req_user_n.req.rsrvd      = 0;
    assign rd_req_user_n.req.ctl        = 1;                    // TODO: Check this, not sure if it is correct
    assign rd_req_user_n.req.dest       = 0;

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
    
    // Combinational logic
    always@(*) begin
        case(state)
            WAIT_STATE: begin
                // If we receive start, go to requesting state. Else stay here
                if(ap_start_pulse_d1) begin
                    state_n                   <= REQ_STATE;
                    rd_req_user_n.req.vaddr   <= addr;
                    rd_req_user_n.valid       <= 1'b1;
                    rd_req_user_n.req.len     <= ptr ? 16: req_size; // If ptr, this will just get the node
                    count_n                   <= count + 1;
                end
                else begin
                    state_n                   <= WAIT_STATE;
                    rd_req_user_n.valid       <= 1'b0;
                    rd_req_user_n.req.len     <= 0;
                    count_n                   <= 0;
                end
                
                // Regardless what transition we take
                addr_n                    <= base_addr;
                rd_req_user_n.req.vaddr   <= base_addr;
                axis_host_sink_n.tready   <= 1'b0;
                payload_addr_n            <= 0;
                ptr_req_n                 <= 0;
            end

            REQ_STATE: begin
                if(count >= (num_requests << ptr) & rd_req_user.ready) begin
                    state_n                       <= WAIT_FOR_LAST;
                    rd_req_user_n.req.vaddr       <= addr;
                    rd_req_user_n.valid           <= 1'b0;
                    rd_req_user_n.req.len         <= 0; 
                    count_n                       <= count;
                end
                else if(rd_req_user.ready) begin
                    state_n                   <= POST_REQ_STATE_WAIT_FOR_VALID;
                    rd_req_user_n.valid       <= 1'b0;
                end
                else begin
                    state_n                   <= REQ_STATE;
                    rd_req_user_n.valid       <= 1'b1;
                end
                rd_req_user_n.req.len     <= ptr ? 16: req_size; // If ptr, this will just get the node
                addr_n                    <= addr;
                count_n                   <= count;
                rd_req_user_n.req.vaddr   <= addr;
                axis_host_sink_n.tready   <= 1'b0;
                payload_addr_n            <= payload_addr;
                ptr_req_n                 <= 0;
            end

            POST_REQ_STATE_WAIT_FOR_VALID: begin
                
                // If the data is not valid wait in this state
                if(~axis_host_sink.tvalid) begin
                    state_n                   <= POST_REQ_STATE_WAIT_FOR_VALID;
                    addr_n                    <= addr;
                    payload_addr_n            <= payload_addr;
                    ptr_req_n                 <= ptr_req;
                    rd_req_user_n.valid       <= 1'b0;
                    rd_req_user_n.req.vaddr   <= 'hBEEF_EDED;
                    rd_req_user_n.req.len     <= req_size - 16;
                    count_n                   <= count;
                end
                // If the data is valid, but we are in the dependent case and it is not 
                // the last piece of data, keep note of the relevant parts of the data 
                // and move to the state where we wait on the last piece of data
                else if((axis_host_sink.tvalid & ~axis_host_sink.tlast) & ~independent) begin 
                    state_n                   <= POST_REQ_STATE_WAIT_FOR_LAST;
                    payload_addr_n            <= ptr_req ? payload_addr : axis_host_sink.tdata[127:64]; // If we have pointers to payload, [127:64] will have that
                    addr_n                    <= ptr_req ? addr : axis_host_sink.tdata[63:0];   // Next node address is always first 64-bits
                    ptr_req_n                 <= ptr_req;
                    rd_req_user_n.valid       <= 1'b0;
                    rd_req_user_n.req.vaddr   <= 'hBEEF_EDED;
                    rd_req_user_n.req.len     <= req_size - 16;
                    count_n                   <= count;
                end
                // If the data is valid, and  either (1) It is the last beat and dependent or (2) It is a new request and independent
                // Can go to make another request
                else if(axis_host_sink.tvalid & (axis_host_sink.tlast | independent) & (count < tlast_count + 2)) begin
                    if(ptr & ~ptr_req) begin
                        state_n                       <= POINTER_REQ_STATE;
                        ptr_req_n                     <= 1'b1;
                        rd_req_user_n.valid           <= 1'b1;
                        rd_req_user_n.req.vaddr       <= axis_host_sink.tdata[127:64];
                        rd_req_user_n.req.len         <= req_size - 16;
                        count_n                       <= count + 1;   
                    end
                    else begin
                        state_n                       <= POST_REQ_STATE_LAST;
                        ptr_req_n                     <= 1'b0;
                        rd_req_user_n.valid           <= 1'b0;
                        rd_req_user_n.req.vaddr       <= 'hBEEF_EDED;
                        rd_req_user_n.req.len         <= req_size - 16;
                        count_n                       <= count;        
                    end
                    payload_addr_n            <= ptr_req ? payload_addr : axis_host_sink.tdata[127:64];
                    addr_n                    <= ptr_req ? addr : axis_host_sink.tdata[63:0]; // Next node address is always first 64-bits
                end
                
                // If the data is valid, we are in the independent case, but we are waiting for the payload to finish, 
                // Go to the independent waiting state
                else if(axis_host_sink.tvalid & independent & count >= tlast_count + 2) begin
                    state_n                   <= INDEPENDENT_WAIT_STATE;
                    addr_n                    <= addr;
                    payload_addr_n            <= payload_addr;//ptr_req ? payload_addr : axis_host_sink.tdata[127:64];
                    addr_n                    <= addr;//ptr_req ? addr : axis_host_sink.tdata[63:0]; // Next node address is always first 64-bits
                    rd_req_user_n.valid       <= 1'b0;
                    ptr_req_n                 <= ptr_req;
                    rd_req_user_n.req.vaddr   <= 'hBEEF_EDED;
                    rd_req_user_n.req.len     <= req_size - 16;
                    count_n                   <= count;
                end
                
                // Don't think it is possible to be here, because it would only happen if we are in
                // the dependent state, and also count >= tlast_count + 2, but count will always 
                // be within 1 of tlast_count in the dependent state. Anyways, if that is the 
                // case we are staying here.
                else begin
                    state_n                   <= POST_REQ_STATE_WAIT_FOR_VALID;
                    addr_n                    <= addr;
                    payload_addr_n            <= payload_addr;
                    ptr_req_n                 <= ptr_req;
                    rd_req_user_n.valid       <= 1'b0;
                    rd_req_user_n.req.vaddr   <= 'hBEEF_EDED;
                    rd_req_user_n.req.len     <= req_size - 16;
                    count_n                   <= count;
                end
                
                
                // Regardless of what transition we take
                axis_host_sink_n.tready       <= 1'b1;
                
            end
            
            POST_REQ_STATE_WAIT_FOR_LAST: begin
                if(axis_host_sink.tvalid & axis_host_sink.tlast) begin
                    if(ptr & ~ptr_req) begin
                        state_n                   <= POINTER_REQ_STATE;
                    end
                    else begin
                        state_n                   <= POST_REQ_STATE_LAST;
                    end
                end
                else begin
                    state_n                   <= POST_REQ_STATE_WAIT_FOR_LAST; 
                end
                
                // Regardless of what transition we take
                ptr_req_n                     <= ptr_req;
                payload_addr_n                <= payload_addr;
                addr_n                        <= addr;
                axis_host_sink_n.tready       <= 1'b1;
                rd_req_user_n.valid           <= 1'b0;
                rd_req_user_n.req.vaddr       <= 'hBEEF_EDED;
                rd_req_user_n.req.len         <= 0;
                count_n                       <= count;
            end
            
            POST_REQ_STATE_LAST: begin
                if(count < (num_requests << ptr)) begin // If ptr is set, we send two requests per node so need to multiply by 2
                    state_n                   <= REQ_STATE;
                    rd_req_user_n.valid       <= 1'b1;
                    count_n                   <= count + 1;
                end
                else begin
                    state_n                   <= WAIT_FOR_LAST;
                    rd_req_user_n.valid       <= 1'b0;
                    count_n                   <= count;
                end
                
                // Regardless of what transition we take
                rd_req_user_n.req.len         <= ptr ? 16: req_size; // If ptr, this will just get the node
                rd_req_user_n.req.vaddr       <= addr;
                ptr_req_n                     <= ptr_req;
                axis_host_sink_n.tready       <= 1'b0;
                payload_addr_n                <= payload_addr;
                addr_n                        <= addr;
            end
            
            INDEPENDENT_WAIT_STATE: begin
                if(count >= (num_requests << ptr)) begin
                    state_n                       <= WAIT_FOR_LAST;
                    payload_addr_n                <= payload_addr;                    
                    addr_n                        <= addr;
                    rd_req_user_n.req.vaddr       <= addr;
                    rd_req_user_n.valid           <= 1'b0;
                    rd_req_user_n.req.len         <= req_size;
                    count_n                       <= count;
                end
                else if(axis_host_sink.tvalid & /*axis_host_sink.tlast &*/ (count == tlast_count + 1)) begin
                    state_n                       <= ptr ? POINTER_REQ_STATE : REQ_STATE; // After we receive the last beat, we can make a new request, if ptr is high it will be a payload, if not it will be a node
                    rd_req_user_n.req.vaddr       <= ptr ? axis_host_sink.tdata[127:64] : axis_host_sink.tdata[63:0];
                    rd_req_user_n.valid           <= 1'b1;
                    rd_req_user_n.req.len         <= ptr ? req_size - 16 : 16;
                    count_n                       <= count + 1;
                    payload_addr_n                <= ptr_req ? payload_addr : axis_host_sink.tdata[127:64];
                    addr_n                        <= ptr_req ? addr : axis_host_sink.tdata[63:0]; // Next node address is always first 64-bits
                end
                else begin
                    state_n                       <= INDEPENDENT_WAIT_STATE;
                    payload_addr_n                <= payload_addr;                    
                    addr_n                        <= addr;
                    rd_req_user_n.req.vaddr       <= addr;
                    rd_req_user_n.valid           <= 1'b0;
                    rd_req_user_n.req.len         <= req_size;
                    count_n                       <= count;
                end
                
                ptr_req_n                     <= ptr_req;
                axis_host_sink_n.tready       <= 1'b1;
            end
            
            POINTER_REQ_STATE: begin
                if(rd_req_user.ready) begin
                    if(count >= (num_requests << ptr)) begin
                        state_n                       <= WAIT_FOR_LAST;
                        rd_req_user_n.req.vaddr       <= addr;
                        rd_req_user_n.valid           <= 1'b0;
                        rd_req_user_n.req.len         <= req_size;
                        count_n                       <= count;
                    end
                    else begin
                        // If independent is high, want to just make another request
                        // if independent is low, need to wait for the payload
                        state_n                   <= independent ? REQ_STATE: POST_REQ_STATE_WAIT_FOR_VALID;
                        rd_req_user_n.req.vaddr   <= addr;
                        rd_req_user_n.valid       <= independent ; // If independent, we are going to req_state and we have to set valid high again
                        rd_req_user_n.req.len     <= 16; // Get the payload
                        count_n                   <= independent ? count + 1 : count;
                    end
                end
                else begin
                    state_n                   <= POINTER_REQ_STATE;
                    rd_req_user_n.req.vaddr   <= payload_addr;
                    rd_req_user_n.valid       <= 1'b1;
                    rd_req_user_n.req.len     <= req_size - 16; // Get the payload
                    count_n                   <= count;
                    /*state_n                   <= POINTER_REQ_STATE;
                    rd_req_user_n.valid       <= 1'b0;
                    rd_req_user_n.req.vaddr   <= 'hDEAD_EDED;
                    count_n                   <= count;
                    rd_req_user_n.req.len     <= 0;*/
                end
                ptr_req_n                     <= ptr_req;
                payload_addr_n                <= payload_addr;
                addr_n                        <= addr;
                axis_host_sink_n.tready       <= 1'b0;
            end
            
            // This is where we wait for the last request, and set the finish to 1
            // TODO: Have it write to some denoted address when complete to see 
            // if polling on a CSR will impact performance
            WAIT_FOR_LAST: begin
                if(tlast_count == count) begin
                    state_n <= WAIT_STATE;
                end
                else begin
                    state_n <= WAIT_FOR_LAST;
                end
                
                rd_req_user_n.valid     <= 1'b0;
                rd_req_user_n.req.vaddr <= 'hBEEF_EDED;
                rd_req_user_n.req.len   <= 0;
                count_n                 <= count;
                addr_n                  <= base_addr;
                axis_host_sink_n.tready <= 1'b1; // Open the floodgates :-D
                payload_addr_n          <= 0;
                ptr_req_n               <= 1'b0;
                
            end
            
            
            default: begin
                state_n                 <= WAIT_STATE;
                rd_req_user_n.valid     <= 1'b0;
                rd_req_user_n.req.vaddr <= 'hBEEF_EDED;
                rd_req_user_n.req.len   <= 0;
                count_n                 <= 0;
                addr_n                  <= base_addr;
                axis_host_sink_n.tready <= 1'b0;
                payload_addr_n          <= 0;
                ptr_req_n               <= 1'b0;
            end
            
            
            
            
        endcase
    end

    
    // Sequential logic
    always@(posedge aclk) begin    
        if(~aresetn) begin
            state                   <= WAIT_STATE;
            rd_req_user.valid       <= 1'b0;
            count                   <= 0;
            addr                    <= 0;
            axis_host_sink.tready   <= 1'b0;
            payload_addr            <= 0;
            ptr_req                 <= 0;
        end
        else begin
            state                   <= state_n;
            count                   <= count_n;
            rd_req_user.valid       <= rd_req_user_n.valid;
            rd_req_user.req         <= rd_req_user_n.req;
            addr                    <= addr_n;
            axis_host_sink.tready   <= axis_host_sink_n.tready;
            payload_addr            <= payload_addr_n;
            ptr_req                 <= ptr_req_n;
        end
    end


endmodule
