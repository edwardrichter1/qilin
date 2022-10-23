
`timescale 1 ns / 1 ps

module qdma_descriptor_mux_v1_0
(
    // Clk and rest
    input   wire aclk,
    input   wire aresetn,

    // Coyote H2C descriptor (Channel 0)
    input   wire [15:0]     coyote_dsc_bypass_h2c_0_dsc_byp_ctl,
    input   wire [63:0]     coyote_dsc_bypass_h2c_0_dsc_byp_dst_addr,
    input   wire [27:0]     coyote_dsc_bypass_h2c_0_dsc_byp_len,
    input   wire            coyote_dsc_bypass_h2c_0_dsc_byp_load,
    output  wire            coyote_dsc_bypass_h2c_0_dsc_byp_ready,
    input   wire [63:0]     coyote_dsc_bypass_h2c_0_dsc_byp_src_addr,
    input   wire [1:0]      coyote_dsc_bypass_h2c_0_dsc_byp_at,
    
    // Coyote H2C descriptor (Channel 1)
    input   wire [15:0]     coyote_dsc_bypass_h2c_1_dsc_byp_ctl,
    input   wire [63:0]     coyote_dsc_bypass_h2c_1_dsc_byp_dst_addr,
    input   wire [27:0]     coyote_dsc_bypass_h2c_1_dsc_byp_len,
    input   wire            coyote_dsc_bypass_h2c_1_dsc_byp_load,
    output  wire            coyote_dsc_bypass_h2c_1_dsc_byp_ready,
    input   wire [63:0]     coyote_dsc_bypass_h2c_1_dsc_byp_src_addr,
    input   wire [1:0]      coyote_dsc_bypass_h2c_1_dsc_byp_at,
    
    // VM Agent H2C descriptor (Right now only have H2C for ATS requests)
    input   wire [63:0]     vm_agent_h2c_byp_in_waddr,
    input   wire            vm_agent_h2c_byp_in_st_vld,
    output  wire            vm_agent_h2c_byp_in_st_rdy,                 
    input   wire [63:0]     vm_agent_h2c_byp_in_raddr,
    input   wire [15:0]     vm_agent_h2c_byp_in_cidx,
    input   wire [1:0]      vm_agent_h2c_byp_in_at,
    input   wire            vm_agent_h2c_byp_in_eop,
    input   wire            vm_agent_h2c_byp_in_error,
    input   wire [7:0]      vm_agent_h2c_byp_in_func,
    input   wire [15:0]     vm_agent_h2c_byp_in_len,
    input   wire            vm_agent_h2c_byp_in_mrkr_req,
    input   wire            vm_agent_h2c_byp_in_no_dma,
    input   wire [2:0]      vm_agent_h2c_byp_in_port_id,
    input   wire [10:0]     vm_agent_h2c_byp_in_qid,
    input   wire            vm_agent_h2c_byp_in_sdi,
    input   wire            vm_agent_h2c_byp_in_sop,
    
    // Output H2C to QDMA
    output  wire [63:0]     qdma_h2c_byp_in_waddr,
    output  wire            qdma_h2c_byp_in_st_vld,
    input   wire            qdma_h2c_byp_in_st_rdy,                 
    output  wire [63:0]     qdma_h2c_byp_in_raddr,
    output  wire [15:0]     qdma_h2c_byp_in_cidx,
    output  wire [1:0]      qdma_h2c_byp_in_at,
    output  wire            qdma_h2c_byp_in_eop,
    output  wire            qdma_h2c_byp_in_error,
    output  wire [7:0]      qdma_h2c_byp_in_func,
    output  wire [15:0]     qdma_h2c_byp_in_len,
    output  wire            qdma_h2c_byp_in_mrkr_req,
    output  wire            qdma_h2c_byp_in_no_dma,
    output  wire [2:0]      qdma_h2c_byp_in_port_id,
    output  wire [10:0]     qdma_h2c_byp_in_qid,
    output  wire            qdma_h2c_byp_in_sdi,
    output  wire            qdma_h2c_byp_in_sop
        
);
    
    // Packing and formatting Coyote's descriptor
    wire [255:0] coyote_dsc_bypass_0_packed_data;
    assign coyote_dsc_bypass_0_packed_data = {
        64'h000000000000000,                            // waddr,
        coyote_dsc_bypass_h2c_0_dsc_byp_src_addr,       // raddr
        16'h0001,                                       // cidx
        coyote_dsc_bypass_h2c_0_dsc_byp_at,             // at
        coyote_dsc_bypass_h2c_0_dsc_byp_ctl[4],         // eop
        1'b0,                                           // error
        7'd0,                                           // func
        coyote_dsc_bypass_h2c_0_dsc_byp_len[15:0],      // len
        1'b0,                                           // mrkr_req
        1'b0,                                           // no_dma
        3'd0,                                           // port_id
        11'd0,                                          // qid
        1'd1,                                           // sdi
        1'd1                                            // sop
    };
    
    wire [255:0] coyote_dsc_bypass_1_packed_data;
    assign coyote_dsc_bypass_1_packed_data = {
        64'h000000000000000,                            // waddr,
        coyote_dsc_bypass_h2c_1_dsc_byp_src_addr,       // raddr
        16'h0001,                                       // cidx
        coyote_dsc_bypass_h2c_1_dsc_byp_at,             // at
        coyote_dsc_bypass_h2c_1_dsc_byp_ctl[4],         // eop
        1'b0,                                           // error
        7'd0,                                           // func
        coyote_dsc_bypass_h2c_1_dsc_byp_len[15:0],      // len
        1'b0,                                           // mrkr_req
        1'b0,                                           // no_dma
        3'd0,                                           // port_id
        11'd2,                                          // qid
        1'd1,                                           // sdi
        1'd1                                            // sop
    };
    
    // Packing the VM agent's descriptor
    wire [255:0] vm_agent_dsc_bypass_packed_data;
//    assign vm_agent_dsc_bypass_packed_data = {        
//        vm_agent_h2c_byp_in_waddr,                 
//        vm_agent_h2c_byp_in_raddr,
//        vm_agent_h2c_byp_in_cidx,
//        vm_agent_h2c_byp_in_at,
//        vm_agent_h2c_byp_in_eop,
//        vm_agent_h2c_byp_in_error,
//        vm_agent_h2c_byp_in_func,
//        vm_agent_h2c_byp_in_len,
//        vm_agent_h2c_byp_in_mrkr_req,
//        vm_agent_h2c_byp_in_no_dma,
//        vm_agent_h2c_byp_in_port_id,
//        vm_agent_h2c_byp_in_qid,
//        vm_agent_h2c_byp_in_sdi,
//        vm_agent_h2c_byp_in_sop
//    };
    // Doing it this way because the output was a little funky 
    assign  vm_agent_dsc_bypass_packed_data[255:189]    = 67'd0;
    assign  vm_agent_dsc_bypass_packed_data[188:125]    = vm_agent_h2c_byp_in_waddr;
    assign  vm_agent_dsc_bypass_packed_data[124:61]     = vm_agent_h2c_byp_in_raddr;
    assign  vm_agent_dsc_bypass_packed_data[60:45]      = vm_agent_h2c_byp_in_cidx;
    assign  vm_agent_dsc_bypass_packed_data[44:43]      = vm_agent_h2c_byp_in_at;
    assign  vm_agent_dsc_bypass_packed_data[42]         = vm_agent_h2c_byp_in_eop;
    assign  vm_agent_dsc_bypass_packed_data[41]         = vm_agent_h2c_byp_in_error;
    assign  vm_agent_dsc_bypass_packed_data[40:34]      = vm_agent_h2c_byp_in_func;
    assign  vm_agent_dsc_bypass_packed_data[33:18]      = vm_agent_h2c_byp_in_len;
    assign  vm_agent_dsc_bypass_packed_data[17]         = vm_agent_h2c_byp_in_mrkr_req;
    assign  vm_agent_dsc_bypass_packed_data[16]         = vm_agent_h2c_byp_in_no_dma;
    assign  vm_agent_dsc_bypass_packed_data[15:13]      = vm_agent_h2c_byp_in_port_id;
    assign  vm_agent_dsc_bypass_packed_data[12:2]       = vm_agent_h2c_byp_in_qid;
    assign  vm_agent_dsc_bypass_packed_data[1]          = vm_agent_h2c_byp_in_sdi;
    assign  vm_agent_dsc_bypass_packed_data[0]          = vm_agent_h2c_byp_in_sop;
    
    // Unpacking the output of the switch to QDMA
    wire [255:0] switch_output_data;
//    assign {
//        qdma_h2c_byp_in_waddr,
//        qdma_h2c_byp_in_raddr,
//        qdma_h2c_byp_in_cidx,
//        qdma_h2c_byp_in_at,
//        qdma_h2c_byp_in_eop,
//        qdma_h2c_byp_in_error,
//        qdma_h2c_byp_in_func,
//        qdma_h2c_byp_in_len,
//        qdma_h2c_byp_in_mrkr_req,
//        qdma_h2c_byp_in_no_dma,
//        qdma_h2c_byp_in_port_id,
//        qdma_h2c_byp_in_qid,
//        qdma_h2c_byp_in_sdi,
//        qdma_h2c_byp_in_sop
//    } = switch_output_data;
    // Doing it this way because the output was a little funky 
    assign  qdma_h2c_byp_in_waddr       = switch_output_data[188:125];
    assign  qdma_h2c_byp_in_raddr       = switch_output_data[124:61];
    assign  qdma_h2c_byp_in_cidx        = switch_output_data[60:45];
    assign  qdma_h2c_byp_in_at          = switch_output_data[44:43];
    assign  qdma_h2c_byp_in_eop         = switch_output_data[42];
    assign  qdma_h2c_byp_in_error       = switch_output_data[41];
    assign  qdma_h2c_byp_in_func        = switch_output_data[40:34];
    assign  qdma_h2c_byp_in_len         = switch_output_data[33:18];
    assign  qdma_h2c_byp_in_mrkr_req    = switch_output_data[17];
    assign  qdma_h2c_byp_in_no_dma      = switch_output_data[16];
    assign  qdma_h2c_byp_in_port_id     = switch_output_data[15:13];
    assign  qdma_h2c_byp_in_qid         = switch_output_data[12:2];
    assign  qdma_h2c_byp_in_sdi         = switch_output_data[1];
    assign  qdma_h2c_byp_in_sop         = switch_output_data[0];
    


    // Connecting both streams into an AXIS Switch. MSB is VM Coyote, LSB is VM Agent
    axis_switch_0 your_instance_name (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axis_tvalid({coyote_dsc_bypass_h2c_0_dsc_byp_load, coyote_dsc_bypass_h2c_1_dsc_byp_load, vm_agent_h2c_byp_in_st_vld}),
        .s_axis_tready({coyote_dsc_bypass_h2c_0_dsc_byp_ready, coyote_dsc_bypass_h2c_1_dsc_byp_ready, vm_agent_h2c_byp_in_st_rdy}),
        .s_axis_tdata({coyote_dsc_bypass_0_packed_data, coyote_dsc_bypass_1_packed_data, vm_agent_dsc_bypass_packed_data}),
        .m_axis_tvalid(qdma_h2c_byp_in_st_vld),
        .m_axis_tready(qdma_h2c_byp_in_st_rdy),
        .m_axis_tdata(switch_output_data),
        .s_req_suppress(2'd0),
        .s_decode_err()
    );


	endmodule
