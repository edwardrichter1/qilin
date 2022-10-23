
`timescale 1 ns / 1 ps

module vm_agent_qdma_data_demux_v1_0
(
    
    input   wire            aclk,
    input   wire            aresetn,

    // Input from m_axis_h2c 
    input   wire [511:0]    qdma_axis_h2c_tdata,
    input   wire [31:0]     qdma_axis_h2c_tuser_crc,
    input   wire [10:0]     qdma_axis_h2c_tuser_qid,
    input   wire [2:0]      qdma_axis_h2c_tuser_port_id,
    input   wire            qdma_axis_h2c_tuser_err,
    input   wire [31:0]     qdma_axis_h2c_tuser_mdata,
    input   wire [5:0]      qdma_axis_h2c_tuser_mty,
    input   wire            qdma_axis_h2c_tuser_zerobyte,
    input   wire            qdma_axis_h2c_tvalid,
    input   wire            qdma_axis_h2c_tlast,
    output  wire            qdma_axis_h2c_tready,
    
    // Output to vm_agent
    output  wire [511:0]    vm_agent_axis_h2c_tdata,
    output  wire [31:0]     vm_agent_axis_h2c_tuser_crc,
    output  wire [10:0]     vm_agent_axis_h2c_tuser_qid,
    output  wire [2:0]      vm_agent_axis_h2c_tuser_port_id,
    output  wire            vm_agent_axis_h2c_tuser_err,
    output  wire [31:0]     vm_agent_axis_h2c_tuser_mdata,
    output  wire [5:0]      vm_agent_axis_h2c_tuser_mty,
    output  wire            vm_agent_axis_h2c_tuser_zerobyte,
    output  wire            vm_agent_axis_h2c_tvalid,
    output  wire            vm_agent_axis_h2c_tlast,
    input   wire            vm_agent_axis_h2c_tready,
    
    // Output to Coyote
    output  wire [511:0]    coyote_axis_h2c_tdata,
    output  wire [31:0]     coyote_axis_h2c_tuser_crc,
    output  wire [10:0]     coyote_axis_h2c_tuser_qid,
    output  wire [2:0]      coyote_axis_h2c_tuser_port_id,
    output  wire            coyote_axis_h2c_tuser_err,
    output  wire [31:0]     coyote_axis_h2c_tuser_mdata,
    output  wire [5:0]      coyote_axis_h2c_tuser_mty,
    output  wire            coyote_axis_h2c_tuser_zerobyte,
    output  wire            coyote_axis_h2c_tvalid,
    output  wire            coyote_axis_h2c_tlast,
    input   wire            coyote_axis_h2c_tready,
    
    // Output to Coyote
    output  wire [511:0]    coyote_isr_axis_h2c_tdata,
    output  wire [31:0]     coyote_isr_axis_h2c_tuser_crc,
    output  wire [10:0]     coyote_isr_axis_h2c_tuser_qid,
    output  wire [2:0]      coyote_isr_axis_h2c_tuser_port_id,
    output  wire            coyote_isr_axis_h2c_tuser_err,
    output  wire [31:0]     coyote_isr_axis_h2c_tuser_mdata,
    output  wire [5:0]      coyote_isr_axis_h2c_tuser_mty,
    output  wire            coyote_isr_axis_h2c_tuser_zerobyte,
    output  wire            coyote_isr_axis_h2c_tvalid,
    output  wire            coyote_isr_axis_h2c_tlast,
    input   wire            coyote_isr_axis_h2c_tready
);

    // Assign all data for VM agent
    assign vm_agent_axis_h2c_tdata          = qdma_axis_h2c_tdata; 
    assign vm_agent_axis_h2c_tuser_crc      = qdma_axis_h2c_tuser_crc; 
    assign vm_agent_axis_h2c_tuser_qid      = qdma_axis_h2c_tuser_qid;
    assign vm_agent_axis_h2c_tuser_port_id  = qdma_axis_h2c_tuser_port_id;
    assign vm_agent_axis_h2c_tuser_err      = qdma_axis_h2c_tuser_err;
    assign vm_agent_axis_h2c_tuser_mdata    = qdma_axis_h2c_tuser_mdata;
    assign vm_agent_axis_h2c_tuser_mty      = qdma_axis_h2c_tuser_mty;
    assign vm_agent_axis_h2c_tuser_zerobyte = qdma_axis_h2c_tuser_zerobyte;
    assign vm_agent_axis_h2c_tlast          = qdma_axis_h2c_tlast;
    
    // Assign all data for Coyote host memory access
    assign coyote_axis_h2c_tdata            = qdma_axis_h2c_tdata; 
    assign coyote_axis_h2c_tuser_crc        = qdma_axis_h2c_tuser_crc; 
    assign coyote_axis_h2c_tuser_qid        = qdma_axis_h2c_tuser_qid;
    assign coyote_axis_h2c_tuser_port_id    = qdma_axis_h2c_tuser_port_id;
    assign coyote_axis_h2c_tuser_err        = qdma_axis_h2c_tuser_err;
    assign coyote_axis_h2c_tuser_mdata      = qdma_axis_h2c_tuser_mdata;
    assign coyote_axis_h2c_tuser_mty        = qdma_axis_h2c_tuser_mty;
    assign coyote_axis_h2c_tuser_zerobyte   = qdma_axis_h2c_tuser_zerobyte;
    assign coyote_axis_h2c_tlast            = qdma_axis_h2c_tlast;
  
    // Assign all data for Coyote page migration
    assign coyote_isr_axis_h2c_tdata            = qdma_axis_h2c_tdata; 
    assign coyote_isr_axis_h2c_tuser_crc        = qdma_axis_h2c_tuser_crc; 
    assign coyote_isr_axis_h2c_tuser_qid        = qdma_axis_h2c_tuser_qid;
    assign coyote_isr_axis_h2c_tuser_port_id    = qdma_axis_h2c_tuser_port_id;
    assign coyote_isr_axis_h2c_tuser_err        = qdma_axis_h2c_tuser_err;
    assign coyote_isr_axis_h2c_tuser_mdata      = qdma_axis_h2c_tuser_mdata;
    assign coyote_isr_axis_h2c_tuser_mty        = qdma_axis_h2c_tuser_mty;
    assign coyote_isr_axis_h2c_tuser_zerobyte   = qdma_axis_h2c_tuser_zerobyte;
    assign coyote_isr_axis_h2c_tlast            = qdma_axis_h2c_tlast;
  
    // Assign Coyote handshake if QID is 0 and VM if QID is 1
    assign coyote_axis_h2c_tvalid = (qdma_axis_h2c_tuser_qid == 0) ? qdma_axis_h2c_tvalid : 1'b0;
    assign vm_agent_axis_h2c_tvalid = (qdma_axis_h2c_tuser_qid == 1) ? qdma_axis_h2c_tvalid : 1'b0;
    assign coyote_isr_axis_h2c_tvalid = (qdma_axis_h2c_tuser_qid == 2) ? qdma_axis_h2c_tvalid : 1'b0;
    assign qdma_axis_h2c_tready = ~qdma_axis_h2c_tvalid ? 1'b0 : ((qdma_axis_h2c_tuser_qid == 0) ? coyote_axis_h2c_tready : ((qdma_axis_h2c_tuser_qid == 1) ? vm_agent_axis_h2c_tready : ((qdma_axis_h2c_tuser_qid == 2) ? coyote_isr_axis_h2c_tready : 1'b0)));
    
endmodule
