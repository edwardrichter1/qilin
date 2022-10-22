`timescale 1ns / 1ps

import lynxTypes::*;

`include "axi_macros.svh"
`include "lynx_macros.svh"

module design_dynamic_wrapper #(
    parameter integer                       ID_DYN = 0
) (
    // Clock and reset
    input  logic                            sys_rst,
    input  logic                            aresetn,
    input  logic                            aclk,

    // AXI4 Lite control
    AXI4L.s                                 axi_ctrl [N_REGIONS],
    
    // AXI4 AVX control
    AXI4.s                                  axim_ctrl [N_REGIONS],
    
    // AXI4 DDR 
    AXI4.m									axi_ddr_in [N_DDR_CHAN*2],

    // AXI4S host
    AXI4S.m                                 axis_host_in,
    AXI4S.s                                 axis_host_out,
    xdmaIntf.m                              host_xdma_req,
    
    // AXI4S card
    AXI4S.m                                 axis_card_in,
    AXI4S.s                                 axis_card_out,
    xdmaIntf.m                              card_xdma_req,
    
    // IRQ
    output logic[N_REGIONS-1:0]             usr_irq,

    // BSCAN
    input  logic                            S_BSCAN_drck,
    input  logic                            S_BSCAN_shift,
    input  logic                            S_BSCAN_tdi,
    input  logic                            S_BSCAN_update,
    input  logic                            S_BSCAN_sel,
    output logic                            S_BSCAN_tdo,
    input  logic                            S_BSCAN_tms,
    input  logic                            S_BSCAN_tck,
    input  logic                            S_BSCAN_runtest,
    input  logic                            S_BSCAN_reset,
    input  logic                            S_BSCAN_capture,
    input  logic                            S_BSCAN_bscanid_en
);

// Control lTLB
AXI4L axi_ctrl_lTlb [N_REGIONS] ();

// Control sTLB
AXI4L axi_ctrl_sTlb [N_REGIONS] ();

// Control config
AXI4L axi_ctrl_cnfg [N_REGIONS] ();

// Control user logic
AXI4L axi_ctrl_user [N_REGIONS] ();

// Decoupling signals
logic [N_REGIONS-1:0] decouple;

// ----------------------------------------------------------------------
// HOST 
// ----------------------------------------------------------------------
// XDMA host sync
dmaIntf rdXDMA_host();
dmaIntf wrXDMA_host();

assign host_xdma_req.h2c_ctl           = {{11{1'b0}}, rdXDMA_host.req.ctl, {2{1'b0}}, {2{rdXDMA_host.req.ctl}}};
assign host_xdma_req.h2c_addr          = rdXDMA_host.req.paddr;
assign host_xdma_req.at                = rdXDMA_host.req.at;
assign host_xdma_req.h2c_len           = rdXDMA_host.req.len;
assign host_xdma_req.h2c_valid         = rdXDMA_host.valid;


assign host_xdma_req.c2h_ctl           = {{11{1'b0}}, wrXDMA_host.req.ctl, {2{1'b0}}, {2{wrXDMA_host.req.ctl}}};
assign host_xdma_req.c2h_addr          = wrXDMA_host.req.paddr;
assign host_xdma_req.c2h_len           = wrXDMA_host.req.len;
assign host_xdma_req.c2h_valid         = wrXDMA_host.valid;

assign rdXDMA_host.ready               = host_xdma_req.h2c_ready;
assign wrXDMA_host.ready               = host_xdma_req.c2h_ready;
assign rdXDMA_host.done                = host_xdma_req.h2c_status[1];
assign wrXDMA_host.done                = host_xdma_req.c2h_status[1];

// Slice host 0 
// ----------------------------------------------------------------------
AXI4S axis_host_s0_in();
AXI4S axis_host_s0_out();
axis_reg_array #(.N_STAGES(N_REG_HOST_S0)) inst_host_reg_s0_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_host_out), .axis_out(axis_host_s0_out));
axis_reg_array #(.N_STAGES(N_REG_HOST_S0)) inst_host_reg_s0_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_host_s0_in), .axis_out(axis_host_in));

// Multiplexing 
// ----------------------------------------------------------------------
AXI4S axis_host_s1_in [N_REGIONS] ();
AXI4S axis_host_s1_out [N_REGIONS] ();
`AXIS_ASSIGN(axis_host_s0_out, axis_host_s1_out[0])
`AXIS_ASSIGN(axis_host_s1_in[0], axis_host_s0_in)

// Credits 
// ----------------------------------------------------------------------
AXI4SR axis_host_s2_in [N_REGIONS] ();
AXI4SR axis_host_s2_out [N_REGIONS] ();
logic [N_REGIONS-1:0] rxfer_host;
logic [N_REGIONS-1:0] wxfer_host;
logic [N_REGIONS-1:0][3:0] rd_dest_host;
for(genvar i = 0; i < N_REGIONS; i++) begin
  data_queue_credits_src inst_cred_que_host_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_host_s1_out[i]), .axis_out(axis_host_s2_out[i]), .rd_dest(rd_dest_host[i]));
  data_queue_credits_sink inst_cred_que_host_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_host_s2_in[i]), .axis_out(axis_host_s1_in[i]));
  assign rxfer_host[i] = axis_host_s2_out[i].tvalid & axis_host_s2_out[i].tready;
  assign wxfer_host[i] = axis_host_s2_in[i].tvalid & axis_host_s2_in[i].tready;
end

// Slice host 1 
// ----------------------------------------------------------------------
AXI4SR axis_host_s3_in [N_REGIONS] ();
AXI4SR axis_host_s3_out [N_REGIONS] ();
for(genvar i = 0; i < N_REGIONS; i++) begin
  axisr_reg_array #(.N_STAGES(N_REG_HOST_S1)) inst_host_reg_s1_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_host_s2_out[i]), .axis_out(axis_host_s3_out[i]));
  axisr_reg_array #(.N_STAGES(N_REG_HOST_S1)) inst_host_reg_s1_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_host_s3_in[i]), .axis_out(axis_host_s2_in[i]));
end

// Decoupling 
// ----------------------------------------------------------------------
AXI4SR axis_host_dcpl_in [N_REGIONS] ();
AXI4SR axis_host_dcpl_out [N_REGIONS] ();
for(genvar i = 0; i < N_REGIONS; i++) begin
  `AXISR_ASSIGN(axis_host_s3_out[i], axis_host_dcpl_out[i])
  `AXISR_ASSIGN(axis_host_dcpl_in[i], axis_host_s3_in[i])
end

// ----------------------------------------------------------------------
// CARD 
// ----------------------------------------------------------------------
// XDMA card sync
dmaIntf rdXDMA_sync();
dmaIntf wrXDMA_sync();

assign card_xdma_req.h2c_ctl           = {{11{1'b0}}, rdXDMA_sync.req.ctl, {2{1'b0}}, {2{rdXDMA_sync.req.ctl}}};
assign card_xdma_req.h2c_addr          = rdXDMA_sync.req.paddr;
assign card_xdma_req.h2c_len           = rdXDMA_sync.req.len;
assign card_xdma_req.h2c_valid         = rdXDMA_sync.valid;

assign card_xdma_req.c2h_ctl           = {{11{1'b0}}, wrXDMA_sync.req.ctl, {2{1'b0}}, {2{wrXDMA_sync.req.ctl}}};
assign card_xdma_req.c2h_addr          = wrXDMA_sync.req.paddr;
assign card_xdma_req.c2h_len           = wrXDMA_sync.req.len;
assign card_xdma_req.c2h_valid         = wrXDMA_sync.valid;

assign rdXDMA_sync.ready               = card_xdma_req.h2c_ready;
assign wrXDMA_sync.ready               = card_xdma_req.c2h_ready;
assign rdXDMA_sync.done                = card_xdma_req.h2c_status[1];
assign wrXDMA_sync.done                = card_xdma_req.c2h_status[1];

// Slice card 0 
// ----------------------------------------------------------------------
AXI4S axis_card_s0_in();
AXI4S axis_card_s0_out();
axis_reg_array #(.N_STAGES(N_REG_CARD_S0)) inst_card_reg_s0_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_out), .axis_out(axis_card_s0_out));
axis_reg_array #(.N_STAGES(N_REG_CARD_S0)) inst_card_reg_s0_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s0_in), .axis_out(axis_card_in));

// Card memory
// ----------------------------------------------------------------------
dmaIntf rdCDMA_sync ();
dmaIntf wrCDMA_sync ();
dmaIntf rdCDMA_sync_adj [N_DDR_CHAN] ();
dmaIntf wrCDMA_sync_adj [N_DDR_CHAN] ();
dmaIntf rdCDMA_card ();
dmaIntf wrCDMA_card ();
dmaIntf rdCDMA_card_adj [N_DDR_CHAN] ();
dmaIntf wrCDMA_card_adj [N_DDR_CHAN] ();

AXI4S #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s1_in();
AXI4S #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s1_out();
AXI4S axis_ddr_in [N_DDR_CHAN*2] ();
AXI4S axis_ddr_out [N_DDR_CHAN*2] ();

`AXIS_ASSIGN(axis_card_s0_out, axis_ddr_in[0])
`AXIS_ASSIGN(axis_ddr_out[0], axis_card_s0_in)
`AXIS_ASSIGN(axis_card_s1_in, axis_ddr_in[N_DDR_CHAN])
`AXIS_ASSIGN(axis_ddr_out[N_DDR_CHAN], axis_card_s1_out)

`DMA_REQ_ASSIGN(rdCDMA_sync, rdCDMA_sync_adj[0])
`DMA_REQ_ASSIGN(wrCDMA_sync, wrCDMA_sync_adj[0])
`DMA_REQ_ASSIGN(rdCDMA_card, rdCDMA_card_adj[0])
`DMA_REQ_ASSIGN(wrCDMA_card, wrCDMA_card_adj[0])

for(genvar i = 0; i < N_DDR_CHAN; i++) begin
  // CDMA sync
  cdma inst_cdma_sync_engine (
     .aclk(aclk),
    .aresetn(aresetn),
    .rdCDMA(rdCDMA_sync_adj[i]),
    .wrCDMA(wrCDMA_sync_adj[i]),
    .axi_ddr_in(axi_ddr_in[i]),
    .axis_ddr_in(axis_ddr_in[i]),
    .axis_ddr_out(axis_ddr_out[i])
  );

  // CDMA user
  cdma inst_cdma_user_engine (
    .aclk(aclk),
    .aresetn(aresetn),
    .rdCDMA(rdCDMA_card_adj[i]),
    .wrCDMA(wrCDMA_card_adj[i]),
    .axi_ddr_in(axi_ddr_in[N_DDR_CHAN+i]),
    .axis_ddr_in(axis_ddr_in[N_DDR_CHAN+i]),
    .axis_ddr_out(axis_ddr_out[N_DDR_CHAN+i])
  );
end

// Slice card 1 
// ----------------------------------------------------------------------
AXI4S #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s2_in();
AXI4S #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s2_out();
axis_reg_array #(.N_STAGES(N_REG_CARD_S1), .DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) inst_card_reg_s1_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s1_out), .axis_out(axis_card_s2_out));
axis_reg_array #(.N_STAGES(N_REG_CARD_S1), .DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) inst_card_reg_s1_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s2_in), .axis_out(axis_card_s1_in));

// Multiplexing 
// ----------------------------------------------------------------------
AXI4S #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s3_in [N_REGIONS] ();
AXI4S #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s3_out [N_REGIONS] ();
`AXIS_ASSIGN(axis_card_s2_out, axis_card_s3_out[0])
`AXIS_ASSIGN(axis_card_s3_in[0], axis_card_s2_in)

// Credits 
// ----------------------------------------------------------------------
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s4_in [N_REGIONS] ();
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s4_out [N_REGIONS] ();
logic [N_REGIONS-1:0] rxfer_card;
logic [N_REGIONS-1:0] wxfer_card;
logic [N_REGIONS-1:0][3:0] rd_dest_card;
for(genvar i = 0; i < N_REGIONS; i++) begin
  data_queue_credits_src #(.DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) inst_cred_que_card_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s3_out[i]), .axis_out(axis_card_s4_out[i]), .rd_dest(rd_dest_card[i]));
  data_queue_credits_sink #(.DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) inst_cred_que_card_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s4_in[i]), .axis_out(axis_card_s3_in[i]));
  assign rxfer_card[i] = axis_card_s4_out[i].tvalid & axis_card_s4_out[i].tready;
  assign wxfer_card[i] = axis_card_s4_in[i].tvalid & axis_card_s4_in[i].tready;
end

// Slice card 2 
// ----------------------------------------------------------------------
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s5_in [N_REGIONS] ();
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_s5_out [N_REGIONS] ();
for(genvar i = 0; i < N_REGIONS; i++) begin
  axisr_reg_array #(.N_STAGES(N_REG_CARD_S2), .DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) inst_card_reg_s2_out (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s4_out[i]), .axis_out(axis_card_s5_out[i]));
  axisr_reg_array #(.N_STAGES(N_REG_CARD_S2), .DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) inst_card_reg_s2_in (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_card_s5_in[i]), .axis_out(axis_card_s4_in[i]));
end

// Decoupling 
// ----------------------------------------------------------------------
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_dcpl_in [N_REGIONS] ();
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_dcpl_out [N_REGIONS] ();
for(genvar i = 0; i < N_REGIONS; i++) begin
  `AXISR_ASSIGN(axis_card_s5_out[i], axis_card_dcpl_out[i])
  `AXISR_ASSIGN(axis_card_dcpl_in[i], axis_card_s5_in[i])
end

// ----------------------------------------------------------------------
// Rest of decoupling 
// ----------------------------------------------------------------------
AXI4L axi_ctrl_dcpl [N_REGIONS] ();
reqIntf rd_req_user [N_REGIONS] ();
reqIntf wr_req_user [N_REGIONS] ();
reqIntf rd_req_dcpl_user [N_REGIONS] ();
reqIntf wr_req_dcpl_user [N_REGIONS] ();
for(genvar i = 0; i < N_REGIONS; i++) begin
  `AXIL_ASSIGN(axi_ctrl_user[i], axi_ctrl_dcpl[i])
  `REQ_ASSIGN(rd_req_dcpl_user[i], rd_req_user[i])
  `REQ_ASSIGN(wr_req_dcpl_user[i], wr_req_user[i])
end

// ----------------------------------------------------------------------
// MMU 
// ----------------------------------------------------------------------
tlb_top #(
  .ID_DYN(ID_DYN)
) inst_tlb_top (
  .aclk(aclk),
  .aresetn(aresetn),
  .axi_ctrl_lTlb(axi_ctrl_lTlb),
  .axi_ctrl_sTlb(axi_ctrl_sTlb),
  .axim_ctrl_cnfg(axim_ctrl),
  .rd_req_user(rd_req_user),
  .wr_req_user(wr_req_user),
  .rdXDMA_host(rdXDMA_host),
  .wrXDMA_host(wrXDMA_host),
  .rxfer_host(rxfer_host),
  .wxfer_host(wxfer_host),
  .rd_dest_host(rd_dest_host),
  .rdXDMA_sync(rdXDMA_sync),
  .wrXDMA_sync(wrXDMA_sync),
  .rdCDMA_sync(rdCDMA_sync),
  .wrCDMA_sync(wrCDMA_sync),
  .rdCDMA_card(rdCDMA_card),
  .wrCDMA_card(wrCDMA_card),
  .rxfer_card(rxfer_card),
  .wxfer_card(wxfer_card),
  .rd_dest_card(rd_dest_card),
  .decouple(decouple),
  .pf_irq(usr_irq)
);

// ----------------------------------------------------------------------
// USER 
// ----------------------------------------------------------------------
// User logic wrappers 
design_user_wrapper_0 inst_user_wrapper_0 (
  .axi_ctrl_araddr      (axi_ctrl_dcpl[0].araddr),
  .axi_ctrl_arprot      (axi_ctrl_dcpl[0].arprot),
  .axi_ctrl_arready     (axi_ctrl_dcpl[0].arready),
  .axi_ctrl_arvalid     (axi_ctrl_dcpl[0].arvalid),
  .axi_ctrl_awaddr      (axi_ctrl_dcpl[0].awaddr),
  .axi_ctrl_awprot      (axi_ctrl_dcpl[0].awprot),
  .axi_ctrl_awready     (axi_ctrl_dcpl[0].awready),
  .axi_ctrl_awvalid     (axi_ctrl_dcpl[0].awvalid),
  .axi_ctrl_bready      (axi_ctrl_dcpl[0].bready),
  .axi_ctrl_bresp       (axi_ctrl_dcpl[0].bresp),
  .axi_ctrl_bvalid      (axi_ctrl_dcpl[0].bvalid),
  .axi_ctrl_rdata       (axi_ctrl_dcpl[0].rdata),
  .axi_ctrl_rready      (axi_ctrl_dcpl[0].rready),
  .axi_ctrl_rresp       (axi_ctrl_dcpl[0].rresp),
  .axi_ctrl_rvalid      (axi_ctrl_dcpl[0].rvalid),
  .axi_ctrl_wdata       (axi_ctrl_dcpl[0].wdata),
  .axi_ctrl_wready      (axi_ctrl_dcpl[0].wready),
  .axi_ctrl_wstrb       (axi_ctrl_dcpl[0].wstrb),
  .axi_ctrl_wvalid      (axi_ctrl_dcpl[0].wvalid),
  .rd_req_user_valid	   (rd_req_dcpl_user[0].valid),
  .rd_req_user_ready	   (rd_req_dcpl_user[0].ready),
  .rd_req_user_req		   (rd_req_dcpl_user[0].req),
  .wr_req_user_valid	   (wr_req_dcpl_user[0].valid),
  .wr_req_user_ready	   (wr_req_dcpl_user[0].ready),
  .wr_req_user_req		   (wr_req_dcpl_user[0].req),
  .axis_host_src_tdata       (axis_host_dcpl_in[0].tdata),
  .axis_host_src_tkeep       (axis_host_dcpl_in[0].tkeep),
  .axis_host_src_tlast       (axis_host_dcpl_in[0].tlast),
  .axis_host_src_tdest       (axis_host_dcpl_in[0].tdest),
  .axis_host_src_tready      (axis_host_dcpl_in[0].tready),
  .axis_host_src_tvalid      (axis_host_dcpl_in[0].tvalid),
  .axis_host_sink_tdata      (axis_host_dcpl_out[0].tdata),
  .axis_host_sink_tkeep      (axis_host_dcpl_out[0].tkeep),
  .axis_host_sink_tlast      (axis_host_dcpl_out[0].tlast),
  .axis_host_sink_tdest      (axis_host_dcpl_out[0].tdest),
  .axis_host_sink_tready     (axis_host_dcpl_out[0].tready),
  .axis_host_sink_tvalid     (axis_host_dcpl_out[0].tvalid),
  .axis_card_src_tdata       (axis_card_dcpl_in[0].tdata),
  .axis_card_src_tkeep       (axis_card_dcpl_in[0].tkeep),
  .axis_card_src_tlast       (axis_card_dcpl_in[0].tlast),
  .axis_card_src_tdest       (axis_card_dcpl_in[0].tdest),
  .axis_card_src_tready      (axis_card_dcpl_in[0].tready),
  .axis_card_src_tvalid      (axis_card_dcpl_in[0].tvalid),
  .axis_card_sink_tdata      (axis_card_dcpl_out[0].tdata),
  .axis_card_sink_tkeep      (axis_card_dcpl_out[0].tkeep),
  .axis_card_sink_tlast      (axis_card_dcpl_out[0].tlast),
  .axis_card_sink_tdest      (axis_card_dcpl_out[0].tdest),
  .axis_card_sink_tready     (axis_card_dcpl_out[0].tready),
  .axis_card_sink_tvalid     (axis_card_dcpl_out[0].tvalid),
  .aclk                 (aclk),
  .aresetn              (aresetn)
);

// ----------------------------------------------------------------------
// Control crossbar - move to new file maybe 
// ----------------------------------------------------------------------
// Crossbar out
logic[N_REGIONS-1:0][3*AXI_ADDR_BITS-1:0]                  axi_xbar_araddr;
logic[N_REGIONS-1:0][8:0]                                 axi_xbar_arprot;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_arready;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_arvalid;
logic[N_REGIONS-1:0][3*AXI_ADDR_BITS-1:0]                  axi_xbar_awaddr;
logic[N_REGIONS-1:0][8:0]                                 axi_xbar_awprot;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_awready;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_awvalid;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_bready;
logic[N_REGIONS-1:0][5:0]                                  axi_xbar_bresp;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_bvalid;
logic[N_REGIONS-1:0][3*AXIL_DATA_BITS-1:0]                 axi_xbar_rdata;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_rready;
logic[N_REGIONS-1:0][5:0]                                  axi_xbar_rresp;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_rvalid;
logic[N_REGIONS-1:0][3*AXIL_DATA_BITS-1:0]                 axi_xbar_wdata;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_wready;
logic[N_REGIONS-1:0][3*(AXIL_DATA_BITS/8)-1:0]             axi_xbar_wstrb;
logic[N_REGIONS-1:0][2:0]                                  axi_xbar_wvalid;

for(genvar i = 0; i < N_REGIONS; i++) begin

// lTlb
assign axi_ctrl_lTlb[i].araddr               = axi_xbar_araddr[i][AXI_ADDR_BITS-1:0];
assign axi_ctrl_lTlb[i].arprot               = axi_xbar_arprot[i][2:0];
assign axi_ctrl_lTlb[i].arvalid              = axi_xbar_arvalid[i][0];
assign axi_ctrl_lTlb[i].awaddr               = axi_xbar_awaddr[i][AXI_ADDR_BITS-1:0];
assign axi_ctrl_lTlb[i].awprot               = axi_xbar_awprot[i][2:0];
assign axi_ctrl_lTlb[i].awvalid              = axi_xbar_awvalid[i][0];
assign axi_ctrl_lTlb[i].bready               = axi_xbar_bready[i][0];
assign axi_ctrl_lTlb[i].rready               = axi_xbar_rready[i][0];
assign axi_ctrl_lTlb[i].wdata                = axi_xbar_wdata[i][AXIL_DATA_BITS-1:0];
assign axi_ctrl_lTlb[i].wstrb                = axi_xbar_wstrb[i][(AXIL_DATA_BITS/8)-1:0];
assign axi_ctrl_lTlb[i].wvalid               = axi_xbar_wvalid[i][0];

assign axi_xbar_arready[i][0]                = axi_ctrl_lTlb[i].arready;
assign axi_xbar_awready[i][0]                = axi_ctrl_lTlb[i].awready;
assign axi_xbar_bresp[i][1:0]                = axi_ctrl_lTlb[i].bresp;
assign axi_xbar_bvalid[i][0]                 = axi_ctrl_lTlb[i].bvalid;
assign axi_xbar_rdata[i][AXIL_DATA_BITS-1:0] = axi_ctrl_lTlb[i].rdata;
assign axi_xbar_rresp[i][1:0]                = axi_ctrl_lTlb[i].rresp;
assign axi_xbar_rvalid[i][0]                 = axi_ctrl_lTlb[i].rvalid;
assign axi_xbar_wready[i][0]                 = axi_ctrl_lTlb[i].wready;

// sTlb
assign axi_ctrl_sTlb[i].araddr               = axi_xbar_araddr[i][2*AXI_ADDR_BITS-1:AXI_ADDR_BITS];
assign axi_ctrl_sTlb[i].arprot               = axi_xbar_arprot[i][5:3];
assign axi_ctrl_sTlb[i].arvalid              = axi_xbar_arvalid[i][1];
assign axi_ctrl_sTlb[i].awaddr               = axi_xbar_awaddr[i][2*AXI_ADDR_BITS-1:AXI_ADDR_BITS];
assign axi_ctrl_sTlb[i].awprot               = axi_xbar_awprot[i][5:3];
assign axi_ctrl_sTlb[i].awvalid              = axi_xbar_awvalid[i][1];
assign axi_ctrl_sTlb[i].bready               = axi_xbar_bready[i][1];
assign axi_ctrl_sTlb[i].rready               = axi_xbar_rready[i][1];
assign axi_ctrl_sTlb[i].wdata                = axi_xbar_wdata[i][2*AXIL_DATA_BITS-1:AXIL_DATA_BITS];
assign axi_ctrl_sTlb[i].wstrb                = axi_xbar_wstrb[i][2*(AXIL_DATA_BITS/8)-1:AXIL_DATA_BITS/8];
assign axi_ctrl_sTlb[i].wvalid               = axi_xbar_wvalid[i][1];

assign axi_xbar_arready[i][1]                = axi_ctrl_sTlb[i].arready;
assign axi_xbar_awready[i][1]                = axi_ctrl_sTlb[i].awready;
assign axi_xbar_bresp[i][3:2]                = axi_ctrl_sTlb[i].bresp;
assign axi_xbar_bvalid[i][1]                 = axi_ctrl_sTlb[i].bvalid;
assign axi_xbar_rdata[i][2*AXIL_DATA_BITS-1:AXIL_DATA_BITS] = axi_ctrl_sTlb[i].rdata;
assign axi_xbar_rresp[i][3:2]                = axi_ctrl_sTlb[i].rresp;
assign axi_xbar_rvalid[i][1]                 = axi_ctrl_sTlb[i].rvalid;
assign axi_xbar_wready[i][1]                 = axi_ctrl_sTlb[i].wready;

// User logic
assign axi_ctrl_user[i].araddr               = axi_xbar_araddr[i][3*AXI_ADDR_BITS-1:2*AXI_ADDR_BITS];
assign axi_ctrl_user[i].arprot               = axi_xbar_arprot[i][8:6];
assign axi_ctrl_user[i].arvalid              = axi_xbar_arvalid[i][2];
assign axi_ctrl_user[i].awaddr               = axi_xbar_awaddr[i][3*AXI_ADDR_BITS-1:2*AXI_ADDR_BITS];
assign axi_ctrl_user[i].awprot               = axi_xbar_awprot[i][8:6];
assign axi_ctrl_user[i].awvalid              = axi_xbar_awvalid[i][2];
assign axi_ctrl_user[i].bready               = axi_xbar_bready[i][2];
assign axi_ctrl_user[i].rready               = axi_xbar_rready[i][2];
assign axi_ctrl_user[i].wdata                = axi_xbar_wdata[i][3*AXIL_DATA_BITS-1:2*AXIL_DATA_BITS];
assign axi_ctrl_user[i].wstrb                = axi_xbar_wstrb[i][3*(AXIL_DATA_BITS/8)-1:2*(AXIL_DATA_BITS/8)];
assign axi_ctrl_user[i].wvalid               = axi_xbar_wvalid[i][2];

assign axi_xbar_arready[i][2]                = axi_ctrl_user[i].arready;
assign axi_xbar_awready[i][2]                = axi_ctrl_user[i].awready;
assign axi_xbar_bresp[i][5:4]                = axi_ctrl_user[i].bresp;
assign axi_xbar_bvalid[i][2]                 = axi_ctrl_user[i].bvalid;
assign axi_xbar_rdata[i][3*AXIL_DATA_BITS-1:2*AXIL_DATA_BITS] = axi_ctrl_user[i].rdata;
assign axi_xbar_rresp[i][5:4]                = axi_ctrl_user[i].rresp;
assign axi_xbar_rvalid[i][2]                 = axi_ctrl_user[i].rvalid;
assign axi_xbar_wready[i][2]                 = axi_ctrl_user[i].wready;

end

dyn_crossbar_0 inst_dyn_crossbar_0 (
  .aclk(aclk),                    
  .aresetn(aresetn),             
  .s_axi_awaddr(axi_ctrl[0].awaddr),    
  .s_axi_awprot(axi_ctrl[0].awprot),    
  .s_axi_awvalid(axi_ctrl[0].awvalid),  
  .s_axi_awready(axi_ctrl[0].awready),  
  .s_axi_wdata(axi_ctrl[0].wdata),      
  .s_axi_wstrb(axi_ctrl[0].wstrb),      
  .s_axi_wvalid(axi_ctrl[0].wvalid),    
  .s_axi_wready(axi_ctrl[0].wready),    
  .s_axi_bresp(axi_ctrl[0].bresp),      
  .s_axi_bvalid(axi_ctrl[0].bvalid),    
  .s_axi_bready(axi_ctrl[0].bready),    
  .s_axi_araddr(axi_ctrl[0].araddr),    
  .s_axi_arprot(axi_ctrl[0].arprot),    
  .s_axi_arvalid(axi_ctrl[0].arvalid),  
  .s_axi_arready(axi_ctrl[0].arready),  
  .s_axi_rdata(axi_ctrl[0].rdata),      
  .s_axi_rresp(axi_ctrl[0].rresp),      
  .s_axi_rvalid(axi_ctrl[0].rvalid),    
  .s_axi_rready(axi_ctrl[0].rready),    
  .m_axi_awaddr(axi_xbar_awaddr[0]),    
  .m_axi_awprot(axi_xbar_awprot[0]),    
  .m_axi_awvalid(axi_xbar_awvalid[0]),  
  .m_axi_awready(axi_xbar_awready[0]),  
  .m_axi_wdata(axi_xbar_wdata[0]),      
  .m_axi_wstrb(axi_xbar_wstrb[0]),      
  .m_axi_wvalid(axi_xbar_wvalid[0]),    
  .m_axi_wready(axi_xbar_wready[0]),    
  .m_axi_bresp(axi_xbar_bresp[0]),      
  .m_axi_bvalid(axi_xbar_bvalid[0]),    
  .m_axi_bready(axi_xbar_bready[0]),    
  .m_axi_araddr(axi_xbar_araddr[0]),    
  .m_axi_arprot(axi_xbar_arprot[0]),    
  .m_axi_arvalid(axi_xbar_arvalid[0]),  
  .m_axi_arready(axi_xbar_arready[0]),  
  .m_axi_rdata(axi_xbar_rdata[0]),      
  .m_axi_rresp(axi_xbar_rresp[0]),      
  .m_axi_rvalid(axi_xbar_rvalid[0]),    
  .m_axi_rready(axi_xbar_rready[0])
);


endmodule


