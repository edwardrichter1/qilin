`timescale 1ns / 1ps

import lynxTypes::*;

`include "axi_macros.svh"
`include "lynx_macros.svh"
//
// Top Level
//
module top (

    /*output wire         c0_ddr4_act_n,
    output wire [16:0]  c0_ddr4_adr,
    output wire [1:0]   c0_ddr4_ba,
    output wire [1:0]   c0_ddr4_bg,
    output wire [0:0]   c0_ddr4_ck_c,
    output wire [0:0]   c0_ddr4_ck_t,
    output wire [0:0]   c0_ddr4_cke,
	output wire [0:0]   c0_ddr4_cs_n,
	inout  wire [71:0]  c0_ddr4_dq,
	inout  wire [17:0]  c0_ddr4_dqs_c,
	inout  wire [17:0]  c0_ddr4_dqs_t,
	output wire [0:0]   c0_ddr4_odt,
	output wire         c0_ddr4_par,
	output wire         c0_ddr4_reset_n,
	input  wire         c0_sys_clk_p,
    input  wire         c0_sys_clk_n,*/

    output wire         fpga_burn,
    input  wire[0:0]   pcie_clk_clk_n,
    input  wire[0:0]   pcie_clk_clk_p,
    input  wire[15:0]  pcie_x16_rxn,
    input  wire[15:0]  pcie_x16_rxp,
    output wire[15:0]  pcie_x16_txn,
    output wire[15:0]  pcie_x16_txp,
    input  wire        perst_n_nb,
    input  wire        resetn_0_nb,
    input wire         UART_0_rxd,
    output wire        UART_0_txd,
    
    // PIPE interface to speedup sim
    output  wire[25:0]pcie_ext_pipe_ep_usp_0_commands_in,
    input   wire[25:0]pcie_ext_pipe_ep_usp_0_commands_out,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_0,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_1,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_10,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_11,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_12,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_13,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_14,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_15,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_2,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_3,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_4,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_5,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_6,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_7,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_8,
    output  wire [83:0]pcie_ext_pipe_ep_usp_0_rx_9,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_0,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_1,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_10,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_11,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_12,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_13,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_14,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_15,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_2,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_3,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_4,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_5,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_6,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_7,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_8,
    input   wire [83:0]pcie_ext_pipe_ep_usp_0_tx_9
);

     
    // AXI resetn
    wire[0:0] aresetn;
    // AXI clk (250 MHz)
    wire aclk;

    // IRQ
    wire[N_REGIONS-1:0] usr_irq;

    wire resetn_0;
    wire perst_n;

    // Static config
    AXI4L axi_cnfg ();

    // Application control
    AXI4L axi_ctrl [N_REGIONS] ();

    // Application control AVX
    AXI4 #(.AXI4_DATA_BITS(AVX_DATA_BITS)) axim_ctrl [N_REGIONS] ();

    // Stream to application
    AXI4S axis_dyn_out[N_CHAN] ();

    // Stream from application
    AXI4S axis_dyn_in[N_CHAN] ();

    // Descriptor bypass
    xdmaIntf xdma_req [N_CHAN] ();
    
    // DDR AXI mm
    AXI4 axi_ddr_in[2*N_DDR_CHAN] ();

    // IO buffers
    IBUF rst_IBUF_inst (
        .O(resetn_0), // Buffer output
        .I(resetn_0_nb) // Buffer input (connect directly to top-level port)
    );

    IBUF perst_n_IBUF_inst (
    	   .O(perst_n),
    	   .I(perst_n_nb)
    );

    // The notorius D32 pin
    assign fpga_burn = 1'b0;
    
   
    // -----------------------------------------------------------------
    // TKEEP CONVERSION
    // Have to convert between mty + zero_byte and tkeep
    // WHYYYYY XILINX :(
    // -----------------------------------------------------------------
    // Moving this into the block design
    // Will store the tkeep if zero_byte is 1
    /*reg  [63:0] coyote_tkeep_temp;
    wire [5:0]  qdma_mty;
    wire        qdma_zero_byte;

    // If zero-byte is high than we are not sending any data
    assign axis_dyn_out[0].tkeep = coyote_tkeep_temp & ~{64{qdma_zero_byte}};

    integer i;

    // Setting tkeep based on the number of invalid bytes (mty)
    always@(*) begin
        for(i = 0; i < 64; i = i + 1) begin
            if(i <= (6'd63 - qdma_mty)) begin
                coyote_tkeep_temp[i] <=  1'b1;
            end
            else begin
                coyote_tkeep_temp[i] <= 1'b0;
            end
        end
    end*/

    // -----------------------------------------------------------------
    // STATIC LAYER 
    // -----------------------------------------------------------------
    design_static design_static_i (
        // AXI Clocks and Resets
        .aclk(aclk),
        .aresetn(aresetn),
        
        // UART Connection
        .UART_0_rxd(UART_0_rxd),
        .UART_0_txd(UART_0_txd),
        
        // AXI-MM Interfaces
        .axi_cnfg_araddr(axi_cnfg.araddr),
        .axi_cnfg_arprot(axi_cnfg.arprot),
        .axi_cnfg_arready(axi_cnfg.arready),
        .axi_cnfg_arvalid(axi_cnfg.arvalid),
        .axi_cnfg_awaddr(axi_cnfg.awaddr),
        .axi_cnfg_awprot(axi_cnfg.awprot),
        .axi_cnfg_awready(axi_cnfg.awready),
        .axi_cnfg_awvalid(axi_cnfg.awvalid),
        .axi_cnfg_bready(axi_cnfg.bready),
        .axi_cnfg_bresp(axi_cnfg.bresp),
        .axi_cnfg_bvalid(axi_cnfg.bvalid),
        .axi_cnfg_rdata(axi_cnfg.rdata),
        .axi_cnfg_rready(axi_cnfg.rready),
        .axi_cnfg_rresp(axi_cnfg.rresp),
        .axi_cnfg_rvalid(axi_cnfg.rvalid),
        .axi_cnfg_wdata(axi_cnfg.wdata),
        .axi_cnfg_wready(axi_cnfg.wready),
        .axi_cnfg_wstrb(axi_cnfg.wstrb),
        .axi_cnfg_wvalid(axi_cnfg.wvalid),
        .axi_ctrl_0_araddr(axi_ctrl[0].araddr),
        .axi_ctrl_0_arprot(axi_ctrl[0].arprot),
        .axi_ctrl_0_arready(axi_ctrl[0].arready),
        .axi_ctrl_0_arvalid(axi_ctrl[0].arvalid),
        .axi_ctrl_0_awaddr(axi_ctrl[0].awaddr),
        .axi_ctrl_0_awprot(axi_ctrl[0].awprot),
        .axi_ctrl_0_awready(axi_ctrl[0].awready),
        .axi_ctrl_0_awvalid(axi_ctrl[0].awvalid),
        .axi_ctrl_0_bready(axi_ctrl[0].bready),
        .axi_ctrl_0_bresp(axi_ctrl[0].bresp),
        .axi_ctrl_0_bvalid(axi_ctrl[0].bvalid),
        .axi_ctrl_0_rdata(axi_ctrl[0].rdata),
        .axi_ctrl_0_rready(axi_ctrl[0].rready),
        .axi_ctrl_0_rresp(axi_ctrl[0].rresp),
        .axi_ctrl_0_rvalid(axi_ctrl[0].rvalid),
        .axi_ctrl_0_wdata(axi_ctrl[0].wdata),
        .axi_ctrl_0_wready(axi_ctrl[0].wready),
        .axi_ctrl_0_wstrb(axi_ctrl[0].wstrb),
        .axi_ctrl_0_wvalid(axi_ctrl[0].wvalid),
        .axim_ctrl_0_araddr(axim_ctrl[0].araddr),
        .axim_ctrl_0_arburst(axim_ctrl[0].arburst),
        .axim_ctrl_0_arcache(axim_ctrl[0].arcache),
        .axim_ctrl_0_arlen(axim_ctrl[0].arlen),
        .axim_ctrl_0_arlock(axim_ctrl[0].arlock),
        .axim_ctrl_0_arprot(axim_ctrl[0].arprot),
        .axim_ctrl_0_arqos(axim_ctrl[0].arqos),
        .axim_ctrl_0_arready(axim_ctrl[0].arready),
        .axim_ctrl_0_arregion(axim_ctrl[0].arregion),
        .axim_ctrl_0_arsize(axim_ctrl[0].arsize),
        .axim_ctrl_0_arvalid(axim_ctrl[0].arvalid),
        .axim_ctrl_0_awaddr(axim_ctrl[0].awaddr),
        .axim_ctrl_0_awburst(axim_ctrl[0].awburst),
        .axim_ctrl_0_awcache(axim_ctrl[0].awcache),
        .axim_ctrl_0_awlen(axim_ctrl[0].awlen),
        .axim_ctrl_0_awlock(axim_ctrl[0].awlock),
        .axim_ctrl_0_awprot(axim_ctrl[0].awprot),
        .axim_ctrl_0_awqos(axim_ctrl[0].awqos),
        .axim_ctrl_0_awready(axim_ctrl[0].awready),
        .axim_ctrl_0_awregion(axim_ctrl[0].awregion),
        .axim_ctrl_0_awsize(axim_ctrl[0].awsize),
        .axim_ctrl_0_awvalid(axim_ctrl[0].awvalid),
        .axim_ctrl_0_bready(axim_ctrl[0].bready),
        .axim_ctrl_0_bresp(axim_ctrl[0].bresp),
        .axim_ctrl_0_bvalid(axim_ctrl[0].bvalid),
        .axim_ctrl_0_rdata(axim_ctrl[0].rdata),
        .axim_ctrl_0_rlast(axim_ctrl[0].rlast),
        .axim_ctrl_0_rready(axim_ctrl[0].rready),
        .axim_ctrl_0_rresp(axim_ctrl[0].rresp),
        .axim_ctrl_0_rvalid(axim_ctrl[0].rvalid),
        .axim_ctrl_0_wdata(axim_ctrl[0].wdata),
        .axim_ctrl_0_wlast(axim_ctrl[0].wlast),
        .axim_ctrl_0_wready(axim_ctrl[0].wready),
        .axim_ctrl_0_wstrb(axim_ctrl[0].wstrb),
        .axim_ctrl_0_wvalid(axim_ctrl[0].wvalid),
        
        // C2H Descriptor
        // TODO: C2H is not setup properly. Just want to
        // test H2C for now
        .c2h_byp_in_st_0_addr(xdma_req[0].c2h_addr),
        .c2h_byp_in_st_0_error(1'd0),
        .c2h_byp_in_st_0_func(1'd0),
        .c2h_byp_in_st_0_pfch_tag(7'd0),
        .c2h_byp_in_st_0_port_id(3'd2),
        .c2h_byp_in_st_0_qid(11'd2),
        .c2h_byp_in_st_0_ready(xdma_req[0].c2h_ready),
        .c2h_byp_in_st_0_valid(1'd0/*xdma_req[0].c2h_valid*/),
        
        // C2H Data
        .s_axis_c2h_0_ctrl_has_cmpt(1'd0),
        .s_axis_c2h_0_ctrl_len(16'd0),
        .s_axis_c2h_0_ctrl_marker(1'd0),
        .s_axis_c2h_0_ctrl_port_id(3'd0),
        .s_axis_c2h_0_ctrl_qid(11'd0),
        .s_axis_c2h_0_ecc(7'd0),
        .s_axis_c2h_0_mty(6'd0),
        .s_axis_c2h_0_tcrc(32'd0),
        .s_axis_c2h_0_tdata(512'd0),
        .s_axis_c2h_0_tlast(1'd0),
        .s_axis_c2h_0_tready(),
        .s_axis_c2h_0_tvalid(1'd0),
        
        // C2H Completion
        .s_axis_c2h_cmpt_0_cmpt_type(2'd0),
        .s_axis_c2h_cmpt_0_col_idx(3'd0),
        .s_axis_c2h_cmpt_0_data(512'd0),
        .s_axis_c2h_cmpt_0_dpar(16'd0),
        .s_axis_c2h_cmpt_0_err_idx(3'd0),
        .s_axis_c2h_cmpt_0_marker(1'd0),
        .s_axis_c2h_cmpt_0_no_wrb_marker(1'd0),
        .s_axis_c2h_cmpt_0_port_id(3'd0),
        .s_axis_c2h_cmpt_0_qid(11'd0),
        .s_axis_c2h_cmpt_0_size(2'd0),
        .s_axis_c2h_cmpt_0_tready(),
        .s_axis_c2h_cmpt_0_tvalid(1'd0),
        .s_axis_c2h_cmpt_0_user_trig(1'd0),
        .s_axis_c2h_cmpt_0_wait_pld_pkt_id(16'd0),
        
        // H2C Bypass
        .coyote_dsc_bypass_h2c_0_dsc_byp_ctl_0(xdma_req[0].h2c_ctl),
        .coyote_dsc_bypass_h2c_0_dsc_byp_dst_addr_0(64'd0),
        .coyote_dsc_bypass_h2c_0_dsc_byp_len_0(xdma_req[0].h2c_len[15:0]),
        .coyote_dsc_bypass_h2c_0_dsc_byp_load_0(xdma_req[0].h2c_valid),
        .coyote_dsc_bypass_h2c_0_dsc_byp_src_addr_0(xdma_req[0].h2c_addr),
        .coyote_dsc_bypass_h2c_0_dsc_byp_ready_0(xdma_req[0].h2c_ready),
        .coyote_dsc_bypass_h2c_0_dsc_byp_at_0(xdma_req[0].at),  
        // This is the old way that I was passing it in, before adding the descriptor mux
        /*.h2c_byp_in_st_0_addr(xdma_req[0].h2c_addr),
        .h2c_byp_in_st_0_eop(xdma_req[0].h2c_ctl[4]),
        .h2c_byp_in_st_0_len(xdma_req[0].h2c_len[15:0]),
        .h2c_byp_in_st_0_ready(xdma_req[0].h2c_ready),
        .h2c_byp_in_st_0_valid(xdma_req[0].h2c_valid),
        .h2c_byp_in_st_0_cidx(16'd1),
        .h2c_byp_in_st_0_error(1'd0),
        .h2c_byp_in_st_0_func(1'd0),
        .h2c_byp_in_st_0_mrkr_req(1'd0),
        .h2c_byp_in_st_0_no_dma(1'd0),
        .h2c_byp_in_st_0_port_id(3'd2),
        .h2c_byp_in_st_0_qid(11'd2),
        .h2c_byp_in_st_0_sdi(1'd0),
        .h2c_byp_in_st_0_sop(1'd1),*/
        
        // Other H2C Channel
        .coyote_dsc_bypass_h2c_1_dsc_byp_ctl_0(xdma_req[1].h2c_ctl),
        .coyote_dsc_bypass_h2c_1_dsc_byp_dst_addr_0(64'd0),
        .coyote_dsc_bypass_h2c_1_dsc_byp_len_0(xdma_req[1].h2c_len[15:0]),
        .coyote_dsc_bypass_h2c_1_dsc_byp_load_0(xdma_req[1].h2c_valid),
        .coyote_dsc_bypass_h2c_1_dsc_byp_src_addr_0(xdma_req[1].h2c_addr),
        .coyote_dsc_bypass_h2c_1_dsc_byp_ready_0(xdma_req[1].h2c_ready),
        .coyote_dsc_bypass_h2c_1_dsc_byp_at_0(2/*xdma_req[1].at*/),  // TODO: Don't hardcode this encode it into the module, but right now it only uses physical addresses
        
        // H2C Data
        .axis_dyn_out_tdata(axis_dyn_out[0].tdata),
        .axis_dyn_out_tkeep(axis_dyn_out[0].tkeep),
        .axis_dyn_out_tvalid(axis_dyn_out[0].tvalid),
        .axis_dyn_out_tlast(axis_dyn_out[0].tlast),
        .axis_dyn_out_tready(axis_dyn_out[0].tready),
        
        .axis_dyn_out_1_tdata(axis_dyn_out[1].tdata),
        .axis_dyn_out_1_tkeep(axis_dyn_out[1].tkeep),
        .axis_dyn_out_1_tvalid(axis_dyn_out[1].tvalid),
        .axis_dyn_out_1_tlast(axis_dyn_out[1].tlast),
        .axis_dyn_out_1_tready(axis_dyn_out[1].tready),
        // This is the old way that I was receiving the data, before adding the data demux
        /*.m_axis_h2c_0_err(),
        .m_axis_h2c_0_mdata(),
        .m_axis_h2c_0_mty(qdma_mty),
        .m_axis_h2c_0_port_id(),
        .m_axis_h2c_0_qid(),
        .m_axis_h2c_0_tcrc(),
        .m_axis_h2c_0_tdata(axis_dyn_out[0].tdata),
        .m_axis_h2c_0_tlast(axis_dyn_out[0].tlast),
        .m_axis_h2c_0_tready(axis_dyn_out[0].tready),
        .m_axis_h2c_0_tvalid(axis_dyn_out[0].tvalid),
        .m_axis_h2c_0_zero_byte(qdma_zero_byte),*/
        
        // PCIe Clock and Reset
        .pcie_clk_clk_n(pcie_clk_clk_n),
        .pcie_clk_clk_p(pcie_clk_clk_p),
        .pcie_x16_rxn(pcie_x16_rxn),
        .pcie_x16_rxp(pcie_x16_rxp),
        .pcie_x16_txn(pcie_x16_txn),
        .pcie_x16_txp(pcie_x16_txp),
        .perst_n(perst_n),
        .reset_0(~resetn_0),
        
        // IRQ
        .usr_irq_0_ack(),
        .usr_irq_0_fail(),
        .usr_irq_0_fnc(8'd0),
        .usr_irq_0_valid(usr_irq),
        .usr_irq_0_vec(11'd0),
        
        // DRAM Signals
        /*.ddr4_sdram_c0_act_n(c0_ddr4_act_n),
        .ddr4_sdram_c0_adr(c0_ddr4_adr),
        .ddr4_sdram_c0_ba(c0_ddr4_ba),
        .ddr4_sdram_c0_bg(c0_ddr4_bg),
        .ddr4_sdram_c0_ck_c(c0_ddr4_ck_c),
        .ddr4_sdram_c0_ck_t(c0_ddr4_ck_t),
        .ddr4_sdram_c0_cke(c0_ddr4_cke),
        .ddr4_sdram_c0_cs_n(c0_ddr4_cs_n),
        .ddr4_sdram_c0_dq(c0_ddr4_dq),
        .ddr4_sdram_c0_dqs_c(c0_ddr4_dqs_c),
        .ddr4_sdram_c0_dqs_t(c0_ddr4_dqs_t),
        .ddr4_sdram_c0_odt(c0_ddr4_odt),
        .ddr4_sdram_c0_par(c0_ddr4_par),
        .ddr4_sdram_c0_reset_n(c0_ddr4_reset_n),
        .sysclk0_clk_n(c0_sys_clk_n),
        .sysclk0_clk_p(c0_sys_clk_p),*/
        
        .axi_ddr_in_0_araddr(axi_ddr_in[0].araddr + 64'h0000_0000_2000_0000), // TODO: Parameterize this offset
        .axi_ddr_in_0_arburst(axi_ddr_in[0].arburst),
        .axi_ddr_in_0_arcache(axi_ddr_in[0].arcache),
        .axi_ddr_in_0_arid(axi_ddr_in[0].arid),
        .axi_ddr_in_0_arlen(axi_ddr_in[0].arlen),
        .axi_ddr_in_0_arlock(axi_ddr_in[0].arlock),
        .axi_ddr_in_0_arprot(axi_ddr_in[0].arprot),
        .axi_ddr_in_0_arqos(axi_ddr_in[0].arqos),
        .axi_ddr_in_0_arready(axi_ddr_in[0].arready),
        //.axi_ddr_in_0_arregion(axi_ddr_in[0].arregion),
        .axi_ddr_in_0_arsize(axi_ddr_in[0].arsize),
        .axi_ddr_in_0_arvalid(axi_ddr_in[0].arvalid),
        .axi_ddr_in_0_awaddr(axi_ddr_in[0].awaddr + 64'h0000_0000_2000_0000), // TODO: Parameterize this offset
        .axi_ddr_in_0_awburst(axi_ddr_in[0].awburst),
        .axi_ddr_in_0_awcache(axi_ddr_in[0].awcache),
        .axi_ddr_in_0_awid(axi_ddr_in[0].awid),
        .axi_ddr_in_0_awlen(axi_ddr_in[0].awlen),
        .axi_ddr_in_0_awlock(axi_ddr_in[0].awlock),
        .axi_ddr_in_0_awprot(axi_ddr_in[0].awprot),
        .axi_ddr_in_0_awqos(axi_ddr_in[0].awqos),
        .axi_ddr_in_0_awready(axi_ddr_in[0].awready),
        //.axi_ddr_in_0_awregion(axi_ddr_in[0].awregion),
        .axi_ddr_in_0_awsize(axi_ddr_in[0].awsize),
        .axi_ddr_in_0_awvalid(axi_ddr_in[0].awvalid),
        .axi_ddr_in_0_bid(axi_ddr_in[0].bid),
        .axi_ddr_in_0_bready(axi_ddr_in[0].bready),
        .axi_ddr_in_0_bresp(axi_ddr_in[0].bresp),
        .axi_ddr_in_0_bvalid(axi_ddr_in[0].bvalid),
        .axi_ddr_in_0_rdata(axi_ddr_in[0].rdata),
        .axi_ddr_in_0_rid(axi_ddr_in[0].rid),
        .axi_ddr_in_0_rlast(axi_ddr_in[0].rlast),
        .axi_ddr_in_0_rready(axi_ddr_in[0].rready),
        .axi_ddr_in_0_rresp(axi_ddr_in[0].rresp),
        .axi_ddr_in_0_rvalid(axi_ddr_in[0].rvalid),
        .axi_ddr_in_0_wdata(axi_ddr_in[0].wdata),
        .axi_ddr_in_0_wlast(axi_ddr_in[0].wlast),
        .axi_ddr_in_0_wready(axi_ddr_in[0].wready),
        .axi_ddr_in_0_wstrb(axi_ddr_in[0].wstrb),
        .axi_ddr_in_0_wvalid(axi_ddr_in[0].wvalid),
        .axi_ddr_in_1_araddr(axi_ddr_in[1].araddr + 64'h0000_0000_2000_0000), // TODO: Parameterize this offset
        .axi_ddr_in_1_arburst(axi_ddr_in[1].arburst),
        .axi_ddr_in_1_arcache(axi_ddr_in[1].arcache),
        .axi_ddr_in_1_arid(axi_ddr_in[1].arid),
        .axi_ddr_in_1_arlen(axi_ddr_in[1].arlen),
        .axi_ddr_in_1_arlock(axi_ddr_in[1].arlock),
        .axi_ddr_in_1_arprot(axi_ddr_in[1].arprot),
        .axi_ddr_in_1_arqos(axi_ddr_in[1].arqos),
        .axi_ddr_in_1_arready(axi_ddr_in[1].arready),
        //.axi_ddr_in_1_arregion(axi_ddr_in[1].arregion),
        .axi_ddr_in_1_arsize(axi_ddr_in[1].arsize),
        .axi_ddr_in_1_arvalid(axi_ddr_in[1].arvalid),
        .axi_ddr_in_1_awaddr(axi_ddr_in[1].awaddr + 64'h0000_0000_2000_0000), // TODO: Parameterize this offset
        .axi_ddr_in_1_awburst(axi_ddr_in[1].awburst),
        .axi_ddr_in_1_awcache(axi_ddr_in[1].awcache),
        .axi_ddr_in_1_awid(axi_ddr_in[1].awid),
        .axi_ddr_in_1_awlen(axi_ddr_in[1].awlen),
        .axi_ddr_in_1_awlock(axi_ddr_in[1].awlock),
        .axi_ddr_in_1_awprot(axi_ddr_in[1].awprot),
        .axi_ddr_in_1_awqos(axi_ddr_in[1].awqos),
        .axi_ddr_in_1_awready(axi_ddr_in[1].awready),
        //.axi_ddr_in_1_awregion(axi_ddr_in[1].awregion),
        .axi_ddr_in_1_awsize(axi_ddr_in[1].awsize),
        .axi_ddr_in_1_awvalid(axi_ddr_in[1].awvalid),
        .axi_ddr_in_1_bid(axi_ddr_in[1].bid),
        .axi_ddr_in_1_bready(axi_ddr_in[1].bready),
        .axi_ddr_in_1_bresp(axi_ddr_in[1].bresp),
        .axi_ddr_in_1_bvalid(axi_ddr_in[1].bvalid),
        .axi_ddr_in_1_rdata(axi_ddr_in[1].rdata),
        .axi_ddr_in_1_rid(axi_ddr_in[1].rid),
        .axi_ddr_in_1_rlast(axi_ddr_in[1].rlast),
        .axi_ddr_in_1_rready(axi_ddr_in[1].rready),
        .axi_ddr_in_1_rresp(axi_ddr_in[1].rresp),
        .axi_ddr_in_1_rvalid(axi_ddr_in[1].rvalid),
        .axi_ddr_in_1_wdata(axi_ddr_in[1].wdata),
        .axi_ddr_in_1_wlast(axi_ddr_in[1].wlast),
        .axi_ddr_in_1_wready(axi_ddr_in[1].wready),
        .axi_ddr_in_1_wstrb(axi_ddr_in[1].wstrb),
        .axi_ddr_in_1_wvalid(axi_ddr_in[1].wvalid),
        
        
        // Copied from Coyote
        /*.c0_ddr4_act_n(c0_ddr4_act_n),
		.c0_ddr4_adr(c0_ddr4_adr),
		.c0_ddr4_ba(c0_ddr4_ba),
		.c0_ddr4_bg(c0_ddr4_bg),
		.c0_ddr4_ck_c(c0_ddr4_ck_c),
		.c0_ddr4_ck_t(c0_ddr4_ck_t),
		.c0_ddr4_cke(c0_ddr4_cke),
		.c0_ddr4_cs_n(c0_ddr4_cs_n),
		.c0_ddr4_dq(c0_ddr4_dq),
		.c0_ddr4_dqs_c(c0_ddr4_dqs_c),
		.c0_ddr4_dqs_t(c0_ddr4_dqs_t),
		.c0_ddr4_odt(c0_ddr4_odt),
		.c0_ddr4_par(c0_ddr4_par),
		.c0_ddr4_reset_n(c0_ddr4_reset_n),
		
		.c0_sys_clk_0_clk_n(c0_sys_clk_n),
		.c0_sys_clk_0_clk_p(c0_sys_clk_p),*/
		// PIPE interface to accelerate sim
        .pcie_ext_pipe_ep_usp_0_commands_in(pcie_ext_pipe_ep_usp_0_commands_in),
        .pcie_ext_pipe_ep_usp_0_commands_out(pcie_ext_pipe_ep_usp_0_commands_out),
        .pcie_ext_pipe_ep_usp_0_rx_0(pcie_ext_pipe_ep_usp_0_rx_0),
        .pcie_ext_pipe_ep_usp_0_rx_1(pcie_ext_pipe_ep_usp_0_rx_1),
        .pcie_ext_pipe_ep_usp_0_rx_10(pcie_ext_pipe_ep_usp_0_rx_10),
        .pcie_ext_pipe_ep_usp_0_rx_11(pcie_ext_pipe_ep_usp_0_rx_11),
        .pcie_ext_pipe_ep_usp_0_rx_12(pcie_ext_pipe_ep_usp_0_rx_12),
        .pcie_ext_pipe_ep_usp_0_rx_13(pcie_ext_pipe_ep_usp_0_rx_13),
        .pcie_ext_pipe_ep_usp_0_rx_14(pcie_ext_pipe_ep_usp_0_rx_14),
        .pcie_ext_pipe_ep_usp_0_rx_15(pcie_ext_pipe_ep_usp_0_rx_15),
        .pcie_ext_pipe_ep_usp_0_rx_2(pcie_ext_pipe_ep_usp_0_rx_2),
        .pcie_ext_pipe_ep_usp_0_rx_3(pcie_ext_pipe_ep_usp_0_rx_3),
        .pcie_ext_pipe_ep_usp_0_rx_4(pcie_ext_pipe_ep_usp_0_rx_4),
        .pcie_ext_pipe_ep_usp_0_rx_5(pcie_ext_pipe_ep_usp_0_rx_5),
        .pcie_ext_pipe_ep_usp_0_rx_6(pcie_ext_pipe_ep_usp_0_rx_6),
        .pcie_ext_pipe_ep_usp_0_rx_7(pcie_ext_pipe_ep_usp_0_rx_7),
        .pcie_ext_pipe_ep_usp_0_rx_8(pcie_ext_pipe_ep_usp_0_rx_8),
        .pcie_ext_pipe_ep_usp_0_rx_9(pcie_ext_pipe_ep_usp_0_rx_9),
        .pcie_ext_pipe_ep_usp_0_tx_0(pcie_ext_pipe_ep_usp_0_tx_0),
        .pcie_ext_pipe_ep_usp_0_tx_1(pcie_ext_pipe_ep_usp_0_tx_1),
        .pcie_ext_pipe_ep_usp_0_tx_10(pcie_ext_pipe_ep_usp_0_tx_10),
        .pcie_ext_pipe_ep_usp_0_tx_11(pcie_ext_pipe_ep_usp_0_tx_11),
        .pcie_ext_pipe_ep_usp_0_tx_12(pcie_ext_pipe_ep_usp_0_tx_12),
        .pcie_ext_pipe_ep_usp_0_tx_13(pcie_ext_pipe_ep_usp_0_tx_13),
        .pcie_ext_pipe_ep_usp_0_tx_14(pcie_ext_pipe_ep_usp_0_tx_14),
        .pcie_ext_pipe_ep_usp_0_tx_15(pcie_ext_pipe_ep_usp_0_tx_15),
        .pcie_ext_pipe_ep_usp_0_tx_2(pcie_ext_pipe_ep_usp_0_tx_2),
        .pcie_ext_pipe_ep_usp_0_tx_3(pcie_ext_pipe_ep_usp_0_tx_3),
        .pcie_ext_pipe_ep_usp_0_tx_4(pcie_ext_pipe_ep_usp_0_tx_4),
        .pcie_ext_pipe_ep_usp_0_tx_5(pcie_ext_pipe_ep_usp_0_tx_5),
        .pcie_ext_pipe_ep_usp_0_tx_6(pcie_ext_pipe_ep_usp_0_tx_6),
        .pcie_ext_pipe_ep_usp_0_tx_7(pcie_ext_pipe_ep_usp_0_tx_7),
        .pcie_ext_pipe_ep_usp_0_tx_8(pcie_ext_pipe_ep_usp_0_tx_8),
        .pcie_ext_pipe_ep_usp_0_tx_9(pcie_ext_pipe_ep_usp_0_tx_9)
    );
    
    /*design_static design_static_i
       (.aclk(aclk),
        .aresetn(aresetn),
        .axi_cnfg_araddr(axi_cnfg.araddr),
        .axi_cnfg_arprot(axi_cnfg.arprot),
        .axi_cnfg_arready(axi_cnfg.arready),
        .axi_cnfg_arvalid(axi_cnfg.arvalid),
        .axi_cnfg_awaddr(axi_cnfg.awaddr),
        .axi_cnfg_awprot(axi_cnfg.awprot),
        .axi_cnfg_awready(axi_cnfg.awready),
        .axi_cnfg_awvalid(axi_cnfg.awvalid),
        .axi_cnfg_bready(axi_cnfg.bready),
        .axi_cnfg_bresp(axi_cnfg.bresp),
        .axi_cnfg_bvalid(axi_cnfg.bvalid),
        .axi_cnfg_rdata(axi_cnfg.rdata),
        .axi_cnfg_rready(axi_cnfg.rready),
        .axi_cnfg_rresp(axi_cnfg.rresp),
        .axi_cnfg_rvalid(axi_cnfg.rvalid),
        .axi_cnfg_wdata(axi_cnfg.wdata),
        .axi_cnfg_wready(axi_cnfg.wready),
        .axi_cnfg_wstrb(axi_cnfg.wstrb),
        .axi_cnfg_wvalid(axi_cnfg.wvalid),
        .axi_ctrl_0_araddr(axi_ctrl[0].araddr),
        .axi_ctrl_0_arprot(axi_ctrl[0].arprot),
        .axi_ctrl_0_arready(axi_ctrl[0].arready),
        .axi_ctrl_0_arvalid(axi_ctrl[0].arvalid),
        .axi_ctrl_0_awaddr(axi_ctrl[0].awaddr),
        .axi_ctrl_0_awprot(axi_ctrl[0].awprot),
        .axi_ctrl_0_awready(axi_ctrl[0].awready),
        .axi_ctrl_0_awvalid(axi_ctrl[0].awvalid),
        .axi_ctrl_0_bready(axi_ctrl[0].bready),
        .axi_ctrl_0_bresp(axi_ctrl[0].bresp),
        .axi_ctrl_0_bvalid(axi_ctrl[0].bvalid),
        .axi_ctrl_0_rdata(axi_ctrl[0].rdata),
        .axi_ctrl_0_rready(axi_ctrl[0].rready),
        .axi_ctrl_0_rresp(axi_ctrl[0].rresp),
        .axi_ctrl_0_rvalid(axi_ctrl[0].rvalid),
        .axi_ctrl_0_wdata(axi_ctrl[0].wdata),
        .axi_ctrl_0_wready(axi_ctrl[0].wready),
        .axi_ctrl_0_wstrb(axi_ctrl[0].wstrb),
        .axi_ctrl_0_wvalid(axi_ctrl[0].wvalid),
        .axim_ctrl_0_araddr(axim_ctrl[0].araddr),
        .axim_ctrl_0_arburst(axim_ctrl[0].arburst),
        .axim_ctrl_0_arcache(axim_ctrl[0].arcache),
        .axim_ctrl_0_arlen(axim_ctrl[0].arlen),
        .axim_ctrl_0_arlock(axim_ctrl[0].arlock),
        .axim_ctrl_0_arprot(axim_ctrl[0].arprot),
        .axim_ctrl_0_arqos(axim_ctrl[0].arqos),
        .axim_ctrl_0_arready(axim_ctrl[0].arready),
        .axim_ctrl_0_arregion(axim_ctrl[0].arregion),
        .axim_ctrl_0_arsize(axim_ctrl[0].arsize),
        .axim_ctrl_0_arvalid(axim_ctrl[0].arvalid),
        .axim_ctrl_0_awaddr(axim_ctrl[0].awaddr),
        .axim_ctrl_0_awburst(axim_ctrl[0].awburst),
        .axim_ctrl_0_awcache(axim_ctrl[0].awcache),
        .axim_ctrl_0_awlen(axim_ctrl[0].awlen),
        .axim_ctrl_0_awlock(axim_ctrl[0].awlock),
        .axim_ctrl_0_awprot(axim_ctrl[0].awprot),
        .axim_ctrl_0_awqos(axim_ctrl[0].awqos),
        .axim_ctrl_0_awready(axim_ctrl[0].awready),
        .axim_ctrl_0_awregion(axim_ctrl[0].awregion),
        .axim_ctrl_0_awsize(axim_ctrl[0].awsize),
        .axim_ctrl_0_awvalid(axim_ctrl[0].awvalid),
        .axim_ctrl_0_bready(axim_ctrl[0].bready),
        .axim_ctrl_0_bresp(axim_ctrl[0].bresp),
        .axim_ctrl_0_bvalid(axim_ctrl[0].bvalid),
        .axim_ctrl_0_rdata(axim_ctrl[0].rdata),
        .axim_ctrl_0_rlast(axim_ctrl[0].rlast),
        .axim_ctrl_0_rready(axim_ctrl[0].rready),
        .axim_ctrl_0_rresp(axim_ctrl[0].rresp),
        .axim_ctrl_0_rvalid(axim_ctrl[0].rvalid),
        .axim_ctrl_0_wdata(axim_ctrl[0].wdata),
        .axim_ctrl_0_wlast(axim_ctrl[0].wlast),
        .axim_ctrl_0_wready(axim_ctrl[0].wready),
        .axim_ctrl_0_wstrb(axim_ctrl[0].wstrb),
        .axim_ctrl_0_wvalid(axim_ctrl[0].wvalid),
        .axis_dyn_in_0_tdata(axis_dyn_in[0].tdata),
        .axis_dyn_in_0_tkeep(axis_dyn_in[0].tkeep),
        .axis_dyn_in_0_tlast(axis_dyn_in[0].tlast),
        .axis_dyn_in_0_tready(axis_dyn_in[0].tready),
        .axis_dyn_in_0_tvalid(axis_dyn_in[0].tvalid),
        .axis_dyn_out_0_tdata(axis_dyn_out[0].tdata),
        .axis_dyn_out_0_tkeep(axis_dyn_out[0].tkeep),
        .axis_dyn_out_0_tlast(axis_dyn_out[0].tlast),
        .axis_dyn_out_0_tready(axis_dyn_out[0].tready),
        .axis_dyn_out_0_tvalid(axis_dyn_out[0].tvalid),
        .dsc_bypass_c2h_0_dsc_byp_ctl(xdma_req[0].c2h_ctl),
        .dsc_bypass_c2h_0_dsc_byp_dst_addr(xdma_req[0].c2h_addr),
        .dsc_bypass_c2h_0_dsc_byp_len(xdma_req[0].c2h_len),
        .dsc_bypass_c2h_0_dsc_byp_load(xdma_req[0].c2h_valid),
        .dsc_bypass_c2h_0_dsc_byp_ready(xdma_req[0].c2h_ready),
        .dsc_bypass_c2h_0_dsc_byp_src_addr(0),
        .dsc_bypass_h2c_0_dsc_byp_ctl(xdma_req[0].h2c_ctl),
        .dsc_bypass_h2c_0_dsc_byp_dst_addr(0),
        .dsc_bypass_h2c_0_dsc_byp_len(xdma_req[0].h2c_len),
        .dsc_bypass_h2c_0_dsc_byp_load(xdma_req[0].h2c_valid),
        .dsc_bypass_h2c_0_dsc_byp_ready(xdma_req[0].h2c_ready),
        .dsc_bypass_h2c_0_dsc_byp_src_addr(xdma_req[0].h2c_addr),
        .dsc_status_c2h_sts0(xdma_req[0].c2h_status),
        .dsc_status_h2c_sts0(xdma_req[0].h2c_status),
        .pcie_clk_clk_n(pcie_clk_clk_n),
        .pcie_clk_clk_p(pcie_clk_clk_p),
        .pcie_x16_rxn(pcie_x16_rxn),
        .pcie_x16_rxp(pcie_x16_rxp),
        .pcie_x16_txn(pcie_x16_txn),
        .pcie_x16_txp(pcie_x16_txp),
        .perst_n(perst_n),
        .reset_0(~resetn_0),
        .usr_irq(usr_irq)
    );*/
    
    // -----------------------------------------------------------------
    // STATIC CONFIG 
    // -----------------------------------------------------------------
    static_slave inst_static_slave (
        .aclk(aclk),
        .aresetn(aresetn),
        .lowspeed_ctrl(),
        .axi_ctrl(axi_cnfg)
    );

    // -----------------------------------------------------------------
    // DYNAMIC LAYER 
    // -----------------------------------------------------------------
    design_dynamic_wrapper inst_dynamic (
        .sys_rst(~resetn_0),
        .aresetn(aresetn),
        .aclk(aclk),
        .axi_ctrl(axi_ctrl[0+:1]),
        .axim_ctrl(axim_ctrl[0+:1]),
        .axi_ddr_in(axi_ddr_in[0+:1*2]),
        .axis_host_in(axis_dyn_in[0]),
        .axis_host_out(axis_dyn_out[0]),
        .host_xdma_req(xdma_req[0]),
        .axis_card_in(axis_dyn_in[1]),
        .axis_card_out(axis_dyn_out[1]),
        .card_xdma_req(xdma_req[1]),
        .usr_irq(usr_irq[0+:1]),
        .S_BSCAN_drck(),
        .S_BSCAN_shift(),
        .S_BSCAN_tdi(),
        .S_BSCAN_update(),
        .S_BSCAN_sel(),
        .S_BSCAN_tdo(),
        .S_BSCAN_tms(),
        .S_BSCAN_tck(),
        .S_BSCAN_runtest(),
        .S_BSCAN_reset(),
        .S_BSCAN_capture(),
        .S_BSCAN_bscanid_en()    
    );
    
endmodule


