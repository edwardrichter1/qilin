`timescale 1ns / 1ps

`include "axi_macros.svh"
`include "lynx_macros.svh"
import lynxTypes::*;

// MACRO used to only write valid data into the CSRs
`define WRITE_VALID_BITS(reg_to_write, strb, write_data) reg_to_write <= (reg_to_write & ~strb) | (write_data & strb)

module microbenchmark_controller(
    // Clock and Reset
    input wire          aclk,
    input wire          aresetn,
    
    // AXI Lite port
    //AXI4L.s             axi_l
    input  wire                          axi_l_awvalid,
    input  wire [AXI_ADDR_BITS-1:0]      axi_l_awaddr,
    output wire                          axi_l_awready,
    input  wire                          axi_l_wvalid,
    output wire                          axi_l_wready,
    input  wire [AXIL_DATA_BITS-1:0]     axi_l_wdata,
    input  wire [(AXIL_DATA_BITS/8)-1:0] axi_l_wstrb,
    output wire                          axi_l_bvalid,
    input  wire                          axi_l_bready,
    output wire [1:0]                    axi_l_bresp,
    
    
    // Outputting the CSRs in the control reg file
    output wire [63:0]  num_requests,
    output wire [63:0]  base_addr [15:0],
    output wire [63:0]  bound,
    output wire [63:0]  req_size,
    output wire [63:0]  stride,
    output wire         access_pattern,
    output wire         independent, // 1 is traversal is independent of payload, 0 is dependent
    output wire         ptr,         // 1 is payload is pointed to by a ptr, 0 is payload is inlined with node
    output wire [15:0]  ap_start 
);
    
    // Control interface data-widths
    localparam integer N_REGS = 25;
    localparam integer ADDR_LSB = (AXIL_DATA_BITS/32) + 1;
    localparam integer ADDR_MSB = $clog2(N_REGS);
    localparam integer AXI_ADDR_BITS = ADDR_LSB + ADDR_MSB;
    
    // Used for looping
    integer i;
    
    // Right now just setting bresp to 0 to say everything is OK
    assign axi_l_bresp = 2'd0;
    
    wire reg_file_wr_en;
    
    controller controller_inst(
        .clk(aclk),
        .aresetn(aresetn),
        .awvalid(axi_l_awvalid),
        .wvalid(axi_l_wvalid),
        .bready(axi_l_bready),
        .awready(axi_l_awready),
        .wready(axi_l_wready),
        .bvalid(axi_l_bvalid),
        .reg_file_wr_en(reg_file_wr_en)
    );
    
    reg [AXI_ADDR_BITS-1:0]     s_axi_awaddr_reg;
    reg [AXIL_DATA_BITS-1:0]    s_axi_wdata_reg;
    reg [AXIL_DATA_BITS-1:0]    s_axi_wstrb_reg;
    
    // waddr register
    always@(posedge aclk) begin
        if(~aresetn) begin
            s_axi_awaddr_reg <= 0;
        end
        else if(axi_l_awvalid) begin
            s_axi_awaddr_reg <= axi_l_awaddr;
        end
        else begin
            s_axi_awaddr_reg <= s_axi_awaddr_reg;
        end
    end
    
    // wdata register
    always@(posedge aclk) begin
        if(~aresetn) begin
            s_axi_wdata_reg <= 0;
        end
        else if(axi_l_wvalid) begin
            s_axi_wdata_reg <= axi_l_wdata;
        end
        else begin
            s_axi_wdata_reg <= s_axi_wdata_reg;
        end
    end
    
    //wstrb register
    always@(posedge aclk) begin
        if(~aresetn) begin
            s_axi_wstrb_reg <= 0;
        end
        else if(axi_l_wvalid) begin
            // Unrolling the strobe so I can easily AND with the data
            for(i = 0; i < 64; i++) begin
                s_axi_wstrb_reg[i] <= axi_l_wstrb[i / 8];
            end
        end
        else begin
            s_axi_wstrb_reg <= s_axi_wstrb_reg;
        end
    end
    
    
    // CSRs in control register file
    reg [AXIL_DATA_BITS-1:0]    num_requests_reg;
    reg [AXIL_DATA_BITS-1:0]    base_addr_reg [15:0];
    reg [AXIL_DATA_BITS-1:0]    bound_reg;
    reg [AXIL_DATA_BITS-1:0]    req_size_reg;
    reg [AXIL_DATA_BITS-1:0]    stride_reg;
    reg                         access_pattern_reg;
    reg                         independent_reg;
    reg                         ptr_reg;
    reg [AXIL_DATA_BITS-1:0]    ap_start_reg;
    
    assign num_requests     = num_requests_reg;
    assign bound            = bound_reg;
    assign req_size         = req_size_reg;
    assign stride           = stride_reg;
    assign access_pattern   = access_pattern_reg;
    assign independent      = independent_reg;
    assign ptr              = ptr_reg;
    
    // Assigning the base addresse for each linked list module
    for(genvar base_addr_gen_iter = 0; base_addr_gen_iter < 16; base_addr_gen_iter = base_addr_gen_iter + 1) begin
        assign base_addr[base_addr_gen_iter] = base_addr_reg[base_addr_gen_iter];
    end
    
    // ap_start[0] is the value to set
    // ap_start[4:1] are the linked list modules to make that change to
    for(genvar ap_start_gen_iter = 0; ap_start_gen_iter < 16; ap_start_gen_iter = ap_start_gen_iter + 1) begin
        assign ap_start[ap_start_gen_iter] = ap_start_reg[0] & (ap_start_reg[4:1] >=  ap_start_gen_iter);
    end
    
    
    // Control register file
    always@(posedge aclk) begin 
        if(~aresetn) begin 
            num_requests_reg    <= 0;
            base_addr_reg[0]    <= 0;
            base_addr_reg[1]    <= 0;
            base_addr_reg[2]    <= 0;
            base_addr_reg[3]    <= 0;
            base_addr_reg[4]    <= 0;
            base_addr_reg[5]    <= 0;
            base_addr_reg[6]    <= 0;
            base_addr_reg[7]    <= 0;
            base_addr_reg[8]    <= 0;
            base_addr_reg[9]    <= 0;
            base_addr_reg[10]   <= 0;
            base_addr_reg[11]   <= 0;
            base_addr_reg[12]   <= 0;
            base_addr_reg[13]   <= 0;
            base_addr_reg[14]   <= 0;
            base_addr_reg[15]   <= 0;
            bound_reg           <= 0;
            req_size_reg        <= 0;
            stride_reg          <= 0;
            access_pattern_reg  <= 0;
            independent_reg     <= 0;
            ptr_reg             <= 0;
            ap_start_reg        <= 0;
        end 
        else if(reg_file_wr_en) begin 
            case(s_axi_awaddr_reg) 
                'h00: `WRITE_VALID_BITS(ap_start_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h08: `WRITE_VALID_BITS(num_requests_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h10: `WRITE_VALID_BITS(ptr_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h18: `WRITE_VALID_BITS(bound_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h20: `WRITE_VALID_BITS(req_size_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h28: `WRITE_VALID_BITS(stride_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h30: `WRITE_VALID_BITS(access_pattern_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h38: `WRITE_VALID_BITS(independent_reg, s_axi_wstrb_reg, s_axi_wdata_reg);
                'h40: `WRITE_VALID_BITS(base_addr_reg[0], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h48: `WRITE_VALID_BITS(base_addr_reg[1], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h50: `WRITE_VALID_BITS(base_addr_reg[2], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h58: `WRITE_VALID_BITS(base_addr_reg[3], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h60: `WRITE_VALID_BITS(base_addr_reg[4], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h68: `WRITE_VALID_BITS(base_addr_reg[5], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h70: `WRITE_VALID_BITS(base_addr_reg[6], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h78: `WRITE_VALID_BITS(base_addr_reg[7], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h80: `WRITE_VALID_BITS(base_addr_reg[8], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h88: `WRITE_VALID_BITS(base_addr_reg[9], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h90: `WRITE_VALID_BITS(base_addr_reg[10], s_axi_wstrb_reg, s_axi_wdata_reg);
                'h98: `WRITE_VALID_BITS(base_addr_reg[11], s_axi_wstrb_reg, s_axi_wdata_reg);
                'hA0: `WRITE_VALID_BITS(base_addr_reg[12], s_axi_wstrb_reg, s_axi_wdata_reg);
                'hA8: `WRITE_VALID_BITS(base_addr_reg[13], s_axi_wstrb_reg, s_axi_wdata_reg);
                'hB0: `WRITE_VALID_BITS(base_addr_reg[14], s_axi_wstrb_reg, s_axi_wdata_reg);
                'hB8: `WRITE_VALID_BITS(base_addr_reg[15], s_axi_wstrb_reg, s_axi_wdata_reg);
                
                default: begin
                    num_requests_reg    <= num_requests_reg;
                    base_addr_reg[0]    <= base_addr_reg[0] ;
                    base_addr_reg[1]    <= base_addr_reg[1] ;
                    base_addr_reg[2]    <= base_addr_reg[2] ;
                    base_addr_reg[3]    <= base_addr_reg[3] ;
                    base_addr_reg[4]    <= base_addr_reg[4] ;
                    base_addr_reg[5]    <= base_addr_reg[5] ;
                    base_addr_reg[6]    <= base_addr_reg[6] ;
                    base_addr_reg[7]    <= base_addr_reg[7] ;
                    base_addr_reg[8]    <= base_addr_reg[8] ;
                    base_addr_reg[9]    <= base_addr_reg[9] ;
                    base_addr_reg[10]   <= base_addr_reg[10];
                    base_addr_reg[11]   <= base_addr_reg[11];
                    base_addr_reg[12]   <= base_addr_reg[12];
                    base_addr_reg[13]   <= base_addr_reg[13];
                    base_addr_reg[14]   <= base_addr_reg[14];
                    base_addr_reg[15]   <= base_addr_reg[15];
                    bound_reg           <= bound_reg;
                    req_size_reg        <= req_size_reg;
                    stride_reg          <= stride_reg;
                    access_pattern_reg  <= access_pattern_reg;
                    independent_reg     <= independent_reg;
                    ptr_reg             <= ptr_reg;
                    ap_start_reg        <= ap_start_reg; 
                end
            endcase 
        end 
        else begin 
            num_requests_reg    <= num_requests_reg;
            base_addr_reg[0]    <= base_addr_reg[0] ;
            base_addr_reg[1]    <= base_addr_reg[1] ;
            base_addr_reg[2]    <= base_addr_reg[2] ;
            base_addr_reg[3]    <= base_addr_reg[3] ;
            base_addr_reg[4]    <= base_addr_reg[4] ;
            base_addr_reg[5]    <= base_addr_reg[5] ;
            base_addr_reg[6]    <= base_addr_reg[6] ;
            base_addr_reg[7]    <= base_addr_reg[7] ;
            base_addr_reg[8]    <= base_addr_reg[8] ;
            base_addr_reg[9]    <= base_addr_reg[9] ;
            base_addr_reg[10]   <= base_addr_reg[10];
            base_addr_reg[11]   <= base_addr_reg[11];
            base_addr_reg[12]   <= base_addr_reg[12];
            base_addr_reg[13]   <= base_addr_reg[13];
            base_addr_reg[14]   <= base_addr_reg[14];
            base_addr_reg[15]   <= base_addr_reg[15];
            bound_reg           <= bound_reg;
            req_size_reg        <= req_size_reg;
            stride_reg          <= stride_reg;
            access_pattern_reg  <= access_pattern_reg;
            independent_reg     <= independent_reg;
            ptr_reg             <= ptr_reg;
            ap_start_reg        <= ap_start_reg; 
        end 
    end
endmodule
