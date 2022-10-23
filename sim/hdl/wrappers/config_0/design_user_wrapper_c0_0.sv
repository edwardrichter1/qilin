`timescale 1ns / 1ps

import lynxTypes::*;

/**
 * User logic wrapper
 * 
 */
module design_user_wrapper_0 #(
) (
    // AXI4 control
    input  logic[AXI_ADDR_BITS-1:0]         axi_ctrl_araddr,
    input  logic[2:0]                       axi_ctrl_arprot,
    output logic                            axi_ctrl_arready,
    input  logic                            axi_ctrl_arvalid,
    input  logic[AXI_ADDR_BITS-1:0]         axi_ctrl_awaddr,
    input  logic[2:0]                       axi_ctrl_awprot,
    output logic                            axi_ctrl_awready,
    input  logic                            axi_ctrl_awvalid, 
    input  logic                            axi_ctrl_bready,
    output logic[1:0]                       axi_ctrl_bresp,
    output logic                            axi_ctrl_bvalid,
    output logic[AXI_ADDR_BITS-1:0]        axi_ctrl_rdata,
    input  logic                            axi_ctrl_rready,
    output logic[1:0]                       axi_ctrl_rresp,
    output logic                            axi_ctrl_rvalid,
    input  logic[AXIL_DATA_BITS-1:0]        axi_ctrl_wdata,
    output logic                            axi_ctrl_wready,
    input  logic[(AXIL_DATA_BITS/8)-1:0]    axi_ctrl_wstrb,
    input  logic                            axi_ctrl_wvalid,

    // Descriptor bypass
	   output logic 							rd_req_user_valid,
	   input  logic 							rd_req_user_ready,
	   output req_t 							rd_req_user_req,
	   output logic 							wr_req_user_valid,
	   input  logic 							wr_req_user_ready,
	   output req_t 							wr_req_user_req,

    // AXI4S HOST src
    output logic[AXI_DATA_BITS-1:0]        axis_host_src_tdata,
    output logic[AXI_DATA_BITS/8-1:0]      axis_host_src_tkeep,
    output logic                            axis_host_src_tlast,
    output logic[3:0]                      axis_host_src_tdest,
    input  logic                            axis_host_src_tready,
    output logic                            axis_host_src_tvalid,

    // AXI4S HOST sink
    input  logic[AXI_DATA_BITS-1:0]        axis_host_sink_tdata,
    input  logic[AXI_DATA_BITS/8-1:0]      axis_host_sink_tkeep,
    input  logic                            axis_host_sink_tlast,
    input  logic[3:0]                      axis_host_sink_tdest,
    output logic                            axis_host_sink_tready,
    input  logic                            axis_host_sink_tvalid,

    // AXI4S CARD src
    output logic[N_DDR_CHAN*AXI_DATA_BITS-1:0]        axis_card_src_tdata,
    output logic[N_DDR_CHAN*AXI_DATA_BITS/8-1:0]      axis_card_src_tkeep,
    output logic                            axis_card_src_tlast,
    output logic[3:0]                      axis_card_src_tdest,
    input  logic                            axis_card_src_tready,
    output logic                            axis_card_src_tvalid,

    // AXI4S CARD sink
    input  logic[N_DDR_CHAN*AXI_DATA_BITS-1:0]        axis_card_sink_tdata,
    input  logic[N_DDR_CHAN*AXI_DATA_BITS/8-1:0]      axis_card_sink_tkeep,
    input  logic                            axis_card_sink_tlast,
    input  logic[3:0]                      axis_card_sink_tdest,
    output logic                            axis_card_sink_tready,
    input  logic                            axis_card_sink_tvalid,

    // Clock and reset
    input  logic                            aclk,
    input  logic[0:0]                       aresetn
);

// Control
AXI4L axi_ctrl_user();

assign axi_ctrl_user.araddr                   = axi_ctrl_araddr;
assign axi_ctrl_user.arprot                   = axi_ctrl_arprot;
assign axi_ctrl_user.arvalid                  = axi_ctrl_arvalid;
assign axi_ctrl_user.awaddr                   = axi_ctrl_awaddr;
assign axi_ctrl_user.awprot                   = axi_ctrl_awprot;
assign axi_ctrl_user.awvalid                  = axi_ctrl_awvalid;
assign axi_ctrl_user.bready                   = axi_ctrl_bready;
assign axi_ctrl_user.rready                   = axi_ctrl_rready;
assign axi_ctrl_user.wdata                    = axi_ctrl_wdata;
assign axi_ctrl_user.wstrb                    = axi_ctrl_wstrb;
assign axi_ctrl_user.wvalid                   = axi_ctrl_wvalid;

assign axi_ctrl_arready                     = axi_ctrl_user.arready;
assign axi_ctrl_awready                     = axi_ctrl_user.awready;
assign axi_ctrl_bresp                       = axi_ctrl_user.bresp;
assign axi_ctrl_bvalid                      = axi_ctrl_user.bvalid;
assign axi_ctrl_rdata                       = axi_ctrl_user.rdata;
assign axi_ctrl_rresp                       = axi_ctrl_user.rresp;
assign axi_ctrl_rvalid                      = axi_ctrl_user.rvalid;
assign axi_ctrl_wready                      = axi_ctrl_user.wready;

// Descriptor bypass
reqIntf rd_req_user();
reqIntf wr_req_user();

assign rd_req_user_valid = rd_req_user.valid;
assign rd_req_user.ready = rd_req_user_ready;
assign rd_req_user_req = rd_req_user.req;
assign wr_req_user_valid = wr_req_user.valid;
assign wr_req_user.ready = wr_req_user_ready;
assign wr_req_user_req = wr_req_user.req;

// AXIS host source
AXI4SR axis_host_src();

assign axis_host_src_tdata                  = axis_host_src.tdata;
assign axis_host_src_tkeep                  = axis_host_src.tkeep;
assign axis_host_src_tlast                  = axis_host_src.tlast;
assign axis_host_src_tdest                  = axis_host_src.tdest;
assign axis_host_src_tvalid                 = axis_host_src.tvalid;

assign axis_host_src.tready                 = axis_host_src_tready;

// AXIS host sink
AXI4SR axis_host_sink();

assign axis_host_sink.tdata                 = axis_host_sink_tdata;
assign axis_host_sink.tkeep                 = axis_host_sink_tkeep;
assign axis_host_sink.tlast                 = axis_host_sink_tlast;
assign axis_host_sink.tdest                 = axis_host_sink_tdest;
assign axis_host_sink.tvalid                = axis_host_sink_tvalid;

assign axis_host_sink_tready                = axis_host_sink.tready;

// AXIS card source
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_src();

assign axis_card_src_tdata                  = axis_card_src.tdata;
assign axis_card_src_tkeep                  = axis_card_src.tkeep;
assign axis_card_src_tlast                  = axis_card_src.tlast;
assign axis_card_src_tdest                  = axis_card_src.tdest;
assign axis_card_src_tvalid                 = axis_card_src.tvalid;

assign axis_card_src.tready                 = axis_card_src_tready;

// AXIS card sink
AXI4SR #(.AXI4S_DATA_BITS(N_DDR_CHAN*AXI_DATA_BITS)) axis_card_sink();

assign axis_card_sink.tdata                 = axis_card_sink_tdata;
assign axis_card_sink.tkeep                 = axis_card_sink_tkeep;
assign axis_card_sink.tlast                 = axis_card_sink_tlast;
assign axis_card_sink.tdest                 = axis_card_sink_tdest;
assign axis_card_sink.tvalid                = axis_card_sink_tvalid;

assign axis_card_sink_tready                = axis_card_sink.tready;

// USER LOGIC
design_user_logic_0 inst_user_0 (
  .axi_ctrl(axi_ctrl_user),
  .rd_req_user(rd_req_user),
  .wr_req_user(wr_req_user),
  .axis_host_src(axis_host_src),
  .axis_host_sink(axis_host_sink),
  .axis_card_src(axis_card_src),
  .axis_card_sink(axis_card_sink),
  .aclk(aclk),
  .aresetn(aresetn)
);


endmodule


