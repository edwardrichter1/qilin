// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Thu May 13 13:20:45 2021
// Host        : edwardrichter-MS-7A71 running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /mnt/nvme0/coyote_qdma/Coyote/hw/build/ip_repo/qdma_descriptor_mux_1.0/src/axis_switch_0/axis_switch_0_sim_netlist.v
// Design      : axis_switch_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcu280-fsvh2892-2L-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "axis_switch_0,axis_switch_v1_1_22_axis_switch,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "axis_switch_v1_1_22_axis_switch,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module axis_switch_0
   (aclk,
    aresetn,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    s_req_suppress,
    s_decode_err);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLKIF CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLKIF, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RSTIF RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TVALID [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TVALID [0:0] [1:1]" *) input [1:0]s_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TREADY [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TREADY [0:0] [1:1]" *) output [1:0]s_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TDATA [255:0] [255:0], xilinx.com:interface:axis:1.0 S01_AXIS TDATA [255:0] [511:256]" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0, XIL_INTERFACENAME S01_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) input [511:0]s_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TVALID" *) output [0:0]m_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TREADY" *) input [0:0]m_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) output [255:0]m_axis_tdata;
  input [1:0]s_req_suppress;
  output [1:0]s_decode_err;

  wire \<const0> ;
  wire aclk;
  wire aresetn;
  wire [255:0]m_axis_tdata;
  wire [0:0]m_axis_tready;
  wire [0:0]m_axis_tvalid;
  wire [511:0]s_axis_tdata;
  wire [1:0]s_axis_tready;
  wire [1:0]s_axis_tvalid;
  wire [1:0]s_req_suppress;
  wire NLW_inst_s_axi_ctrl_arready_UNCONNECTED;
  wire NLW_inst_s_axi_ctrl_awready_UNCONNECTED;
  wire NLW_inst_s_axi_ctrl_bvalid_UNCONNECTED;
  wire NLW_inst_s_axi_ctrl_rvalid_UNCONNECTED;
  wire NLW_inst_s_axi_ctrl_wready_UNCONNECTED;
  wire [1:0]NLW_inst_arb_dest_UNCONNECTED;
  wire [0:0]NLW_inst_arb_done_UNCONNECTED;
  wire [1:0]NLW_inst_arb_id_UNCONNECTED;
  wire [1:0]NLW_inst_arb_last_UNCONNECTED;
  wire [1:0]NLW_inst_arb_req_UNCONNECTED;
  wire [1:0]NLW_inst_arb_user_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tid_UNCONNECTED;
  wire [31:0]NLW_inst_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tlast_UNCONNECTED;
  wire [31:0]NLW_inst_m_axis_tstrb_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tuser_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_ctrl_bresp_UNCONNECTED;
  wire [31:0]NLW_inst_s_axi_ctrl_rdata_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_ctrl_rresp_UNCONNECTED;
  wire [1:0]NLW_inst_s_decode_err_UNCONNECTED;

  assign s_decode_err[1] = \<const0> ;
  assign s_decode_err[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ARB_ALGORITHM = "0" *) 
  (* C_ARB_ON_MAX_XFERS = "1" *) 
  (* C_ARB_ON_NUM_CYCLES = "0" *) 
  (* C_ARB_ON_TLAST = "0" *) 
  (* C_AXIS_SIGNAL_SET = "3" *) 
  (* C_AXIS_TDATA_WIDTH = "256" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "1" *) 
  (* C_COMMON_CLOCK = "0" *) 
  (* C_DECODER_REG = "0" *) 
  (* C_FAMILY = "virtexuplusHBM" *) 
  (* C_INCLUDE_ARBITER = "1" *) 
  (* C_LOG_SI_SLOTS = "1" *) 
  (* C_M_AXIS_BASETDEST_ARRAY = "1'b0" *) 
  (* C_M_AXIS_CONNECTIVITY_ARRAY = "2'b11" *) 
  (* C_M_AXIS_HIGHTDEST_ARRAY = "1'b0" *) 
  (* C_NUM_MI_SLOTS = "1" *) 
  (* C_NUM_SI_SLOTS = "2" *) 
  (* C_OUTPUT_REG = "0" *) 
  (* C_ROUTING_MODE = "0" *) 
  (* C_S_AXI_CTRL_ADDR_WIDTH = "7" *) 
  (* C_S_AXI_CTRL_DATA_WIDTH = "32" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* G_INDX_SS_TDATA = "1" *) 
  (* G_INDX_SS_TDEST = "6" *) 
  (* G_INDX_SS_TID = "5" *) 
  (* G_INDX_SS_TKEEP = "3" *) 
  (* G_INDX_SS_TLAST = "4" *) 
  (* G_INDX_SS_TREADY = "0" *) 
  (* G_INDX_SS_TSTRB = "2" *) 
  (* G_INDX_SS_TUSER = "7" *) 
  (* G_MASK_SS_TDATA = "2" *) 
  (* G_MASK_SS_TDEST = "64" *) 
  (* G_MASK_SS_TID = "32" *) 
  (* G_MASK_SS_TKEEP = "8" *) 
  (* G_MASK_SS_TLAST = "16" *) 
  (* G_MASK_SS_TREADY = "1" *) 
  (* G_MASK_SS_TSTRB = "4" *) 
  (* G_MASK_SS_TUSER = "128" *) 
  (* G_TASK_SEVERITY_ERR = "2" *) 
  (* G_TASK_SEVERITY_INFO = "0" *) 
  (* G_TASK_SEVERITY_WARNING = "1" *) 
  (* LP_CTRL_REG_WIDTH = "15" *) 
  (* LP_MERGEDOWN_MUX = "0" *) 
  (* LP_NUM_SYNCHRONIZER_STAGES = "4" *) 
  (* P_DECODER_CONNECTIVITY_ARRAY = "2'b11" *) 
  (* P_SINGLE_SLAVE_CONNECTIVITY_ARRAY = "1'b0" *) 
  (* P_TPAYLOAD_WIDTH = "256" *) 
  axis_switch_0_axis_switch_v1_1_22_axis_switch inst
       (.aclk(aclk),
        .aclken(1'b1),
        .arb_dest(NLW_inst_arb_dest_UNCONNECTED[1:0]),
        .arb_done(NLW_inst_arb_done_UNCONNECTED[0]),
        .arb_gnt({1'b0,1'b0}),
        .arb_id(NLW_inst_arb_id_UNCONNECTED[1:0]),
        .arb_last(NLW_inst_arb_last_UNCONNECTED[1:0]),
        .arb_req(NLW_inst_arb_req_UNCONNECTED[1:0]),
        .arb_sel(1'b0),
        .arb_user(NLW_inst_arb_user_UNCONNECTED[1:0]),
        .aresetn(aresetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tdest(NLW_inst_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_inst_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_inst_m_axis_tkeep_UNCONNECTED[31:0]),
        .m_axis_tlast(NLW_inst_m_axis_tlast_UNCONNECTED[0]),
        .m_axis_tready(m_axis_tready),
        .m_axis_tstrb(NLW_inst_m_axis_tstrb_UNCONNECTED[31:0]),
        .m_axis_tuser(NLW_inst_m_axis_tuser_UNCONNECTED[0]),
        .m_axis_tvalid(m_axis_tvalid),
        .s_axi_ctrl_aclk(1'b0),
        .s_axi_ctrl_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_ctrl_aresetn(1'b0),
        .s_axi_ctrl_arready(NLW_inst_s_axi_ctrl_arready_UNCONNECTED),
        .s_axi_ctrl_arvalid(1'b0),
        .s_axi_ctrl_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_ctrl_awready(NLW_inst_s_axi_ctrl_awready_UNCONNECTED),
        .s_axi_ctrl_awvalid(1'b0),
        .s_axi_ctrl_bready(1'b0),
        .s_axi_ctrl_bresp(NLW_inst_s_axi_ctrl_bresp_UNCONNECTED[1:0]),
        .s_axi_ctrl_bvalid(NLW_inst_s_axi_ctrl_bvalid_UNCONNECTED),
        .s_axi_ctrl_rdata(NLW_inst_s_axi_ctrl_rdata_UNCONNECTED[31:0]),
        .s_axi_ctrl_rready(1'b0),
        .s_axi_ctrl_rresp(NLW_inst_s_axi_ctrl_rresp_UNCONNECTED[1:0]),
        .s_axi_ctrl_rvalid(NLW_inst_s_axi_ctrl_rvalid_UNCONNECTED),
        .s_axi_ctrl_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_ctrl_wready(NLW_inst_s_axi_ctrl_wready_UNCONNECTED),
        .s_axi_ctrl_wvalid(1'b0),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tdest({1'b0,1'b0}),
        .s_axis_tid({1'b0,1'b0}),
        .s_axis_tkeep({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .s_axis_tlast({1'b1,1'b1}),
        .s_axis_tready(s_axis_tready),
        .s_axis_tstrb({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .s_axis_tuser({1'b0,1'b0}),
        .s_axis_tvalid(s_axis_tvalid),
        .s_decode_err(NLW_inst_s_decode_err_UNCONNECTED[1:0]),
        .s_req_suppress(s_req_suppress));
endmodule

(* ORIG_REF_NAME = "axis_switch_v1_1_22_arb_rr" *) 
module axis_switch_0_axis_switch_v1_1_22_arb_rr
   (s_axis_tready,
    \arb_gnt_r_reg[0]_0 ,
    \arb_gnt_r_reg[1]_0 ,
    areset_reg,
    \gen_tdest_routing.busy_ns ,
    \gen_tdest_routing.busy_ns_0 ,
    \arb_gnt_r_reg[0]_1 ,
    \arb_gnt_r_reg[1]_1 ,
    m_axis_tvalid,
    m_axis_tdata,
    \arb_gnt_r_reg[1]_2 ,
    aclk,
    s_axis_tvalid,
    \gen_tdest_router.busy_r ,
    m_axis_tready,
    valid_i,
    arb_req_i__1,
    \gen_tdest_routing.busy_r_reg[0] ,
    \gen_tdest_routing.busy_r_reg[0]_0 ,
    s_axis_tdata);
  output [1:0]s_axis_tready;
  output \arb_gnt_r_reg[0]_0 ;
  output \arb_gnt_r_reg[1]_0 ;
  output areset_reg;
  output \gen_tdest_routing.busy_ns ;
  output \gen_tdest_routing.busy_ns_0 ;
  output \arb_gnt_r_reg[0]_1 ;
  output \arb_gnt_r_reg[1]_1 ;
  output [0:0]m_axis_tvalid;
  output [255:0]m_axis_tdata;
  input \arb_gnt_r_reg[1]_2 ;
  input aclk;
  input [1:0]s_axis_tvalid;
  input [1:0]\gen_tdest_router.busy_r ;
  input [0:0]m_axis_tready;
  input valid_i;
  input [1:0]arb_req_i__1;
  input \gen_tdest_routing.busy_r_reg[0] ;
  input \gen_tdest_routing.busy_r_reg[0]_0 ;
  input [511:0]s_axis_tdata;

  wire aclk;
  wire arb_busy_ns;
  wire arb_busy_r;
  wire arb_done_i;
  wire [1:1]arb_gnt_ns;
  wire \arb_gnt_r[0]_i_1_n_0 ;
  wire \arb_gnt_r_reg[0]_0 ;
  wire \arb_gnt_r_reg[0]_1 ;
  wire \arb_gnt_r_reg[1]_0 ;
  wire \arb_gnt_r_reg[1]_1 ;
  wire \arb_gnt_r_reg[1]_2 ;
  wire [1:0]arb_req_i__1;
  wire arb_sel_i;
  wire \arb_sel_r[0]_i_1_n_0 ;
  wire areset_reg;
  wire \barrel_cntr[0]_i_1_n_0 ;
  wire \barrel_cntr[0]_i_2_n_0 ;
  wire \barrel_cntr_reg_n_0_[0] ;
  wire [1:0]\gen_tdest_router.busy_r ;
  wire \gen_tdest_routing.busy_ns ;
  wire \gen_tdest_routing.busy_ns_0 ;
  wire \gen_tdest_routing.busy_r_reg[0] ;
  wire \gen_tdest_routing.busy_r_reg[0]_0 ;
  wire [255:0]m_axis_tdata;
  wire [0:0]m_axis_tready;
  wire [0:0]m_axis_tvalid;
  wire [1:0]port_priority_ns;
  wire [511:0]s_axis_tdata;
  wire [1:0]s_axis_tready;
  wire [1:0]s_axis_tvalid;
  wire sel_i;
  wire valid_i;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    arb_busy_r_i_1
       (.I0(valid_i),
        .I1(arb_done_i),
        .I2(arb_busy_r),
        .O(arb_busy_ns));
  FDRE arb_busy_r_reg
       (.C(aclk),
        .CE(1'b1),
        .D(arb_busy_ns),
        .Q(arb_busy_r),
        .R(\arb_gnt_r_reg[1]_2 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h00B0)) 
    \arb_gnt_r[0]_i_1 
       (.I0(arb_done_i),
        .I1(arb_busy_r),
        .I2(valid_i),
        .I3(sel_i),
        .O(\arb_gnt_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hB000)) 
    \arb_gnt_r[1]_i_1 
       (.I0(arb_done_i),
        .I1(arb_busy_r),
        .I2(valid_i),
        .I3(sel_i),
        .O(arb_gnt_ns));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hBA8C8A80)) 
    \arb_gnt_r[1]_i_3 
       (.I0(port_priority_ns[1]),
        .I1(arb_req_i__1[1]),
        .I2(\barrel_cntr_reg_n_0_[0] ),
        .I3(arb_req_i__1[0]),
        .I4(port_priority_ns[0]),
        .O(sel_i));
  FDRE \arb_gnt_r_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\arb_gnt_r[0]_i_1_n_0 ),
        .Q(\arb_gnt_r_reg[0]_0 ),
        .R(\arb_gnt_r_reg[1]_2 ));
  FDRE \arb_gnt_r_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(arb_gnt_ns),
        .Q(\arb_gnt_r_reg[1]_0 ),
        .R(\arb_gnt_r_reg[1]_2 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hBBFB8808)) 
    \arb_sel_r[0]_i_1 
       (.I0(sel_i),
        .I1(valid_i),
        .I2(arb_busy_r),
        .I3(arb_done_i),
        .I4(arb_sel_i),
        .O(\arb_sel_r[0]_i_1_n_0 ));
  FDRE \arb_sel_r_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\arb_sel_r[0]_i_1_n_0 ),
        .Q(arb_sel_i),
        .R(\arb_gnt_r_reg[1]_2 ));
  LUT3 #(
    .INIT(8'hEF)) 
    \barrel_cntr[0]_i_1 
       (.I0(\arb_gnt_r_reg[1]_0 ),
        .I1(\arb_gnt_r_reg[0]_0 ),
        .I2(arb_busy_r),
        .O(\barrel_cntr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \barrel_cntr[0]_i_2 
       (.I0(\barrel_cntr_reg_n_0_[0] ),
        .O(\barrel_cntr[0]_i_2_n_0 ));
  FDRE \barrel_cntr_reg[0] 
       (.C(aclk),
        .CE(\barrel_cntr[0]_i_1_n_0 ),
        .D(\barrel_cntr[0]_i_2_n_0 ),
        .Q(\barrel_cntr_reg_n_0_[0] ),
        .R(\arb_gnt_r_reg[1]_2 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \busy_r[0]_i_1 
       (.I0(\arb_gnt_r_reg[0]_0 ),
        .I1(\gen_tdest_router.busy_r [0]),
        .O(\arb_gnt_r_reg[0]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \busy_r[1]_i_1 
       (.I0(\arb_gnt_r_reg[1]_2 ),
        .I1(arb_done_i),
        .O(areset_reg));
  LUT6 #(
    .INIT(64'hEE00E0E000000000)) 
    \busy_r[1]_i_2 
       (.I0(\arb_gnt_r_reg[0]_1 ),
        .I1(\arb_gnt_r_reg[1]_1 ),
        .I2(s_axis_tvalid[0]),
        .I3(s_axis_tvalid[1]),
        .I4(arb_sel_i),
        .I5(m_axis_tready),
        .O(arb_done_i));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \gen_tdest_routing.busy_r[0]_i_1 
       (.I0(\gen_tdest_routing.busy_r_reg[0] ),
        .I1(\arb_gnt_r_reg[1]_0 ),
        .I2(arb_done_i),
        .O(\gen_tdest_routing.busy_ns ));
  LUT3 #(
    .INIT(8'h0E)) 
    \gen_tdest_routing.busy_r[0]_i_1__0 
       (.I0(\gen_tdest_routing.busy_r_reg[0]_0 ),
        .I1(\arb_gnt_r_reg[0]_0 ),
        .I2(arb_done_i),
        .O(\gen_tdest_routing.busy_ns_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[0]_INST_0 
       (.I0(s_axis_tdata[0]),
        .I1(s_axis_tdata[256]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[0]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[100]_INST_0 
       (.I0(s_axis_tdata[100]),
        .I1(s_axis_tdata[356]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[100]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[101]_INST_0 
       (.I0(s_axis_tdata[101]),
        .I1(s_axis_tdata[357]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[101]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[102]_INST_0 
       (.I0(s_axis_tdata[102]),
        .I1(s_axis_tdata[358]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[102]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[103]_INST_0 
       (.I0(s_axis_tdata[103]),
        .I1(s_axis_tdata[359]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[103]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[104]_INST_0 
       (.I0(s_axis_tdata[104]),
        .I1(s_axis_tdata[360]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[104]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[105]_INST_0 
       (.I0(s_axis_tdata[105]),
        .I1(s_axis_tdata[361]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[105]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[106]_INST_0 
       (.I0(s_axis_tdata[106]),
        .I1(s_axis_tdata[362]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[106]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[107]_INST_0 
       (.I0(s_axis_tdata[107]),
        .I1(s_axis_tdata[363]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[107]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[108]_INST_0 
       (.I0(s_axis_tdata[108]),
        .I1(s_axis_tdata[364]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[108]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[109]_INST_0 
       (.I0(s_axis_tdata[109]),
        .I1(s_axis_tdata[365]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[109]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[10]_INST_0 
       (.I0(s_axis_tdata[10]),
        .I1(s_axis_tdata[266]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[10]));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[110]_INST_0 
       (.I0(s_axis_tdata[110]),
        .I1(s_axis_tdata[366]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[110]));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[111]_INST_0 
       (.I0(s_axis_tdata[111]),
        .I1(s_axis_tdata[367]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[111]));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[112]_INST_0 
       (.I0(s_axis_tdata[112]),
        .I1(s_axis_tdata[368]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[112]));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[113]_INST_0 
       (.I0(s_axis_tdata[113]),
        .I1(s_axis_tdata[369]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[113]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[114]_INST_0 
       (.I0(s_axis_tdata[114]),
        .I1(s_axis_tdata[370]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[114]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[115]_INST_0 
       (.I0(s_axis_tdata[115]),
        .I1(s_axis_tdata[371]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[115]));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[116]_INST_0 
       (.I0(s_axis_tdata[116]),
        .I1(s_axis_tdata[372]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[116]));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[117]_INST_0 
       (.I0(s_axis_tdata[117]),
        .I1(s_axis_tdata[373]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[117]));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[118]_INST_0 
       (.I0(s_axis_tdata[118]),
        .I1(s_axis_tdata[374]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[118]));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[119]_INST_0 
       (.I0(s_axis_tdata[119]),
        .I1(s_axis_tdata[375]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[119]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[11]_INST_0 
       (.I0(s_axis_tdata[11]),
        .I1(s_axis_tdata[267]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[11]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[120]_INST_0 
       (.I0(s_axis_tdata[120]),
        .I1(s_axis_tdata[376]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[120]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[121]_INST_0 
       (.I0(s_axis_tdata[121]),
        .I1(s_axis_tdata[377]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[121]));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[122]_INST_0 
       (.I0(s_axis_tdata[122]),
        .I1(s_axis_tdata[378]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[122]));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[123]_INST_0 
       (.I0(s_axis_tdata[123]),
        .I1(s_axis_tdata[379]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[123]));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[124]_INST_0 
       (.I0(s_axis_tdata[124]),
        .I1(s_axis_tdata[380]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[124]));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[125]_INST_0 
       (.I0(s_axis_tdata[125]),
        .I1(s_axis_tdata[381]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[125]));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[126]_INST_0 
       (.I0(s_axis_tdata[126]),
        .I1(s_axis_tdata[382]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[126]));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[127]_INST_0 
       (.I0(s_axis_tdata[127]),
        .I1(s_axis_tdata[383]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[127]));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[128]_INST_0 
       (.I0(s_axis_tdata[128]),
        .I1(s_axis_tdata[384]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[128]));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[129]_INST_0 
       (.I0(s_axis_tdata[129]),
        .I1(s_axis_tdata[385]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[129]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[12]_INST_0 
       (.I0(s_axis_tdata[12]),
        .I1(s_axis_tdata[268]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[12]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[130]_INST_0 
       (.I0(s_axis_tdata[130]),
        .I1(s_axis_tdata[386]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[130]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[131]_INST_0 
       (.I0(s_axis_tdata[131]),
        .I1(s_axis_tdata[387]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[131]));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[132]_INST_0 
       (.I0(s_axis_tdata[132]),
        .I1(s_axis_tdata[388]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[132]));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[133]_INST_0 
       (.I0(s_axis_tdata[133]),
        .I1(s_axis_tdata[389]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[133]));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[134]_INST_0 
       (.I0(s_axis_tdata[134]),
        .I1(s_axis_tdata[390]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[134]));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[135]_INST_0 
       (.I0(s_axis_tdata[135]),
        .I1(s_axis_tdata[391]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[135]));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[136]_INST_0 
       (.I0(s_axis_tdata[136]),
        .I1(s_axis_tdata[392]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[136]));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[137]_INST_0 
       (.I0(s_axis_tdata[137]),
        .I1(s_axis_tdata[393]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[137]));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[138]_INST_0 
       (.I0(s_axis_tdata[138]),
        .I1(s_axis_tdata[394]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[138]));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[139]_INST_0 
       (.I0(s_axis_tdata[139]),
        .I1(s_axis_tdata[395]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[139]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[13]_INST_0 
       (.I0(s_axis_tdata[13]),
        .I1(s_axis_tdata[269]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[13]));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[140]_INST_0 
       (.I0(s_axis_tdata[140]),
        .I1(s_axis_tdata[396]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[140]));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[141]_INST_0 
       (.I0(s_axis_tdata[141]),
        .I1(s_axis_tdata[397]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[141]));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[142]_INST_0 
       (.I0(s_axis_tdata[142]),
        .I1(s_axis_tdata[398]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[142]));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[143]_INST_0 
       (.I0(s_axis_tdata[143]),
        .I1(s_axis_tdata[399]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[143]));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[144]_INST_0 
       (.I0(s_axis_tdata[144]),
        .I1(s_axis_tdata[400]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[144]));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[145]_INST_0 
       (.I0(s_axis_tdata[145]),
        .I1(s_axis_tdata[401]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[145]));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[146]_INST_0 
       (.I0(s_axis_tdata[146]),
        .I1(s_axis_tdata[402]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[146]));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[147]_INST_0 
       (.I0(s_axis_tdata[147]),
        .I1(s_axis_tdata[403]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[147]));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[148]_INST_0 
       (.I0(s_axis_tdata[148]),
        .I1(s_axis_tdata[404]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[148]));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[149]_INST_0 
       (.I0(s_axis_tdata[149]),
        .I1(s_axis_tdata[405]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[149]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[14]_INST_0 
       (.I0(s_axis_tdata[14]),
        .I1(s_axis_tdata[270]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[14]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[150]_INST_0 
       (.I0(s_axis_tdata[150]),
        .I1(s_axis_tdata[406]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[150]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[151]_INST_0 
       (.I0(s_axis_tdata[151]),
        .I1(s_axis_tdata[407]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[151]));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[152]_INST_0 
       (.I0(s_axis_tdata[152]),
        .I1(s_axis_tdata[408]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[152]));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[153]_INST_0 
       (.I0(s_axis_tdata[153]),
        .I1(s_axis_tdata[409]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[153]));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[154]_INST_0 
       (.I0(s_axis_tdata[154]),
        .I1(s_axis_tdata[410]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[154]));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[155]_INST_0 
       (.I0(s_axis_tdata[155]),
        .I1(s_axis_tdata[411]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[155]));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[156]_INST_0 
       (.I0(s_axis_tdata[156]),
        .I1(s_axis_tdata[412]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[156]));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[157]_INST_0 
       (.I0(s_axis_tdata[157]),
        .I1(s_axis_tdata[413]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[157]));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[158]_INST_0 
       (.I0(s_axis_tdata[158]),
        .I1(s_axis_tdata[414]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[158]));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[159]_INST_0 
       (.I0(s_axis_tdata[159]),
        .I1(s_axis_tdata[415]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[159]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[15]_INST_0 
       (.I0(s_axis_tdata[15]),
        .I1(s_axis_tdata[271]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[15]));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[160]_INST_0 
       (.I0(s_axis_tdata[160]),
        .I1(s_axis_tdata[416]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[160]));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[161]_INST_0 
       (.I0(s_axis_tdata[161]),
        .I1(s_axis_tdata[417]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[161]));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[162]_INST_0 
       (.I0(s_axis_tdata[162]),
        .I1(s_axis_tdata[418]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[162]));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[163]_INST_0 
       (.I0(s_axis_tdata[163]),
        .I1(s_axis_tdata[419]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[163]));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[164]_INST_0 
       (.I0(s_axis_tdata[164]),
        .I1(s_axis_tdata[420]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[164]));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[165]_INST_0 
       (.I0(s_axis_tdata[165]),
        .I1(s_axis_tdata[421]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[165]));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[166]_INST_0 
       (.I0(s_axis_tdata[166]),
        .I1(s_axis_tdata[422]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[166]));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[167]_INST_0 
       (.I0(s_axis_tdata[167]),
        .I1(s_axis_tdata[423]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[167]));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[168]_INST_0 
       (.I0(s_axis_tdata[168]),
        .I1(s_axis_tdata[424]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[168]));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[169]_INST_0 
       (.I0(s_axis_tdata[169]),
        .I1(s_axis_tdata[425]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[169]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[16]_INST_0 
       (.I0(s_axis_tdata[16]),
        .I1(s_axis_tdata[272]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[16]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[170]_INST_0 
       (.I0(s_axis_tdata[170]),
        .I1(s_axis_tdata[426]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[170]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[171]_INST_0 
       (.I0(s_axis_tdata[171]),
        .I1(s_axis_tdata[427]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[171]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[172]_INST_0 
       (.I0(s_axis_tdata[172]),
        .I1(s_axis_tdata[428]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[172]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[173]_INST_0 
       (.I0(s_axis_tdata[173]),
        .I1(s_axis_tdata[429]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[173]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[174]_INST_0 
       (.I0(s_axis_tdata[174]),
        .I1(s_axis_tdata[430]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[174]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[175]_INST_0 
       (.I0(s_axis_tdata[175]),
        .I1(s_axis_tdata[431]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[175]));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[176]_INST_0 
       (.I0(s_axis_tdata[176]),
        .I1(s_axis_tdata[432]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[176]));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[177]_INST_0 
       (.I0(s_axis_tdata[177]),
        .I1(s_axis_tdata[433]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[177]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[178]_INST_0 
       (.I0(s_axis_tdata[178]),
        .I1(s_axis_tdata[434]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[178]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[179]_INST_0 
       (.I0(s_axis_tdata[179]),
        .I1(s_axis_tdata[435]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[179]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[17]_INST_0 
       (.I0(s_axis_tdata[17]),
        .I1(s_axis_tdata[273]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[17]));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[180]_INST_0 
       (.I0(s_axis_tdata[180]),
        .I1(s_axis_tdata[436]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[180]));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[181]_INST_0 
       (.I0(s_axis_tdata[181]),
        .I1(s_axis_tdata[437]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[181]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[182]_INST_0 
       (.I0(s_axis_tdata[182]),
        .I1(s_axis_tdata[438]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[182]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[183]_INST_0 
       (.I0(s_axis_tdata[183]),
        .I1(s_axis_tdata[439]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[183]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[184]_INST_0 
       (.I0(s_axis_tdata[184]),
        .I1(s_axis_tdata[440]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[184]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[185]_INST_0 
       (.I0(s_axis_tdata[185]),
        .I1(s_axis_tdata[441]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[185]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[186]_INST_0 
       (.I0(s_axis_tdata[186]),
        .I1(s_axis_tdata[442]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[186]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[187]_INST_0 
       (.I0(s_axis_tdata[187]),
        .I1(s_axis_tdata[443]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[187]));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[188]_INST_0 
       (.I0(s_axis_tdata[188]),
        .I1(s_axis_tdata[444]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[188]));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[189]_INST_0 
       (.I0(s_axis_tdata[189]),
        .I1(s_axis_tdata[445]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[189]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[18]_INST_0 
       (.I0(s_axis_tdata[18]),
        .I1(s_axis_tdata[274]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[18]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[190]_INST_0 
       (.I0(s_axis_tdata[190]),
        .I1(s_axis_tdata[446]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[190]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[191]_INST_0 
       (.I0(s_axis_tdata[191]),
        .I1(s_axis_tdata[447]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[191]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[192]_INST_0 
       (.I0(s_axis_tdata[192]),
        .I1(s_axis_tdata[448]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[192]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[193]_INST_0 
       (.I0(s_axis_tdata[193]),
        .I1(s_axis_tdata[449]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[193]));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[194]_INST_0 
       (.I0(s_axis_tdata[194]),
        .I1(s_axis_tdata[450]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[194]));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[195]_INST_0 
       (.I0(s_axis_tdata[195]),
        .I1(s_axis_tdata[451]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[195]));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[196]_INST_0 
       (.I0(s_axis_tdata[196]),
        .I1(s_axis_tdata[452]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[196]));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[197]_INST_0 
       (.I0(s_axis_tdata[197]),
        .I1(s_axis_tdata[453]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[197]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[198]_INST_0 
       (.I0(s_axis_tdata[198]),
        .I1(s_axis_tdata[454]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[198]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[199]_INST_0 
       (.I0(s_axis_tdata[199]),
        .I1(s_axis_tdata[455]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[199]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[19]_INST_0 
       (.I0(s_axis_tdata[19]),
        .I1(s_axis_tdata[275]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[19]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[1]_INST_0 
       (.I0(s_axis_tdata[1]),
        .I1(s_axis_tdata[257]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[1]));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[200]_INST_0 
       (.I0(s_axis_tdata[200]),
        .I1(s_axis_tdata[456]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[200]));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[201]_INST_0 
       (.I0(s_axis_tdata[201]),
        .I1(s_axis_tdata[457]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[201]));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[202]_INST_0 
       (.I0(s_axis_tdata[202]),
        .I1(s_axis_tdata[458]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[202]));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[203]_INST_0 
       (.I0(s_axis_tdata[203]),
        .I1(s_axis_tdata[459]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[203]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[204]_INST_0 
       (.I0(s_axis_tdata[204]),
        .I1(s_axis_tdata[460]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[204]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[205]_INST_0 
       (.I0(s_axis_tdata[205]),
        .I1(s_axis_tdata[461]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[205]));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[206]_INST_0 
       (.I0(s_axis_tdata[206]),
        .I1(s_axis_tdata[462]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[206]));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[207]_INST_0 
       (.I0(s_axis_tdata[207]),
        .I1(s_axis_tdata[463]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[207]));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[208]_INST_0 
       (.I0(s_axis_tdata[208]),
        .I1(s_axis_tdata[464]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[208]));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[209]_INST_0 
       (.I0(s_axis_tdata[209]),
        .I1(s_axis_tdata[465]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[209]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[20]_INST_0 
       (.I0(s_axis_tdata[20]),
        .I1(s_axis_tdata[276]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[20]));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[210]_INST_0 
       (.I0(s_axis_tdata[210]),
        .I1(s_axis_tdata[466]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[210]));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[211]_INST_0 
       (.I0(s_axis_tdata[211]),
        .I1(s_axis_tdata[467]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[211]));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[212]_INST_0 
       (.I0(s_axis_tdata[212]),
        .I1(s_axis_tdata[468]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[212]));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[213]_INST_0 
       (.I0(s_axis_tdata[213]),
        .I1(s_axis_tdata[469]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[213]));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[214]_INST_0 
       (.I0(s_axis_tdata[214]),
        .I1(s_axis_tdata[470]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[214]));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[215]_INST_0 
       (.I0(s_axis_tdata[215]),
        .I1(s_axis_tdata[471]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[215]));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[216]_INST_0 
       (.I0(s_axis_tdata[216]),
        .I1(s_axis_tdata[472]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[216]));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[217]_INST_0 
       (.I0(s_axis_tdata[217]),
        .I1(s_axis_tdata[473]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[217]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[218]_INST_0 
       (.I0(s_axis_tdata[218]),
        .I1(s_axis_tdata[474]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[218]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[219]_INST_0 
       (.I0(s_axis_tdata[219]),
        .I1(s_axis_tdata[475]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[219]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[21]_INST_0 
       (.I0(s_axis_tdata[21]),
        .I1(s_axis_tdata[277]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[21]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[220]_INST_0 
       (.I0(s_axis_tdata[220]),
        .I1(s_axis_tdata[476]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[220]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[221]_INST_0 
       (.I0(s_axis_tdata[221]),
        .I1(s_axis_tdata[477]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[221]));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[222]_INST_0 
       (.I0(s_axis_tdata[222]),
        .I1(s_axis_tdata[478]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[222]));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[223]_INST_0 
       (.I0(s_axis_tdata[223]),
        .I1(s_axis_tdata[479]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[223]));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[224]_INST_0 
       (.I0(s_axis_tdata[224]),
        .I1(s_axis_tdata[480]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[224]));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[225]_INST_0 
       (.I0(s_axis_tdata[225]),
        .I1(s_axis_tdata[481]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[225]));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[226]_INST_0 
       (.I0(s_axis_tdata[226]),
        .I1(s_axis_tdata[482]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[226]));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[227]_INST_0 
       (.I0(s_axis_tdata[227]),
        .I1(s_axis_tdata[483]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[227]));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[228]_INST_0 
       (.I0(s_axis_tdata[228]),
        .I1(s_axis_tdata[484]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[228]));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[229]_INST_0 
       (.I0(s_axis_tdata[229]),
        .I1(s_axis_tdata[485]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[229]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[22]_INST_0 
       (.I0(s_axis_tdata[22]),
        .I1(s_axis_tdata[278]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[22]));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[230]_INST_0 
       (.I0(s_axis_tdata[230]),
        .I1(s_axis_tdata[486]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[230]));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[231]_INST_0 
       (.I0(s_axis_tdata[231]),
        .I1(s_axis_tdata[487]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[231]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[232]_INST_0 
       (.I0(s_axis_tdata[232]),
        .I1(s_axis_tdata[488]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[232]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[233]_INST_0 
       (.I0(s_axis_tdata[233]),
        .I1(s_axis_tdata[489]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[233]));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[234]_INST_0 
       (.I0(s_axis_tdata[234]),
        .I1(s_axis_tdata[490]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[234]));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[235]_INST_0 
       (.I0(s_axis_tdata[235]),
        .I1(s_axis_tdata[491]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[235]));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[236]_INST_0 
       (.I0(s_axis_tdata[236]),
        .I1(s_axis_tdata[492]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[236]));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[237]_INST_0 
       (.I0(s_axis_tdata[237]),
        .I1(s_axis_tdata[493]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[237]));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[238]_INST_0 
       (.I0(s_axis_tdata[238]),
        .I1(s_axis_tdata[494]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[238]));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[239]_INST_0 
       (.I0(s_axis_tdata[239]),
        .I1(s_axis_tdata[495]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[239]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[23]_INST_0 
       (.I0(s_axis_tdata[23]),
        .I1(s_axis_tdata[279]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[23]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[240]_INST_0 
       (.I0(s_axis_tdata[240]),
        .I1(s_axis_tdata[496]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[240]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[241]_INST_0 
       (.I0(s_axis_tdata[241]),
        .I1(s_axis_tdata[497]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[241]));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[242]_INST_0 
       (.I0(s_axis_tdata[242]),
        .I1(s_axis_tdata[498]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[242]));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[243]_INST_0 
       (.I0(s_axis_tdata[243]),
        .I1(s_axis_tdata[499]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[243]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[244]_INST_0 
       (.I0(s_axis_tdata[244]),
        .I1(s_axis_tdata[500]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[244]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[245]_INST_0 
       (.I0(s_axis_tdata[245]),
        .I1(s_axis_tdata[501]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[245]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[246]_INST_0 
       (.I0(s_axis_tdata[246]),
        .I1(s_axis_tdata[502]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[246]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[247]_INST_0 
       (.I0(s_axis_tdata[247]),
        .I1(s_axis_tdata[503]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[247]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[248]_INST_0 
       (.I0(s_axis_tdata[248]),
        .I1(s_axis_tdata[504]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[248]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[249]_INST_0 
       (.I0(s_axis_tdata[249]),
        .I1(s_axis_tdata[505]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[249]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[24]_INST_0 
       (.I0(s_axis_tdata[24]),
        .I1(s_axis_tdata[280]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[24]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[250]_INST_0 
       (.I0(s_axis_tdata[250]),
        .I1(s_axis_tdata[506]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[250]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[251]_INST_0 
       (.I0(s_axis_tdata[251]),
        .I1(s_axis_tdata[507]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[251]));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[252]_INST_0 
       (.I0(s_axis_tdata[252]),
        .I1(s_axis_tdata[508]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[252]));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[253]_INST_0 
       (.I0(s_axis_tdata[253]),
        .I1(s_axis_tdata[509]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[253]));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[254]_INST_0 
       (.I0(s_axis_tdata[254]),
        .I1(s_axis_tdata[510]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[254]));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[255]_INST_0 
       (.I0(s_axis_tdata[255]),
        .I1(s_axis_tdata[511]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[255]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[25]_INST_0 
       (.I0(s_axis_tdata[25]),
        .I1(s_axis_tdata[281]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[25]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[26]_INST_0 
       (.I0(s_axis_tdata[26]),
        .I1(s_axis_tdata[282]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[26]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[27]_INST_0 
       (.I0(s_axis_tdata[27]),
        .I1(s_axis_tdata[283]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[27]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[28]_INST_0 
       (.I0(s_axis_tdata[28]),
        .I1(s_axis_tdata[284]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[28]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[29]_INST_0 
       (.I0(s_axis_tdata[29]),
        .I1(s_axis_tdata[285]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[29]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[2]_INST_0 
       (.I0(s_axis_tdata[2]),
        .I1(s_axis_tdata[258]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[2]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[30]_INST_0 
       (.I0(s_axis_tdata[30]),
        .I1(s_axis_tdata[286]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[30]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[31]_INST_0 
       (.I0(s_axis_tdata[31]),
        .I1(s_axis_tdata[287]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[31]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[32]_INST_0 
       (.I0(s_axis_tdata[32]),
        .I1(s_axis_tdata[288]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[32]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[33]_INST_0 
       (.I0(s_axis_tdata[33]),
        .I1(s_axis_tdata[289]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[33]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[34]_INST_0 
       (.I0(s_axis_tdata[34]),
        .I1(s_axis_tdata[290]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[34]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[35]_INST_0 
       (.I0(s_axis_tdata[35]),
        .I1(s_axis_tdata[291]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[35]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[36]_INST_0 
       (.I0(s_axis_tdata[36]),
        .I1(s_axis_tdata[292]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[36]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[37]_INST_0 
       (.I0(s_axis_tdata[37]),
        .I1(s_axis_tdata[293]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[37]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[38]_INST_0 
       (.I0(s_axis_tdata[38]),
        .I1(s_axis_tdata[294]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[38]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[39]_INST_0 
       (.I0(s_axis_tdata[39]),
        .I1(s_axis_tdata[295]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[39]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[3]_INST_0 
       (.I0(s_axis_tdata[3]),
        .I1(s_axis_tdata[259]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[3]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[40]_INST_0 
       (.I0(s_axis_tdata[40]),
        .I1(s_axis_tdata[296]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[40]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[41]_INST_0 
       (.I0(s_axis_tdata[41]),
        .I1(s_axis_tdata[297]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[41]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[42]_INST_0 
       (.I0(s_axis_tdata[42]),
        .I1(s_axis_tdata[298]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[42]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[43]_INST_0 
       (.I0(s_axis_tdata[43]),
        .I1(s_axis_tdata[299]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[43]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[44]_INST_0 
       (.I0(s_axis_tdata[44]),
        .I1(s_axis_tdata[300]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[44]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[45]_INST_0 
       (.I0(s_axis_tdata[45]),
        .I1(s_axis_tdata[301]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[45]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[46]_INST_0 
       (.I0(s_axis_tdata[46]),
        .I1(s_axis_tdata[302]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[46]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[47]_INST_0 
       (.I0(s_axis_tdata[47]),
        .I1(s_axis_tdata[303]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[47]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[48]_INST_0 
       (.I0(s_axis_tdata[48]),
        .I1(s_axis_tdata[304]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[48]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[49]_INST_0 
       (.I0(s_axis_tdata[49]),
        .I1(s_axis_tdata[305]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[49]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[4]_INST_0 
       (.I0(s_axis_tdata[4]),
        .I1(s_axis_tdata[260]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[4]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[50]_INST_0 
       (.I0(s_axis_tdata[50]),
        .I1(s_axis_tdata[306]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[50]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[51]_INST_0 
       (.I0(s_axis_tdata[51]),
        .I1(s_axis_tdata[307]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[51]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[52]_INST_0 
       (.I0(s_axis_tdata[52]),
        .I1(s_axis_tdata[308]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[52]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[53]_INST_0 
       (.I0(s_axis_tdata[53]),
        .I1(s_axis_tdata[309]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[53]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[54]_INST_0 
       (.I0(s_axis_tdata[54]),
        .I1(s_axis_tdata[310]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[54]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[55]_INST_0 
       (.I0(s_axis_tdata[55]),
        .I1(s_axis_tdata[311]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[55]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[56]_INST_0 
       (.I0(s_axis_tdata[56]),
        .I1(s_axis_tdata[312]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[56]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[57]_INST_0 
       (.I0(s_axis_tdata[57]),
        .I1(s_axis_tdata[313]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[57]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[58]_INST_0 
       (.I0(s_axis_tdata[58]),
        .I1(s_axis_tdata[314]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[58]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[59]_INST_0 
       (.I0(s_axis_tdata[59]),
        .I1(s_axis_tdata[315]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[59]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[5]_INST_0 
       (.I0(s_axis_tdata[5]),
        .I1(s_axis_tdata[261]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[5]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[60]_INST_0 
       (.I0(s_axis_tdata[60]),
        .I1(s_axis_tdata[316]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[60]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[61]_INST_0 
       (.I0(s_axis_tdata[61]),
        .I1(s_axis_tdata[317]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[61]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[62]_INST_0 
       (.I0(s_axis_tdata[62]),
        .I1(s_axis_tdata[318]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[62]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[63]_INST_0 
       (.I0(s_axis_tdata[63]),
        .I1(s_axis_tdata[319]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[63]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[64]_INST_0 
       (.I0(s_axis_tdata[64]),
        .I1(s_axis_tdata[320]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[64]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[65]_INST_0 
       (.I0(s_axis_tdata[65]),
        .I1(s_axis_tdata[321]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[65]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[66]_INST_0 
       (.I0(s_axis_tdata[66]),
        .I1(s_axis_tdata[322]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[66]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[67]_INST_0 
       (.I0(s_axis_tdata[67]),
        .I1(s_axis_tdata[323]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[67]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[68]_INST_0 
       (.I0(s_axis_tdata[68]),
        .I1(s_axis_tdata[324]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[68]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[69]_INST_0 
       (.I0(s_axis_tdata[69]),
        .I1(s_axis_tdata[325]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[69]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[6]_INST_0 
       (.I0(s_axis_tdata[6]),
        .I1(s_axis_tdata[262]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[6]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[70]_INST_0 
       (.I0(s_axis_tdata[70]),
        .I1(s_axis_tdata[326]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[70]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[71]_INST_0 
       (.I0(s_axis_tdata[71]),
        .I1(s_axis_tdata[327]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[71]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[72]_INST_0 
       (.I0(s_axis_tdata[72]),
        .I1(s_axis_tdata[328]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[72]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[73]_INST_0 
       (.I0(s_axis_tdata[73]),
        .I1(s_axis_tdata[329]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[73]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[74]_INST_0 
       (.I0(s_axis_tdata[74]),
        .I1(s_axis_tdata[330]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[74]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[75]_INST_0 
       (.I0(s_axis_tdata[75]),
        .I1(s_axis_tdata[331]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[75]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[76]_INST_0 
       (.I0(s_axis_tdata[76]),
        .I1(s_axis_tdata[332]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[76]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[77]_INST_0 
       (.I0(s_axis_tdata[77]),
        .I1(s_axis_tdata[333]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[77]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[78]_INST_0 
       (.I0(s_axis_tdata[78]),
        .I1(s_axis_tdata[334]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[78]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[79]_INST_0 
       (.I0(s_axis_tdata[79]),
        .I1(s_axis_tdata[335]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[79]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[7]_INST_0 
       (.I0(s_axis_tdata[7]),
        .I1(s_axis_tdata[263]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[7]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[80]_INST_0 
       (.I0(s_axis_tdata[80]),
        .I1(s_axis_tdata[336]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[80]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[81]_INST_0 
       (.I0(s_axis_tdata[81]),
        .I1(s_axis_tdata[337]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[81]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[82]_INST_0 
       (.I0(s_axis_tdata[82]),
        .I1(s_axis_tdata[338]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[82]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[83]_INST_0 
       (.I0(s_axis_tdata[83]),
        .I1(s_axis_tdata[339]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[83]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[84]_INST_0 
       (.I0(s_axis_tdata[84]),
        .I1(s_axis_tdata[340]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[84]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[85]_INST_0 
       (.I0(s_axis_tdata[85]),
        .I1(s_axis_tdata[341]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[85]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[86]_INST_0 
       (.I0(s_axis_tdata[86]),
        .I1(s_axis_tdata[342]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[86]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[87]_INST_0 
       (.I0(s_axis_tdata[87]),
        .I1(s_axis_tdata[343]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[87]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[88]_INST_0 
       (.I0(s_axis_tdata[88]),
        .I1(s_axis_tdata[344]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[88]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[89]_INST_0 
       (.I0(s_axis_tdata[89]),
        .I1(s_axis_tdata[345]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[89]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[8]_INST_0 
       (.I0(s_axis_tdata[8]),
        .I1(s_axis_tdata[264]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[8]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[90]_INST_0 
       (.I0(s_axis_tdata[90]),
        .I1(s_axis_tdata[346]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[90]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[91]_INST_0 
       (.I0(s_axis_tdata[91]),
        .I1(s_axis_tdata[347]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[91]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[92]_INST_0 
       (.I0(s_axis_tdata[92]),
        .I1(s_axis_tdata[348]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[92]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[93]_INST_0 
       (.I0(s_axis_tdata[93]),
        .I1(s_axis_tdata[349]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[93]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[94]_INST_0 
       (.I0(s_axis_tdata[94]),
        .I1(s_axis_tdata[350]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[94]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[95]_INST_0 
       (.I0(s_axis_tdata[95]),
        .I1(s_axis_tdata[351]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[95]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[96]_INST_0 
       (.I0(s_axis_tdata[96]),
        .I1(s_axis_tdata[352]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[96]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[97]_INST_0 
       (.I0(s_axis_tdata[97]),
        .I1(s_axis_tdata[353]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[97]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[98]_INST_0 
       (.I0(s_axis_tdata[98]),
        .I1(s_axis_tdata[354]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[98]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[99]_INST_0 
       (.I0(s_axis_tdata[99]),
        .I1(s_axis_tdata[355]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[99]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \m_axis_tdata[9]_INST_0 
       (.I0(s_axis_tdata[9]),
        .I1(s_axis_tdata[265]),
        .I2(arb_sel_i),
        .O(m_axis_tdata[9]));
  LUT6 #(
    .INIT(64'hD8D8D8D8D8D8D800)) 
    \m_axis_tvalid[0]_INST_0 
       (.I0(arb_sel_i),
        .I1(s_axis_tvalid[1]),
        .I2(s_axis_tvalid[0]),
        .I3(\arb_gnt_r_reg[1]_1 ),
        .I4(\arb_gnt_r_reg[0]_0 ),
        .I5(\gen_tdest_router.busy_r [0]),
        .O(m_axis_tvalid));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \m_axis_tvalid[0]_INST_0_i_1 
       (.I0(\arb_gnt_r_reg[1]_0 ),
        .I1(\gen_tdest_router.busy_r [1]),
        .O(\arb_gnt_r_reg[1]_1 ));
  FDRE \port_priority_r_reg[0] 
       (.C(aclk),
        .CE(\barrel_cntr[0]_i_1_n_0 ),
        .D(port_priority_ns[0]),
        .Q(port_priority_ns[1]),
        .R(\arb_gnt_r_reg[1]_2 ));
  FDSE \port_priority_r_reg[1] 
       (.C(aclk),
        .CE(\barrel_cntr[0]_i_1_n_0 ),
        .D(port_priority_ns[1]),
        .Q(port_priority_ns[0]),
        .S(\arb_gnt_r_reg[1]_2 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hA800)) 
    \s_axis_tready[0]_INST_0 
       (.I0(s_axis_tvalid[0]),
        .I1(\arb_gnt_r_reg[0]_0 ),
        .I2(\gen_tdest_router.busy_r [0]),
        .I3(m_axis_tready),
        .O(s_axis_tready[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hA800)) 
    \s_axis_tready[1]_INST_0 
       (.I0(s_axis_tvalid[1]),
        .I1(\arb_gnt_r_reg[1]_0 ),
        .I2(\gen_tdest_router.busy_r [1]),
        .I3(m_axis_tready),
        .O(s_axis_tready[1]));
endmodule

(* C_ARB_ALGORITHM = "0" *) (* C_ARB_ON_MAX_XFERS = "1" *) (* C_ARB_ON_NUM_CYCLES = "0" *) 
(* C_ARB_ON_TLAST = "0" *) (* C_AXIS_SIGNAL_SET = "3" *) (* C_AXIS_TDATA_WIDTH = "256" *) 
(* C_AXIS_TDEST_WIDTH = "1" *) (* C_AXIS_TID_WIDTH = "1" *) (* C_AXIS_TUSER_WIDTH = "1" *) 
(* C_COMMON_CLOCK = "0" *) (* C_DECODER_REG = "0" *) (* C_FAMILY = "virtexuplusHBM" *) 
(* C_INCLUDE_ARBITER = "1" *) (* C_LOG_SI_SLOTS = "1" *) (* C_M_AXIS_BASETDEST_ARRAY = "1'b0" *) 
(* C_M_AXIS_CONNECTIVITY_ARRAY = "2'b11" *) (* C_M_AXIS_HIGHTDEST_ARRAY = "1'b0" *) (* C_NUM_MI_SLOTS = "1" *) 
(* C_NUM_SI_SLOTS = "2" *) (* C_OUTPUT_REG = "0" *) (* C_ROUTING_MODE = "0" *) 
(* C_S_AXI_CTRL_ADDR_WIDTH = "7" *) (* C_S_AXI_CTRL_DATA_WIDTH = "32" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* G_INDX_SS_TDATA = "1" *) (* G_INDX_SS_TDEST = "6" *) (* G_INDX_SS_TID = "5" *) 
(* G_INDX_SS_TKEEP = "3" *) (* G_INDX_SS_TLAST = "4" *) (* G_INDX_SS_TREADY = "0" *) 
(* G_INDX_SS_TSTRB = "2" *) (* G_INDX_SS_TUSER = "7" *) (* G_MASK_SS_TDATA = "2" *) 
(* G_MASK_SS_TDEST = "64" *) (* G_MASK_SS_TID = "32" *) (* G_MASK_SS_TKEEP = "8" *) 
(* G_MASK_SS_TLAST = "16" *) (* G_MASK_SS_TREADY = "1" *) (* G_MASK_SS_TSTRB = "4" *) 
(* G_MASK_SS_TUSER = "128" *) (* G_TASK_SEVERITY_ERR = "2" *) (* G_TASK_SEVERITY_INFO = "0" *) 
(* G_TASK_SEVERITY_WARNING = "1" *) (* LP_CTRL_REG_WIDTH = "15" *) (* LP_MERGEDOWN_MUX = "0" *) 
(* LP_NUM_SYNCHRONIZER_STAGES = "4" *) (* ORIG_REF_NAME = "axis_switch_v1_1_22_axis_switch" *) (* P_DECODER_CONNECTIVITY_ARRAY = "2'b11" *) 
(* P_SINGLE_SLAVE_CONNECTIVITY_ARRAY = "1'b0" *) (* P_TPAYLOAD_WIDTH = "256" *) 
module axis_switch_0_axis_switch_v1_1_22_axis_switch
   (aclk,
    aresetn,
    aclken,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser,
    arb_req,
    arb_done,
    arb_gnt,
    arb_sel,
    arb_last,
    arb_id,
    arb_dest,
    arb_user,
    s_req_suppress,
    s_axi_ctrl_aclk,
    s_axi_ctrl_aresetn,
    s_axi_ctrl_awvalid,
    s_axi_ctrl_awready,
    s_axi_ctrl_awaddr,
    s_axi_ctrl_wvalid,
    s_axi_ctrl_wready,
    s_axi_ctrl_wdata,
    s_axi_ctrl_bvalid,
    s_axi_ctrl_bready,
    s_axi_ctrl_bresp,
    s_axi_ctrl_arvalid,
    s_axi_ctrl_arready,
    s_axi_ctrl_araddr,
    s_axi_ctrl_rvalid,
    s_axi_ctrl_rready,
    s_axi_ctrl_rdata,
    s_axi_ctrl_rresp,
    s_decode_err);
  input aclk;
  input aresetn;
  input aclken;
  input [1:0]s_axis_tvalid;
  output [1:0]s_axis_tready;
  input [511:0]s_axis_tdata;
  input [63:0]s_axis_tstrb;
  input [63:0]s_axis_tkeep;
  input [1:0]s_axis_tlast;
  input [1:0]s_axis_tid;
  input [1:0]s_axis_tdest;
  input [1:0]s_axis_tuser;
  output [0:0]m_axis_tvalid;
  input [0:0]m_axis_tready;
  output [255:0]m_axis_tdata;
  output [31:0]m_axis_tstrb;
  output [31:0]m_axis_tkeep;
  output [0:0]m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [0:0]m_axis_tuser;
  output [1:0]arb_req;
  output [0:0]arb_done;
  input [1:0]arb_gnt;
  input [0:0]arb_sel;
  output [1:0]arb_last;
  output [1:0]arb_id;
  output [1:0]arb_dest;
  output [1:0]arb_user;
  input [1:0]s_req_suppress;
  input s_axi_ctrl_aclk;
  input s_axi_ctrl_aresetn;
  input s_axi_ctrl_awvalid;
  output s_axi_ctrl_awready;
  input [6:0]s_axi_ctrl_awaddr;
  input s_axi_ctrl_wvalid;
  output s_axi_ctrl_wready;
  input [31:0]s_axi_ctrl_wdata;
  output s_axi_ctrl_bvalid;
  input s_axi_ctrl_bready;
  output [1:0]s_axi_ctrl_bresp;
  input s_axi_ctrl_arvalid;
  output s_axi_ctrl_arready;
  input [6:0]s_axi_ctrl_araddr;
  output s_axi_ctrl_rvalid;
  input s_axi_ctrl_rready;
  output [31:0]s_axi_ctrl_rdata;
  output [1:0]s_axi_ctrl_rresp;
  output [1:0]s_decode_err;

  wire \<const0> ;
  wire aclk;
  wire [1:0]arb_gnt_i;
  wire areset;
  wire aresetn;
  wire \gen_decoder[0].axisc_decoder_0_n_0 ;
  wire \gen_decoder[1].axisc_decoder_0_n_0 ;
  wire \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_5 ;
  wire \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_8 ;
  wire \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_9 ;
  wire [1:0]\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1 ;
  wire \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/valid_i ;
  wire [1:0]\gen_tdest_router.busy_r ;
  wire \gen_tdest_routing.busy_ns ;
  wire \gen_tdest_routing.busy_ns_0 ;
  wire [255:0]m_axis_tdata;
  wire [0:0]m_axis_tready;
  wire [0:0]m_axis_tvalid;
  wire [511:0]s_axis_tdata;
  wire [1:0]s_axis_tready;
  wire [1:0]s_axis_tvalid;
  wire [1:0]s_req_suppress;

  assign arb_dest[1] = \<const0> ;
  assign arb_dest[0] = \<const0> ;
  assign arb_done[0] = \<const0> ;
  assign arb_id[1] = \<const0> ;
  assign arb_id[0] = \<const0> ;
  assign arb_last[1] = \<const0> ;
  assign arb_last[0] = \<const0> ;
  assign arb_req[1] = \<const0> ;
  assign arb_req[0] = \<const0> ;
  assign arb_user[1] = \<const0> ;
  assign arb_user[0] = \<const0> ;
  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tkeep[31] = \<const0> ;
  assign m_axis_tkeep[30] = \<const0> ;
  assign m_axis_tkeep[29] = \<const0> ;
  assign m_axis_tkeep[28] = \<const0> ;
  assign m_axis_tkeep[27] = \<const0> ;
  assign m_axis_tkeep[26] = \<const0> ;
  assign m_axis_tkeep[25] = \<const0> ;
  assign m_axis_tkeep[24] = \<const0> ;
  assign m_axis_tkeep[23] = \<const0> ;
  assign m_axis_tkeep[22] = \<const0> ;
  assign m_axis_tkeep[21] = \<const0> ;
  assign m_axis_tkeep[20] = \<const0> ;
  assign m_axis_tkeep[19] = \<const0> ;
  assign m_axis_tkeep[18] = \<const0> ;
  assign m_axis_tkeep[17] = \<const0> ;
  assign m_axis_tkeep[16] = \<const0> ;
  assign m_axis_tkeep[15] = \<const0> ;
  assign m_axis_tkeep[14] = \<const0> ;
  assign m_axis_tkeep[13] = \<const0> ;
  assign m_axis_tkeep[12] = \<const0> ;
  assign m_axis_tkeep[11] = \<const0> ;
  assign m_axis_tkeep[10] = \<const0> ;
  assign m_axis_tkeep[9] = \<const0> ;
  assign m_axis_tkeep[8] = \<const0> ;
  assign m_axis_tkeep[7] = \<const0> ;
  assign m_axis_tkeep[6] = \<const0> ;
  assign m_axis_tkeep[5] = \<const0> ;
  assign m_axis_tkeep[4] = \<const0> ;
  assign m_axis_tkeep[3] = \<const0> ;
  assign m_axis_tkeep[2] = \<const0> ;
  assign m_axis_tkeep[1] = \<const0> ;
  assign m_axis_tkeep[0] = \<const0> ;
  assign m_axis_tlast[0] = \<const0> ;
  assign m_axis_tstrb[31] = \<const0> ;
  assign m_axis_tstrb[30] = \<const0> ;
  assign m_axis_tstrb[29] = \<const0> ;
  assign m_axis_tstrb[28] = \<const0> ;
  assign m_axis_tstrb[27] = \<const0> ;
  assign m_axis_tstrb[26] = \<const0> ;
  assign m_axis_tstrb[25] = \<const0> ;
  assign m_axis_tstrb[24] = \<const0> ;
  assign m_axis_tstrb[23] = \<const0> ;
  assign m_axis_tstrb[22] = \<const0> ;
  assign m_axis_tstrb[21] = \<const0> ;
  assign m_axis_tstrb[20] = \<const0> ;
  assign m_axis_tstrb[19] = \<const0> ;
  assign m_axis_tstrb[18] = \<const0> ;
  assign m_axis_tstrb[17] = \<const0> ;
  assign m_axis_tstrb[16] = \<const0> ;
  assign m_axis_tstrb[15] = \<const0> ;
  assign m_axis_tstrb[14] = \<const0> ;
  assign m_axis_tstrb[13] = \<const0> ;
  assign m_axis_tstrb[12] = \<const0> ;
  assign m_axis_tstrb[11] = \<const0> ;
  assign m_axis_tstrb[10] = \<const0> ;
  assign m_axis_tstrb[9] = \<const0> ;
  assign m_axis_tstrb[8] = \<const0> ;
  assign m_axis_tstrb[7] = \<const0> ;
  assign m_axis_tstrb[6] = \<const0> ;
  assign m_axis_tstrb[5] = \<const0> ;
  assign m_axis_tstrb[4] = \<const0> ;
  assign m_axis_tstrb[3] = \<const0> ;
  assign m_axis_tstrb[2] = \<const0> ;
  assign m_axis_tstrb[1] = \<const0> ;
  assign m_axis_tstrb[0] = \<const0> ;
  assign m_axis_tuser[0] = \<const0> ;
  assign s_axi_ctrl_arready = \<const0> ;
  assign s_axi_ctrl_awready = \<const0> ;
  assign s_axi_ctrl_bresp[1] = \<const0> ;
  assign s_axi_ctrl_bresp[0] = \<const0> ;
  assign s_axi_ctrl_bvalid = \<const0> ;
  assign s_axi_ctrl_rdata[31] = \<const0> ;
  assign s_axi_ctrl_rdata[30] = \<const0> ;
  assign s_axi_ctrl_rdata[29] = \<const0> ;
  assign s_axi_ctrl_rdata[28] = \<const0> ;
  assign s_axi_ctrl_rdata[27] = \<const0> ;
  assign s_axi_ctrl_rdata[26] = \<const0> ;
  assign s_axi_ctrl_rdata[25] = \<const0> ;
  assign s_axi_ctrl_rdata[24] = \<const0> ;
  assign s_axi_ctrl_rdata[23] = \<const0> ;
  assign s_axi_ctrl_rdata[22] = \<const0> ;
  assign s_axi_ctrl_rdata[21] = \<const0> ;
  assign s_axi_ctrl_rdata[20] = \<const0> ;
  assign s_axi_ctrl_rdata[19] = \<const0> ;
  assign s_axi_ctrl_rdata[18] = \<const0> ;
  assign s_axi_ctrl_rdata[17] = \<const0> ;
  assign s_axi_ctrl_rdata[16] = \<const0> ;
  assign s_axi_ctrl_rdata[15] = \<const0> ;
  assign s_axi_ctrl_rdata[14] = \<const0> ;
  assign s_axi_ctrl_rdata[13] = \<const0> ;
  assign s_axi_ctrl_rdata[12] = \<const0> ;
  assign s_axi_ctrl_rdata[11] = \<const0> ;
  assign s_axi_ctrl_rdata[10] = \<const0> ;
  assign s_axi_ctrl_rdata[9] = \<const0> ;
  assign s_axi_ctrl_rdata[8] = \<const0> ;
  assign s_axi_ctrl_rdata[7] = \<const0> ;
  assign s_axi_ctrl_rdata[6] = \<const0> ;
  assign s_axi_ctrl_rdata[5] = \<const0> ;
  assign s_axi_ctrl_rdata[4] = \<const0> ;
  assign s_axi_ctrl_rdata[3] = \<const0> ;
  assign s_axi_ctrl_rdata[2] = \<const0> ;
  assign s_axi_ctrl_rdata[1] = \<const0> ;
  assign s_axi_ctrl_rdata[0] = \<const0> ;
  assign s_axi_ctrl_rresp[1] = \<const0> ;
  assign s_axi_ctrl_rresp[0] = \<const0> ;
  assign s_axi_ctrl_rvalid = \<const0> ;
  assign s_axi_ctrl_wready = \<const0> ;
  assign s_decode_err[1] = \<const0> ;
  assign s_decode_err[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  axis_switch_0_axis_switch_v1_1_22_axisc_decoder \gen_decoder[0].axisc_decoder_0 
       (.aclk(aclk),
        .arb_gnt_i(arb_gnt_i[0]),
        .arb_req_i__1(\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1 [0]),
        .areset(areset),
        .\gen_tdest_routing.busy_ns (\gen_tdest_routing.busy_ns ),
        .\gen_tdest_routing.busy_r_reg[0]_0 (\gen_decoder[0].axisc_decoder_0_n_0 ),
        .s_axis_tvalid(s_axis_tvalid[0]),
        .s_req_suppress(s_req_suppress[0]));
  axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0 \gen_decoder[1].axisc_decoder_0 
       (.aclk(aclk),
        .arb_busy_r_reg(\gen_decoder[0].axisc_decoder_0_n_0 ),
        .arb_gnt_i(arb_gnt_i),
        .arb_req_i__1(\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1 [1]),
        .areset(areset),
        .\gen_tdest_routing.busy_ns (\gen_tdest_routing.busy_ns_0 ),
        .\gen_tdest_routing.busy_r_reg[0]_0 (\gen_decoder[1].axisc_decoder_0_n_0 ),
        .s_axis_tvalid(s_axis_tvalid),
        .s_req_suppress(s_req_suppress),
        .valid_i(\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/valid_i ));
  axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter 
       (.aclk(aclk),
        .arb_gnt_i(arb_gnt_i),
        .\arb_gnt_r_reg[0] (\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_8 ),
        .\arb_gnt_r_reg[1] (\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_9 ),
        .arb_req_i__1(\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1 ),
        .areset(areset),
        .areset_reg_0(\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_5 ),
        .aresetn(aresetn),
        .\gen_tdest_router.busy_r (\gen_tdest_router.busy_r ),
        .\gen_tdest_routing.busy_ns (\gen_tdest_routing.busy_ns_0 ),
        .\gen_tdest_routing.busy_ns_0 (\gen_tdest_routing.busy_ns ),
        .\gen_tdest_routing.busy_r_reg[0] (\gen_decoder[1].axisc_decoder_0_n_0 ),
        .\gen_tdest_routing.busy_r_reg[0]_0 (\gen_decoder[0].axisc_decoder_0_n_0 ),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tready(s_axis_tready),
        .s_axis_tvalid(s_axis_tvalid),
        .valid_i(\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/valid_i ));
  axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux \gen_transfer_mux[0].axisc_transfer_mux_0 
       (.aclk(aclk),
        .\busy_r_reg[0] (\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_5 ),
        .\busy_r_reg[0]_0 (\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_8 ),
        .\busy_r_reg[1] (\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_9 ),
        .\gen_tdest_router.busy_r (\gen_tdest_router.busy_r ));
endmodule

(* ORIG_REF_NAME = "axis_switch_v1_1_22_axis_switch_arbiter" *) 
module axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter
   (areset,
    s_axis_tready,
    arb_gnt_i,
    areset_reg_0,
    \gen_tdest_routing.busy_ns ,
    \gen_tdest_routing.busy_ns_0 ,
    \arb_gnt_r_reg[0] ,
    \arb_gnt_r_reg[1] ,
    m_axis_tvalid,
    m_axis_tdata,
    aclk,
    s_axis_tvalid,
    \gen_tdest_router.busy_r ,
    m_axis_tready,
    valid_i,
    arb_req_i__1,
    \gen_tdest_routing.busy_r_reg[0] ,
    \gen_tdest_routing.busy_r_reg[0]_0 ,
    s_axis_tdata,
    aresetn);
  output areset;
  output [1:0]s_axis_tready;
  output [1:0]arb_gnt_i;
  output areset_reg_0;
  output \gen_tdest_routing.busy_ns ;
  output \gen_tdest_routing.busy_ns_0 ;
  output \arb_gnt_r_reg[0] ;
  output \arb_gnt_r_reg[1] ;
  output [0:0]m_axis_tvalid;
  output [255:0]m_axis_tdata;
  input aclk;
  input [1:0]s_axis_tvalid;
  input [1:0]\gen_tdest_router.busy_r ;
  input [0:0]m_axis_tready;
  input valid_i;
  input [1:0]arb_req_i__1;
  input \gen_tdest_routing.busy_r_reg[0] ;
  input \gen_tdest_routing.busy_r_reg[0]_0 ;
  input [511:0]s_axis_tdata;
  input aresetn;

  wire aclk;
  wire [1:0]arb_gnt_i;
  wire \arb_gnt_r_reg[0] ;
  wire \arb_gnt_r_reg[1] ;
  wire [1:0]arb_req_i__1;
  wire areset;
  wire areset_reg_0;
  wire aresetn;
  wire [1:0]\gen_tdest_router.busy_r ;
  wire \gen_tdest_routing.busy_ns ;
  wire \gen_tdest_routing.busy_ns_0 ;
  wire \gen_tdest_routing.busy_r_reg[0] ;
  wire \gen_tdest_routing.busy_r_reg[0]_0 ;
  wire [255:0]m_axis_tdata;
  wire [0:0]m_axis_tready;
  wire [0:0]m_axis_tvalid;
  wire p_0_in;
  wire [511:0]s_axis_tdata;
  wire [1:0]s_axis_tready;
  wire [1:0]s_axis_tvalid;
  wire valid_i;

  LUT1 #(
    .INIT(2'h1)) 
    areset_i_1
       (.I0(aresetn),
        .O(p_0_in));
  FDRE areset_reg
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in),
        .Q(areset),
        .R(1'b0));
  axis_switch_0_axis_switch_v1_1_22_arb_rr \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0 
       (.aclk(aclk),
        .\arb_gnt_r_reg[0]_0 (arb_gnt_i[0]),
        .\arb_gnt_r_reg[0]_1 (\arb_gnt_r_reg[0] ),
        .\arb_gnt_r_reg[1]_0 (arb_gnt_i[1]),
        .\arb_gnt_r_reg[1]_1 (\arb_gnt_r_reg[1] ),
        .\arb_gnt_r_reg[1]_2 (areset),
        .arb_req_i__1(arb_req_i__1),
        .areset_reg(areset_reg_0),
        .\gen_tdest_router.busy_r (\gen_tdest_router.busy_r ),
        .\gen_tdest_routing.busy_ns (\gen_tdest_routing.busy_ns ),
        .\gen_tdest_routing.busy_ns_0 (\gen_tdest_routing.busy_ns_0 ),
        .\gen_tdest_routing.busy_r_reg[0] (\gen_tdest_routing.busy_r_reg[0] ),
        .\gen_tdest_routing.busy_r_reg[0]_0 (\gen_tdest_routing.busy_r_reg[0]_0 ),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tready(s_axis_tready),
        .s_axis_tvalid(s_axis_tvalid),
        .valid_i(valid_i));
endmodule

(* ORIG_REF_NAME = "axis_switch_v1_1_22_axisc_arb_responder" *) 
module axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder
   (\gen_tdest_router.busy_r ,
    \busy_r_reg[0]_0 ,
    \busy_r_reg[1]_0 ,
    aclk,
    \busy_r_reg[0]_1 );
  output [1:0]\gen_tdest_router.busy_r ;
  input \busy_r_reg[0]_0 ;
  input \busy_r_reg[1]_0 ;
  input aclk;
  input \busy_r_reg[0]_1 ;

  wire aclk;
  wire \busy_r_reg[0]_0 ;
  wire \busy_r_reg[0]_1 ;
  wire \busy_r_reg[1]_0 ;
  wire [1:0]\gen_tdest_router.busy_r ;

  FDRE \busy_r_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\busy_r_reg[0]_1 ),
        .Q(\gen_tdest_router.busy_r [0]),
        .R(\busy_r_reg[0]_0 ));
  FDRE \busy_r_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(\busy_r_reg[1]_0 ),
        .Q(\gen_tdest_router.busy_r [1]),
        .R(\busy_r_reg[0]_0 ));
endmodule

(* ORIG_REF_NAME = "axis_switch_v1_1_22_axisc_decoder" *) 
module axis_switch_0_axis_switch_v1_1_22_axisc_decoder
   (\gen_tdest_routing.busy_r_reg[0]_0 ,
    arb_req_i__1,
    areset,
    \gen_tdest_routing.busy_ns ,
    aclk,
    s_req_suppress,
    s_axis_tvalid,
    arb_gnt_i);
  output \gen_tdest_routing.busy_r_reg[0]_0 ;
  output [0:0]arb_req_i__1;
  input areset;
  input \gen_tdest_routing.busy_ns ;
  input aclk;
  input [0:0]s_req_suppress;
  input [0:0]s_axis_tvalid;
  input [0:0]arb_gnt_i;

  wire aclk;
  wire [0:0]arb_gnt_i;
  wire [0:0]arb_req_i__1;
  wire areset;
  wire \gen_tdest_routing.busy_ns ;
  wire \gen_tdest_routing.busy_r_reg[0]_0 ;
  wire [0:0]s_axis_tvalid;
  wire [0:0]s_req_suppress;

  LUT4 #(
    .INIT(16'h0004)) 
    \arb_gnt_r[1]_i_5 
       (.I0(s_req_suppress),
        .I1(s_axis_tvalid),
        .I2(\gen_tdest_routing.busy_r_reg[0]_0 ),
        .I3(arb_gnt_i),
        .O(arb_req_i__1));
  FDRE \gen_tdest_routing.busy_r_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\gen_tdest_routing.busy_ns ),
        .Q(\gen_tdest_routing.busy_r_reg[0]_0 ),
        .R(areset));
endmodule

(* ORIG_REF_NAME = "axis_switch_v1_1_22_axisc_decoder" *) 
module axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0
   (\gen_tdest_routing.busy_r_reg[0]_0 ,
    arb_req_i__1,
    valid_i,
    areset,
    \gen_tdest_routing.busy_ns ,
    aclk,
    s_req_suppress,
    s_axis_tvalid,
    arb_gnt_i,
    arb_busy_r_reg);
  output \gen_tdest_routing.busy_r_reg[0]_0 ;
  output [0:0]arb_req_i__1;
  output valid_i;
  input areset;
  input \gen_tdest_routing.busy_ns ;
  input aclk;
  input [1:0]s_req_suppress;
  input [1:0]s_axis_tvalid;
  input [1:0]arb_gnt_i;
  input arb_busy_r_reg;

  wire aclk;
  wire arb_busy_r_reg;
  wire [1:0]arb_gnt_i;
  wire [0:0]arb_req_i__1;
  wire areset;
  wire \gen_tdest_routing.busy_ns ;
  wire \gen_tdest_routing.busy_r_reg[0]_0 ;
  wire [1:0]s_axis_tvalid;
  wire [1:0]s_req_suppress;
  wire valid_i;

  LUT5 #(
    .INIT(32'hAAAAABAA)) 
    \arb_gnt_r[1]_i_2 
       (.I0(arb_req_i__1),
        .I1(arb_gnt_i[0]),
        .I2(arb_busy_r_reg),
        .I3(s_axis_tvalid[0]),
        .I4(s_req_suppress[0]),
        .O(valid_i));
  LUT4 #(
    .INIT(16'h0004)) 
    \arb_gnt_r[1]_i_4 
       (.I0(s_req_suppress[1]),
        .I1(s_axis_tvalid[1]),
        .I2(\gen_tdest_routing.busy_r_reg[0]_0 ),
        .I3(arb_gnt_i[1]),
        .O(arb_req_i__1));
  FDRE \gen_tdest_routing.busy_r_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\gen_tdest_routing.busy_ns ),
        .Q(\gen_tdest_routing.busy_r_reg[0]_0 ),
        .R(areset));
endmodule

(* ORIG_REF_NAME = "axis_switch_v1_1_22_axisc_transfer_mux" *) 
module axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux
   (\gen_tdest_router.busy_r ,
    \busy_r_reg[0] ,
    \busy_r_reg[1] ,
    aclk,
    \busy_r_reg[0]_0 );
  output [1:0]\gen_tdest_router.busy_r ;
  input \busy_r_reg[0] ;
  input \busy_r_reg[1] ;
  input aclk;
  input \busy_r_reg[0]_0 ;

  wire aclk;
  wire \busy_r_reg[0] ;
  wire \busy_r_reg[0]_0 ;
  wire \busy_r_reg[1] ;
  wire [1:0]\gen_tdest_router.busy_r ;

  axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder \gen_tdest_router.axisc_arb_responder 
       (.aclk(aclk),
        .\busy_r_reg[0]_0 (\busy_r_reg[0] ),
        .\busy_r_reg[0]_1 (\busy_r_reg[0]_0 ),
        .\busy_r_reg[1]_0 (\busy_r_reg[1] ),
        .\gen_tdest_router.busy_r (\gen_tdest_router.busy_r ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
