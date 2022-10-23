-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Thu May 13 13:20:46 2021
-- Host        : edwardrichter-MS-7A71 running 64-bit Ubuntu 18.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /mnt/nvme0/coyote_qdma/Coyote/hw/build/ip_repo/qdma_descriptor_mux_1.0/src/axis_switch_0/axis_switch_0_sim_netlist.vhdl
-- Design      : axis_switch_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcu280-fsvh2892-2L-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_arb_rr is
  port (
    s_axis_tready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \arb_gnt_r_reg[0]_0\ : out STD_LOGIC;
    \arb_gnt_r_reg[1]_0\ : out STD_LOGIC;
    areset_reg : out STD_LOGIC;
    \gen_tdest_routing.busy_ns\ : out STD_LOGIC;
    \gen_tdest_routing.busy_ns_0\ : out STD_LOGIC;
    \arb_gnt_r_reg[0]_1\ : out STD_LOGIC;
    \arb_gnt_r_reg[1]_1\ : out STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    \arb_gnt_r_reg[1]_2\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_tdest_router.busy_r\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    valid_i : in STD_LOGIC;
    \arb_req_i__1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_tdest_routing.busy_r_reg[0]\ : in STD_LOGIC;
    \gen_tdest_routing.busy_r_reg[0]_0\ : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_arb_rr : entity is "axis_switch_v1_1_22_arb_rr";
end axis_switch_0_axis_switch_v1_1_22_arb_rr;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_arb_rr is
  signal arb_busy_ns : STD_LOGIC;
  signal arb_busy_r : STD_LOGIC;
  signal arb_done_i : STD_LOGIC;
  signal arb_gnt_ns : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \arb_gnt_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \^arb_gnt_r_reg[0]_0\ : STD_LOGIC;
  signal \^arb_gnt_r_reg[0]_1\ : STD_LOGIC;
  signal \^arb_gnt_r_reg[1]_0\ : STD_LOGIC;
  signal \^arb_gnt_r_reg[1]_1\ : STD_LOGIC;
  signal arb_sel_i : STD_LOGIC;
  signal \arb_sel_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \barrel_cntr[0]_i_1_n_0\ : STD_LOGIC;
  signal \barrel_cntr[0]_i_2_n_0\ : STD_LOGIC;
  signal \barrel_cntr_reg_n_0_[0]\ : STD_LOGIC;
  signal port_priority_ns : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal sel_i : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of arb_busy_r_i_1 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \arb_gnt_r[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \arb_gnt_r[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \arb_gnt_r[1]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \arb_sel_r[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \barrel_cntr[0]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \busy_r[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \busy_r[1]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_tdest_routing.busy_r[0]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_tdata[0]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_tdata[100]_INST_0\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \m_axis_tdata[101]_INST_0\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \m_axis_tdata[102]_INST_0\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \m_axis_tdata[103]_INST_0\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \m_axis_tdata[104]_INST_0\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \m_axis_tdata[105]_INST_0\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \m_axis_tdata[106]_INST_0\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \m_axis_tdata[107]_INST_0\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \m_axis_tdata[108]_INST_0\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \m_axis_tdata[109]_INST_0\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \m_axis_tdata[10]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_axis_tdata[110]_INST_0\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \m_axis_tdata[111]_INST_0\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \m_axis_tdata[112]_INST_0\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \m_axis_tdata[113]_INST_0\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \m_axis_tdata[114]_INST_0\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \m_axis_tdata[115]_INST_0\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \m_axis_tdata[116]_INST_0\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \m_axis_tdata[117]_INST_0\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \m_axis_tdata[118]_INST_0\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \m_axis_tdata[119]_INST_0\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \m_axis_tdata[11]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_axis_tdata[120]_INST_0\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \m_axis_tdata[121]_INST_0\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \m_axis_tdata[122]_INST_0\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \m_axis_tdata[123]_INST_0\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \m_axis_tdata[124]_INST_0\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \m_axis_tdata[125]_INST_0\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \m_axis_tdata[126]_INST_0\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \m_axis_tdata[127]_INST_0\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \m_axis_tdata[128]_INST_0\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \m_axis_tdata[129]_INST_0\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \m_axis_tdata[12]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_axis_tdata[130]_INST_0\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \m_axis_tdata[131]_INST_0\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \m_axis_tdata[132]_INST_0\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \m_axis_tdata[133]_INST_0\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \m_axis_tdata[134]_INST_0\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \m_axis_tdata[135]_INST_0\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \m_axis_tdata[136]_INST_0\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \m_axis_tdata[137]_INST_0\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \m_axis_tdata[138]_INST_0\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \m_axis_tdata[139]_INST_0\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \m_axis_tdata[13]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_axis_tdata[140]_INST_0\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \m_axis_tdata[141]_INST_0\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \m_axis_tdata[142]_INST_0\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \m_axis_tdata[143]_INST_0\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \m_axis_tdata[144]_INST_0\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \m_axis_tdata[145]_INST_0\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \m_axis_tdata[146]_INST_0\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \m_axis_tdata[147]_INST_0\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \m_axis_tdata[148]_INST_0\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \m_axis_tdata[149]_INST_0\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \m_axis_tdata[14]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_axis_tdata[150]_INST_0\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \m_axis_tdata[151]_INST_0\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \m_axis_tdata[152]_INST_0\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \m_axis_tdata[153]_INST_0\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \m_axis_tdata[154]_INST_0\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \m_axis_tdata[155]_INST_0\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \m_axis_tdata[156]_INST_0\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \m_axis_tdata[157]_INST_0\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \m_axis_tdata[158]_INST_0\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \m_axis_tdata[159]_INST_0\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \m_axis_tdata[15]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_axis_tdata[160]_INST_0\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \m_axis_tdata[161]_INST_0\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \m_axis_tdata[162]_INST_0\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \m_axis_tdata[163]_INST_0\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \m_axis_tdata[164]_INST_0\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \m_axis_tdata[165]_INST_0\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \m_axis_tdata[166]_INST_0\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \m_axis_tdata[167]_INST_0\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \m_axis_tdata[168]_INST_0\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \m_axis_tdata[169]_INST_0\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \m_axis_tdata[16]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_axis_tdata[170]_INST_0\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \m_axis_tdata[171]_INST_0\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \m_axis_tdata[172]_INST_0\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \m_axis_tdata[173]_INST_0\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \m_axis_tdata[174]_INST_0\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \m_axis_tdata[175]_INST_0\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \m_axis_tdata[176]_INST_0\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \m_axis_tdata[177]_INST_0\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \m_axis_tdata[178]_INST_0\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \m_axis_tdata[179]_INST_0\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \m_axis_tdata[17]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_axis_tdata[180]_INST_0\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \m_axis_tdata[181]_INST_0\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \m_axis_tdata[182]_INST_0\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \m_axis_tdata[183]_INST_0\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \m_axis_tdata[184]_INST_0\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \m_axis_tdata[185]_INST_0\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \m_axis_tdata[186]_INST_0\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \m_axis_tdata[187]_INST_0\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \m_axis_tdata[188]_INST_0\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \m_axis_tdata[189]_INST_0\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \m_axis_tdata[18]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_axis_tdata[190]_INST_0\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \m_axis_tdata[191]_INST_0\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \m_axis_tdata[192]_INST_0\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \m_axis_tdata[193]_INST_0\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \m_axis_tdata[194]_INST_0\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \m_axis_tdata[195]_INST_0\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \m_axis_tdata[196]_INST_0\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \m_axis_tdata[197]_INST_0\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \m_axis_tdata[198]_INST_0\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \m_axis_tdata[199]_INST_0\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \m_axis_tdata[19]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_axis_tdata[1]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_tdata[200]_INST_0\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \m_axis_tdata[201]_INST_0\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \m_axis_tdata[202]_INST_0\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \m_axis_tdata[203]_INST_0\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \m_axis_tdata[204]_INST_0\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \m_axis_tdata[205]_INST_0\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \m_axis_tdata[206]_INST_0\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \m_axis_tdata[207]_INST_0\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \m_axis_tdata[208]_INST_0\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \m_axis_tdata[209]_INST_0\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \m_axis_tdata[20]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_axis_tdata[210]_INST_0\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \m_axis_tdata[211]_INST_0\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \m_axis_tdata[212]_INST_0\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \m_axis_tdata[213]_INST_0\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \m_axis_tdata[214]_INST_0\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \m_axis_tdata[215]_INST_0\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \m_axis_tdata[216]_INST_0\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \m_axis_tdata[217]_INST_0\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \m_axis_tdata[218]_INST_0\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \m_axis_tdata[219]_INST_0\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \m_axis_tdata[21]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_axis_tdata[220]_INST_0\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \m_axis_tdata[221]_INST_0\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \m_axis_tdata[222]_INST_0\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \m_axis_tdata[223]_INST_0\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \m_axis_tdata[224]_INST_0\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of \m_axis_tdata[225]_INST_0\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of \m_axis_tdata[226]_INST_0\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \m_axis_tdata[227]_INST_0\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \m_axis_tdata[228]_INST_0\ : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \m_axis_tdata[229]_INST_0\ : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \m_axis_tdata[22]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_axis_tdata[230]_INST_0\ : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \m_axis_tdata[231]_INST_0\ : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \m_axis_tdata[232]_INST_0\ : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of \m_axis_tdata[233]_INST_0\ : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of \m_axis_tdata[234]_INST_0\ : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of \m_axis_tdata[235]_INST_0\ : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of \m_axis_tdata[236]_INST_0\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \m_axis_tdata[237]_INST_0\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \m_axis_tdata[238]_INST_0\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \m_axis_tdata[239]_INST_0\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \m_axis_tdata[23]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_axis_tdata[240]_INST_0\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \m_axis_tdata[241]_INST_0\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \m_axis_tdata[242]_INST_0\ : label is "soft_lutpair127";
  attribute SOFT_HLUTNM of \m_axis_tdata[243]_INST_0\ : label is "soft_lutpair127";
  attribute SOFT_HLUTNM of \m_axis_tdata[244]_INST_0\ : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of \m_axis_tdata[245]_INST_0\ : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of \m_axis_tdata[246]_INST_0\ : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \m_axis_tdata[247]_INST_0\ : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \m_axis_tdata[248]_INST_0\ : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \m_axis_tdata[249]_INST_0\ : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \m_axis_tdata[24]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_axis_tdata[250]_INST_0\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \m_axis_tdata[251]_INST_0\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \m_axis_tdata[252]_INST_0\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \m_axis_tdata[253]_INST_0\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \m_axis_tdata[254]_INST_0\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \m_axis_tdata[255]_INST_0\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \m_axis_tdata[25]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_axis_tdata[26]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_axis_tdata[27]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_axis_tdata[28]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_axis_tdata[29]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_axis_tdata[2]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_tdata[30]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_axis_tdata[31]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_axis_tdata[32]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_axis_tdata[33]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_axis_tdata[34]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_axis_tdata[35]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_axis_tdata[36]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_axis_tdata[37]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_axis_tdata[38]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_axis_tdata[39]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_axis_tdata[3]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_tdata[40]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_axis_tdata[41]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_axis_tdata[42]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_axis_tdata[43]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_axis_tdata[44]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_axis_tdata[45]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_axis_tdata[46]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_axis_tdata[47]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_axis_tdata[48]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_axis_tdata[49]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_axis_tdata[4]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_tdata[50]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_axis_tdata[51]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_axis_tdata[52]_INST_0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_axis_tdata[53]_INST_0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_axis_tdata[54]_INST_0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_axis_tdata[55]_INST_0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_axis_tdata[56]_INST_0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_axis_tdata[57]_INST_0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_axis_tdata[58]_INST_0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \m_axis_tdata[59]_INST_0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \m_axis_tdata[5]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_tdata[60]_INST_0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \m_axis_tdata[61]_INST_0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \m_axis_tdata[62]_INST_0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \m_axis_tdata[63]_INST_0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \m_axis_tdata[64]_INST_0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \m_axis_tdata[65]_INST_0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \m_axis_tdata[66]_INST_0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \m_axis_tdata[67]_INST_0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \m_axis_tdata[68]_INST_0\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \m_axis_tdata[69]_INST_0\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \m_axis_tdata[6]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_tdata[70]_INST_0\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \m_axis_tdata[71]_INST_0\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \m_axis_tdata[72]_INST_0\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \m_axis_tdata[73]_INST_0\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \m_axis_tdata[74]_INST_0\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \m_axis_tdata[75]_INST_0\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \m_axis_tdata[76]_INST_0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \m_axis_tdata[77]_INST_0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \m_axis_tdata[78]_INST_0\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \m_axis_tdata[79]_INST_0\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \m_axis_tdata[7]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_tdata[80]_INST_0\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \m_axis_tdata[81]_INST_0\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \m_axis_tdata[82]_INST_0\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \m_axis_tdata[83]_INST_0\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \m_axis_tdata[84]_INST_0\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \m_axis_tdata[85]_INST_0\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \m_axis_tdata[86]_INST_0\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \m_axis_tdata[87]_INST_0\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \m_axis_tdata[88]_INST_0\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \m_axis_tdata[89]_INST_0\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \m_axis_tdata[8]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_tdata[90]_INST_0\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \m_axis_tdata[91]_INST_0\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \m_axis_tdata[92]_INST_0\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \m_axis_tdata[93]_INST_0\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \m_axis_tdata[94]_INST_0\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \m_axis_tdata[95]_INST_0\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \m_axis_tdata[96]_INST_0\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \m_axis_tdata[97]_INST_0\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \m_axis_tdata[98]_INST_0\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \m_axis_tdata[99]_INST_0\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \m_axis_tdata[9]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_tvalid[0]_INST_0_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \s_axis_tready[0]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \s_axis_tready[1]_INST_0\ : label is "soft_lutpair4";
begin
  \arb_gnt_r_reg[0]_0\ <= \^arb_gnt_r_reg[0]_0\;
  \arb_gnt_r_reg[0]_1\ <= \^arb_gnt_r_reg[0]_1\;
  \arb_gnt_r_reg[1]_0\ <= \^arb_gnt_r_reg[1]_0\;
  \arb_gnt_r_reg[1]_1\ <= \^arb_gnt_r_reg[1]_1\;
arb_busy_r_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => valid_i,
      I1 => arb_done_i,
      I2 => arb_busy_r,
      O => arb_busy_ns
    );
arb_busy_r_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => arb_busy_ns,
      Q => arb_busy_r,
      R => \arb_gnt_r_reg[1]_2\
    );
\arb_gnt_r[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00B0"
    )
        port map (
      I0 => arb_done_i,
      I1 => arb_busy_r,
      I2 => valid_i,
      I3 => sel_i,
      O => \arb_gnt_r[0]_i_1_n_0\
    );
\arb_gnt_r[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B000"
    )
        port map (
      I0 => arb_done_i,
      I1 => arb_busy_r,
      I2 => valid_i,
      I3 => sel_i,
      O => arb_gnt_ns(1)
    );
\arb_gnt_r[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BA8C8A80"
    )
        port map (
      I0 => port_priority_ns(1),
      I1 => \arb_req_i__1\(1),
      I2 => \barrel_cntr_reg_n_0_[0]\,
      I3 => \arb_req_i__1\(0),
      I4 => port_priority_ns(0),
      O => sel_i
    );
\arb_gnt_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \arb_gnt_r[0]_i_1_n_0\,
      Q => \^arb_gnt_r_reg[0]_0\,
      R => \arb_gnt_r_reg[1]_2\
    );
\arb_gnt_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => arb_gnt_ns(1),
      Q => \^arb_gnt_r_reg[1]_0\,
      R => \arb_gnt_r_reg[1]_2\
    );
\arb_sel_r[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBFB8808"
    )
        port map (
      I0 => sel_i,
      I1 => valid_i,
      I2 => arb_busy_r,
      I3 => arb_done_i,
      I4 => arb_sel_i,
      O => \arb_sel_r[0]_i_1_n_0\
    );
\arb_sel_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \arb_sel_r[0]_i_1_n_0\,
      Q => arb_sel_i,
      R => \arb_gnt_r_reg[1]_2\
    );
\barrel_cntr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \^arb_gnt_r_reg[1]_0\,
      I1 => \^arb_gnt_r_reg[0]_0\,
      I2 => arb_busy_r,
      O => \barrel_cntr[0]_i_1_n_0\
    );
\barrel_cntr[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \barrel_cntr_reg_n_0_[0]\,
      O => \barrel_cntr[0]_i_2_n_0\
    );
\barrel_cntr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \barrel_cntr[0]_i_1_n_0\,
      D => \barrel_cntr[0]_i_2_n_0\,
      Q => \barrel_cntr_reg_n_0_[0]\,
      R => \arb_gnt_r_reg[1]_2\
    );
\busy_r[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^arb_gnt_r_reg[0]_0\,
      I1 => \gen_tdest_router.busy_r\(0),
      O => \^arb_gnt_r_reg[0]_1\
    );
\busy_r[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \arb_gnt_r_reg[1]_2\,
      I1 => arb_done_i,
      O => areset_reg
    );
\busy_r[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EE00E0E000000000"
    )
        port map (
      I0 => \^arb_gnt_r_reg[0]_1\,
      I1 => \^arb_gnt_r_reg[1]_1\,
      I2 => s_axis_tvalid(0),
      I3 => s_axis_tvalid(1),
      I4 => arb_sel_i,
      I5 => m_axis_tready(0),
      O => arb_done_i
    );
\gen_tdest_routing.busy_r[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \gen_tdest_routing.busy_r_reg[0]\,
      I1 => \^arb_gnt_r_reg[1]_0\,
      I2 => arb_done_i,
      O => \gen_tdest_routing.busy_ns\
    );
\gen_tdest_routing.busy_r[0]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \gen_tdest_routing.busy_r_reg[0]_0\,
      I1 => \^arb_gnt_r_reg[0]_0\,
      I2 => arb_done_i,
      O => \gen_tdest_routing.busy_ns_0\
    );
\m_axis_tdata[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(0),
      I1 => s_axis_tdata(256),
      I2 => arb_sel_i,
      O => m_axis_tdata(0)
    );
\m_axis_tdata[100]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(100),
      I1 => s_axis_tdata(356),
      I2 => arb_sel_i,
      O => m_axis_tdata(100)
    );
\m_axis_tdata[101]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(101),
      I1 => s_axis_tdata(357),
      I2 => arb_sel_i,
      O => m_axis_tdata(101)
    );
\m_axis_tdata[102]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(102),
      I1 => s_axis_tdata(358),
      I2 => arb_sel_i,
      O => m_axis_tdata(102)
    );
\m_axis_tdata[103]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(103),
      I1 => s_axis_tdata(359),
      I2 => arb_sel_i,
      O => m_axis_tdata(103)
    );
\m_axis_tdata[104]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(104),
      I1 => s_axis_tdata(360),
      I2 => arb_sel_i,
      O => m_axis_tdata(104)
    );
\m_axis_tdata[105]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(105),
      I1 => s_axis_tdata(361),
      I2 => arb_sel_i,
      O => m_axis_tdata(105)
    );
\m_axis_tdata[106]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(106),
      I1 => s_axis_tdata(362),
      I2 => arb_sel_i,
      O => m_axis_tdata(106)
    );
\m_axis_tdata[107]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(107),
      I1 => s_axis_tdata(363),
      I2 => arb_sel_i,
      O => m_axis_tdata(107)
    );
\m_axis_tdata[108]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(108),
      I1 => s_axis_tdata(364),
      I2 => arb_sel_i,
      O => m_axis_tdata(108)
    );
\m_axis_tdata[109]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(109),
      I1 => s_axis_tdata(365),
      I2 => arb_sel_i,
      O => m_axis_tdata(109)
    );
\m_axis_tdata[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(10),
      I1 => s_axis_tdata(266),
      I2 => arb_sel_i,
      O => m_axis_tdata(10)
    );
\m_axis_tdata[110]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(110),
      I1 => s_axis_tdata(366),
      I2 => arb_sel_i,
      O => m_axis_tdata(110)
    );
\m_axis_tdata[111]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(111),
      I1 => s_axis_tdata(367),
      I2 => arb_sel_i,
      O => m_axis_tdata(111)
    );
\m_axis_tdata[112]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(112),
      I1 => s_axis_tdata(368),
      I2 => arb_sel_i,
      O => m_axis_tdata(112)
    );
\m_axis_tdata[113]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(113),
      I1 => s_axis_tdata(369),
      I2 => arb_sel_i,
      O => m_axis_tdata(113)
    );
\m_axis_tdata[114]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(114),
      I1 => s_axis_tdata(370),
      I2 => arb_sel_i,
      O => m_axis_tdata(114)
    );
\m_axis_tdata[115]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(115),
      I1 => s_axis_tdata(371),
      I2 => arb_sel_i,
      O => m_axis_tdata(115)
    );
\m_axis_tdata[116]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(116),
      I1 => s_axis_tdata(372),
      I2 => arb_sel_i,
      O => m_axis_tdata(116)
    );
\m_axis_tdata[117]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(117),
      I1 => s_axis_tdata(373),
      I2 => arb_sel_i,
      O => m_axis_tdata(117)
    );
\m_axis_tdata[118]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(118),
      I1 => s_axis_tdata(374),
      I2 => arb_sel_i,
      O => m_axis_tdata(118)
    );
\m_axis_tdata[119]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(119),
      I1 => s_axis_tdata(375),
      I2 => arb_sel_i,
      O => m_axis_tdata(119)
    );
\m_axis_tdata[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(11),
      I1 => s_axis_tdata(267),
      I2 => arb_sel_i,
      O => m_axis_tdata(11)
    );
\m_axis_tdata[120]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(120),
      I1 => s_axis_tdata(376),
      I2 => arb_sel_i,
      O => m_axis_tdata(120)
    );
\m_axis_tdata[121]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(121),
      I1 => s_axis_tdata(377),
      I2 => arb_sel_i,
      O => m_axis_tdata(121)
    );
\m_axis_tdata[122]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(122),
      I1 => s_axis_tdata(378),
      I2 => arb_sel_i,
      O => m_axis_tdata(122)
    );
\m_axis_tdata[123]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(123),
      I1 => s_axis_tdata(379),
      I2 => arb_sel_i,
      O => m_axis_tdata(123)
    );
\m_axis_tdata[124]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(124),
      I1 => s_axis_tdata(380),
      I2 => arb_sel_i,
      O => m_axis_tdata(124)
    );
\m_axis_tdata[125]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(125),
      I1 => s_axis_tdata(381),
      I2 => arb_sel_i,
      O => m_axis_tdata(125)
    );
\m_axis_tdata[126]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(126),
      I1 => s_axis_tdata(382),
      I2 => arb_sel_i,
      O => m_axis_tdata(126)
    );
\m_axis_tdata[127]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(127),
      I1 => s_axis_tdata(383),
      I2 => arb_sel_i,
      O => m_axis_tdata(127)
    );
\m_axis_tdata[128]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(128),
      I1 => s_axis_tdata(384),
      I2 => arb_sel_i,
      O => m_axis_tdata(128)
    );
\m_axis_tdata[129]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(129),
      I1 => s_axis_tdata(385),
      I2 => arb_sel_i,
      O => m_axis_tdata(129)
    );
\m_axis_tdata[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(12),
      I1 => s_axis_tdata(268),
      I2 => arb_sel_i,
      O => m_axis_tdata(12)
    );
\m_axis_tdata[130]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(130),
      I1 => s_axis_tdata(386),
      I2 => arb_sel_i,
      O => m_axis_tdata(130)
    );
\m_axis_tdata[131]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(131),
      I1 => s_axis_tdata(387),
      I2 => arb_sel_i,
      O => m_axis_tdata(131)
    );
\m_axis_tdata[132]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(132),
      I1 => s_axis_tdata(388),
      I2 => arb_sel_i,
      O => m_axis_tdata(132)
    );
\m_axis_tdata[133]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(133),
      I1 => s_axis_tdata(389),
      I2 => arb_sel_i,
      O => m_axis_tdata(133)
    );
\m_axis_tdata[134]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(134),
      I1 => s_axis_tdata(390),
      I2 => arb_sel_i,
      O => m_axis_tdata(134)
    );
\m_axis_tdata[135]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(135),
      I1 => s_axis_tdata(391),
      I2 => arb_sel_i,
      O => m_axis_tdata(135)
    );
\m_axis_tdata[136]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(136),
      I1 => s_axis_tdata(392),
      I2 => arb_sel_i,
      O => m_axis_tdata(136)
    );
\m_axis_tdata[137]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(137),
      I1 => s_axis_tdata(393),
      I2 => arb_sel_i,
      O => m_axis_tdata(137)
    );
\m_axis_tdata[138]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(138),
      I1 => s_axis_tdata(394),
      I2 => arb_sel_i,
      O => m_axis_tdata(138)
    );
\m_axis_tdata[139]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(139),
      I1 => s_axis_tdata(395),
      I2 => arb_sel_i,
      O => m_axis_tdata(139)
    );
\m_axis_tdata[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(13),
      I1 => s_axis_tdata(269),
      I2 => arb_sel_i,
      O => m_axis_tdata(13)
    );
\m_axis_tdata[140]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(140),
      I1 => s_axis_tdata(396),
      I2 => arb_sel_i,
      O => m_axis_tdata(140)
    );
\m_axis_tdata[141]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(141),
      I1 => s_axis_tdata(397),
      I2 => arb_sel_i,
      O => m_axis_tdata(141)
    );
\m_axis_tdata[142]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(142),
      I1 => s_axis_tdata(398),
      I2 => arb_sel_i,
      O => m_axis_tdata(142)
    );
\m_axis_tdata[143]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(143),
      I1 => s_axis_tdata(399),
      I2 => arb_sel_i,
      O => m_axis_tdata(143)
    );
\m_axis_tdata[144]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(144),
      I1 => s_axis_tdata(400),
      I2 => arb_sel_i,
      O => m_axis_tdata(144)
    );
\m_axis_tdata[145]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(145),
      I1 => s_axis_tdata(401),
      I2 => arb_sel_i,
      O => m_axis_tdata(145)
    );
\m_axis_tdata[146]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(146),
      I1 => s_axis_tdata(402),
      I2 => arb_sel_i,
      O => m_axis_tdata(146)
    );
\m_axis_tdata[147]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(147),
      I1 => s_axis_tdata(403),
      I2 => arb_sel_i,
      O => m_axis_tdata(147)
    );
\m_axis_tdata[148]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(148),
      I1 => s_axis_tdata(404),
      I2 => arb_sel_i,
      O => m_axis_tdata(148)
    );
\m_axis_tdata[149]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(149),
      I1 => s_axis_tdata(405),
      I2 => arb_sel_i,
      O => m_axis_tdata(149)
    );
\m_axis_tdata[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(14),
      I1 => s_axis_tdata(270),
      I2 => arb_sel_i,
      O => m_axis_tdata(14)
    );
\m_axis_tdata[150]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(150),
      I1 => s_axis_tdata(406),
      I2 => arb_sel_i,
      O => m_axis_tdata(150)
    );
\m_axis_tdata[151]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(151),
      I1 => s_axis_tdata(407),
      I2 => arb_sel_i,
      O => m_axis_tdata(151)
    );
\m_axis_tdata[152]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(152),
      I1 => s_axis_tdata(408),
      I2 => arb_sel_i,
      O => m_axis_tdata(152)
    );
\m_axis_tdata[153]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(153),
      I1 => s_axis_tdata(409),
      I2 => arb_sel_i,
      O => m_axis_tdata(153)
    );
\m_axis_tdata[154]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(154),
      I1 => s_axis_tdata(410),
      I2 => arb_sel_i,
      O => m_axis_tdata(154)
    );
\m_axis_tdata[155]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(155),
      I1 => s_axis_tdata(411),
      I2 => arb_sel_i,
      O => m_axis_tdata(155)
    );
\m_axis_tdata[156]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(156),
      I1 => s_axis_tdata(412),
      I2 => arb_sel_i,
      O => m_axis_tdata(156)
    );
\m_axis_tdata[157]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(157),
      I1 => s_axis_tdata(413),
      I2 => arb_sel_i,
      O => m_axis_tdata(157)
    );
\m_axis_tdata[158]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(158),
      I1 => s_axis_tdata(414),
      I2 => arb_sel_i,
      O => m_axis_tdata(158)
    );
\m_axis_tdata[159]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(159),
      I1 => s_axis_tdata(415),
      I2 => arb_sel_i,
      O => m_axis_tdata(159)
    );
\m_axis_tdata[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(15),
      I1 => s_axis_tdata(271),
      I2 => arb_sel_i,
      O => m_axis_tdata(15)
    );
\m_axis_tdata[160]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(160),
      I1 => s_axis_tdata(416),
      I2 => arb_sel_i,
      O => m_axis_tdata(160)
    );
\m_axis_tdata[161]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(161),
      I1 => s_axis_tdata(417),
      I2 => arb_sel_i,
      O => m_axis_tdata(161)
    );
\m_axis_tdata[162]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(162),
      I1 => s_axis_tdata(418),
      I2 => arb_sel_i,
      O => m_axis_tdata(162)
    );
\m_axis_tdata[163]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(163),
      I1 => s_axis_tdata(419),
      I2 => arb_sel_i,
      O => m_axis_tdata(163)
    );
\m_axis_tdata[164]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(164),
      I1 => s_axis_tdata(420),
      I2 => arb_sel_i,
      O => m_axis_tdata(164)
    );
\m_axis_tdata[165]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(165),
      I1 => s_axis_tdata(421),
      I2 => arb_sel_i,
      O => m_axis_tdata(165)
    );
\m_axis_tdata[166]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(166),
      I1 => s_axis_tdata(422),
      I2 => arb_sel_i,
      O => m_axis_tdata(166)
    );
\m_axis_tdata[167]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(167),
      I1 => s_axis_tdata(423),
      I2 => arb_sel_i,
      O => m_axis_tdata(167)
    );
\m_axis_tdata[168]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(168),
      I1 => s_axis_tdata(424),
      I2 => arb_sel_i,
      O => m_axis_tdata(168)
    );
\m_axis_tdata[169]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(169),
      I1 => s_axis_tdata(425),
      I2 => arb_sel_i,
      O => m_axis_tdata(169)
    );
\m_axis_tdata[16]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(16),
      I1 => s_axis_tdata(272),
      I2 => arb_sel_i,
      O => m_axis_tdata(16)
    );
\m_axis_tdata[170]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(170),
      I1 => s_axis_tdata(426),
      I2 => arb_sel_i,
      O => m_axis_tdata(170)
    );
\m_axis_tdata[171]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(171),
      I1 => s_axis_tdata(427),
      I2 => arb_sel_i,
      O => m_axis_tdata(171)
    );
\m_axis_tdata[172]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(172),
      I1 => s_axis_tdata(428),
      I2 => arb_sel_i,
      O => m_axis_tdata(172)
    );
\m_axis_tdata[173]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(173),
      I1 => s_axis_tdata(429),
      I2 => arb_sel_i,
      O => m_axis_tdata(173)
    );
\m_axis_tdata[174]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(174),
      I1 => s_axis_tdata(430),
      I2 => arb_sel_i,
      O => m_axis_tdata(174)
    );
\m_axis_tdata[175]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(175),
      I1 => s_axis_tdata(431),
      I2 => arb_sel_i,
      O => m_axis_tdata(175)
    );
\m_axis_tdata[176]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(176),
      I1 => s_axis_tdata(432),
      I2 => arb_sel_i,
      O => m_axis_tdata(176)
    );
\m_axis_tdata[177]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(177),
      I1 => s_axis_tdata(433),
      I2 => arb_sel_i,
      O => m_axis_tdata(177)
    );
\m_axis_tdata[178]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(178),
      I1 => s_axis_tdata(434),
      I2 => arb_sel_i,
      O => m_axis_tdata(178)
    );
\m_axis_tdata[179]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(179),
      I1 => s_axis_tdata(435),
      I2 => arb_sel_i,
      O => m_axis_tdata(179)
    );
\m_axis_tdata[17]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(17),
      I1 => s_axis_tdata(273),
      I2 => arb_sel_i,
      O => m_axis_tdata(17)
    );
\m_axis_tdata[180]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(180),
      I1 => s_axis_tdata(436),
      I2 => arb_sel_i,
      O => m_axis_tdata(180)
    );
\m_axis_tdata[181]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(181),
      I1 => s_axis_tdata(437),
      I2 => arb_sel_i,
      O => m_axis_tdata(181)
    );
\m_axis_tdata[182]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(182),
      I1 => s_axis_tdata(438),
      I2 => arb_sel_i,
      O => m_axis_tdata(182)
    );
\m_axis_tdata[183]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(183),
      I1 => s_axis_tdata(439),
      I2 => arb_sel_i,
      O => m_axis_tdata(183)
    );
\m_axis_tdata[184]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(184),
      I1 => s_axis_tdata(440),
      I2 => arb_sel_i,
      O => m_axis_tdata(184)
    );
\m_axis_tdata[185]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(185),
      I1 => s_axis_tdata(441),
      I2 => arb_sel_i,
      O => m_axis_tdata(185)
    );
\m_axis_tdata[186]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(186),
      I1 => s_axis_tdata(442),
      I2 => arb_sel_i,
      O => m_axis_tdata(186)
    );
\m_axis_tdata[187]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(187),
      I1 => s_axis_tdata(443),
      I2 => arb_sel_i,
      O => m_axis_tdata(187)
    );
\m_axis_tdata[188]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(188),
      I1 => s_axis_tdata(444),
      I2 => arb_sel_i,
      O => m_axis_tdata(188)
    );
\m_axis_tdata[189]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(189),
      I1 => s_axis_tdata(445),
      I2 => arb_sel_i,
      O => m_axis_tdata(189)
    );
\m_axis_tdata[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(18),
      I1 => s_axis_tdata(274),
      I2 => arb_sel_i,
      O => m_axis_tdata(18)
    );
\m_axis_tdata[190]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(190),
      I1 => s_axis_tdata(446),
      I2 => arb_sel_i,
      O => m_axis_tdata(190)
    );
\m_axis_tdata[191]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(191),
      I1 => s_axis_tdata(447),
      I2 => arb_sel_i,
      O => m_axis_tdata(191)
    );
\m_axis_tdata[192]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(192),
      I1 => s_axis_tdata(448),
      I2 => arb_sel_i,
      O => m_axis_tdata(192)
    );
\m_axis_tdata[193]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(193),
      I1 => s_axis_tdata(449),
      I2 => arb_sel_i,
      O => m_axis_tdata(193)
    );
\m_axis_tdata[194]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(194),
      I1 => s_axis_tdata(450),
      I2 => arb_sel_i,
      O => m_axis_tdata(194)
    );
\m_axis_tdata[195]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(195),
      I1 => s_axis_tdata(451),
      I2 => arb_sel_i,
      O => m_axis_tdata(195)
    );
\m_axis_tdata[196]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(196),
      I1 => s_axis_tdata(452),
      I2 => arb_sel_i,
      O => m_axis_tdata(196)
    );
\m_axis_tdata[197]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(197),
      I1 => s_axis_tdata(453),
      I2 => arb_sel_i,
      O => m_axis_tdata(197)
    );
\m_axis_tdata[198]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(198),
      I1 => s_axis_tdata(454),
      I2 => arb_sel_i,
      O => m_axis_tdata(198)
    );
\m_axis_tdata[199]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(199),
      I1 => s_axis_tdata(455),
      I2 => arb_sel_i,
      O => m_axis_tdata(199)
    );
\m_axis_tdata[19]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(19),
      I1 => s_axis_tdata(275),
      I2 => arb_sel_i,
      O => m_axis_tdata(19)
    );
\m_axis_tdata[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(1),
      I1 => s_axis_tdata(257),
      I2 => arb_sel_i,
      O => m_axis_tdata(1)
    );
\m_axis_tdata[200]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(200),
      I1 => s_axis_tdata(456),
      I2 => arb_sel_i,
      O => m_axis_tdata(200)
    );
\m_axis_tdata[201]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(201),
      I1 => s_axis_tdata(457),
      I2 => arb_sel_i,
      O => m_axis_tdata(201)
    );
\m_axis_tdata[202]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(202),
      I1 => s_axis_tdata(458),
      I2 => arb_sel_i,
      O => m_axis_tdata(202)
    );
\m_axis_tdata[203]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(203),
      I1 => s_axis_tdata(459),
      I2 => arb_sel_i,
      O => m_axis_tdata(203)
    );
\m_axis_tdata[204]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(204),
      I1 => s_axis_tdata(460),
      I2 => arb_sel_i,
      O => m_axis_tdata(204)
    );
\m_axis_tdata[205]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(205),
      I1 => s_axis_tdata(461),
      I2 => arb_sel_i,
      O => m_axis_tdata(205)
    );
\m_axis_tdata[206]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(206),
      I1 => s_axis_tdata(462),
      I2 => arb_sel_i,
      O => m_axis_tdata(206)
    );
\m_axis_tdata[207]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(207),
      I1 => s_axis_tdata(463),
      I2 => arb_sel_i,
      O => m_axis_tdata(207)
    );
\m_axis_tdata[208]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(208),
      I1 => s_axis_tdata(464),
      I2 => arb_sel_i,
      O => m_axis_tdata(208)
    );
\m_axis_tdata[209]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(209),
      I1 => s_axis_tdata(465),
      I2 => arb_sel_i,
      O => m_axis_tdata(209)
    );
\m_axis_tdata[20]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(20),
      I1 => s_axis_tdata(276),
      I2 => arb_sel_i,
      O => m_axis_tdata(20)
    );
\m_axis_tdata[210]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(210),
      I1 => s_axis_tdata(466),
      I2 => arb_sel_i,
      O => m_axis_tdata(210)
    );
\m_axis_tdata[211]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(211),
      I1 => s_axis_tdata(467),
      I2 => arb_sel_i,
      O => m_axis_tdata(211)
    );
\m_axis_tdata[212]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(212),
      I1 => s_axis_tdata(468),
      I2 => arb_sel_i,
      O => m_axis_tdata(212)
    );
\m_axis_tdata[213]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(213),
      I1 => s_axis_tdata(469),
      I2 => arb_sel_i,
      O => m_axis_tdata(213)
    );
\m_axis_tdata[214]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(214),
      I1 => s_axis_tdata(470),
      I2 => arb_sel_i,
      O => m_axis_tdata(214)
    );
\m_axis_tdata[215]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(215),
      I1 => s_axis_tdata(471),
      I2 => arb_sel_i,
      O => m_axis_tdata(215)
    );
\m_axis_tdata[216]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(216),
      I1 => s_axis_tdata(472),
      I2 => arb_sel_i,
      O => m_axis_tdata(216)
    );
\m_axis_tdata[217]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(217),
      I1 => s_axis_tdata(473),
      I2 => arb_sel_i,
      O => m_axis_tdata(217)
    );
\m_axis_tdata[218]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(218),
      I1 => s_axis_tdata(474),
      I2 => arb_sel_i,
      O => m_axis_tdata(218)
    );
\m_axis_tdata[219]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(219),
      I1 => s_axis_tdata(475),
      I2 => arb_sel_i,
      O => m_axis_tdata(219)
    );
\m_axis_tdata[21]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(21),
      I1 => s_axis_tdata(277),
      I2 => arb_sel_i,
      O => m_axis_tdata(21)
    );
\m_axis_tdata[220]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(220),
      I1 => s_axis_tdata(476),
      I2 => arb_sel_i,
      O => m_axis_tdata(220)
    );
\m_axis_tdata[221]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(221),
      I1 => s_axis_tdata(477),
      I2 => arb_sel_i,
      O => m_axis_tdata(221)
    );
\m_axis_tdata[222]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(222),
      I1 => s_axis_tdata(478),
      I2 => arb_sel_i,
      O => m_axis_tdata(222)
    );
\m_axis_tdata[223]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(223),
      I1 => s_axis_tdata(479),
      I2 => arb_sel_i,
      O => m_axis_tdata(223)
    );
\m_axis_tdata[224]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(224),
      I1 => s_axis_tdata(480),
      I2 => arb_sel_i,
      O => m_axis_tdata(224)
    );
\m_axis_tdata[225]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(225),
      I1 => s_axis_tdata(481),
      I2 => arb_sel_i,
      O => m_axis_tdata(225)
    );
\m_axis_tdata[226]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(226),
      I1 => s_axis_tdata(482),
      I2 => arb_sel_i,
      O => m_axis_tdata(226)
    );
\m_axis_tdata[227]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(227),
      I1 => s_axis_tdata(483),
      I2 => arb_sel_i,
      O => m_axis_tdata(227)
    );
\m_axis_tdata[228]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(228),
      I1 => s_axis_tdata(484),
      I2 => arb_sel_i,
      O => m_axis_tdata(228)
    );
\m_axis_tdata[229]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(229),
      I1 => s_axis_tdata(485),
      I2 => arb_sel_i,
      O => m_axis_tdata(229)
    );
\m_axis_tdata[22]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(22),
      I1 => s_axis_tdata(278),
      I2 => arb_sel_i,
      O => m_axis_tdata(22)
    );
\m_axis_tdata[230]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(230),
      I1 => s_axis_tdata(486),
      I2 => arb_sel_i,
      O => m_axis_tdata(230)
    );
\m_axis_tdata[231]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(231),
      I1 => s_axis_tdata(487),
      I2 => arb_sel_i,
      O => m_axis_tdata(231)
    );
\m_axis_tdata[232]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(232),
      I1 => s_axis_tdata(488),
      I2 => arb_sel_i,
      O => m_axis_tdata(232)
    );
\m_axis_tdata[233]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(233),
      I1 => s_axis_tdata(489),
      I2 => arb_sel_i,
      O => m_axis_tdata(233)
    );
\m_axis_tdata[234]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(234),
      I1 => s_axis_tdata(490),
      I2 => arb_sel_i,
      O => m_axis_tdata(234)
    );
\m_axis_tdata[235]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(235),
      I1 => s_axis_tdata(491),
      I2 => arb_sel_i,
      O => m_axis_tdata(235)
    );
\m_axis_tdata[236]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(236),
      I1 => s_axis_tdata(492),
      I2 => arb_sel_i,
      O => m_axis_tdata(236)
    );
\m_axis_tdata[237]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(237),
      I1 => s_axis_tdata(493),
      I2 => arb_sel_i,
      O => m_axis_tdata(237)
    );
\m_axis_tdata[238]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(238),
      I1 => s_axis_tdata(494),
      I2 => arb_sel_i,
      O => m_axis_tdata(238)
    );
\m_axis_tdata[239]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(239),
      I1 => s_axis_tdata(495),
      I2 => arb_sel_i,
      O => m_axis_tdata(239)
    );
\m_axis_tdata[23]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(23),
      I1 => s_axis_tdata(279),
      I2 => arb_sel_i,
      O => m_axis_tdata(23)
    );
\m_axis_tdata[240]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(240),
      I1 => s_axis_tdata(496),
      I2 => arb_sel_i,
      O => m_axis_tdata(240)
    );
\m_axis_tdata[241]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(241),
      I1 => s_axis_tdata(497),
      I2 => arb_sel_i,
      O => m_axis_tdata(241)
    );
\m_axis_tdata[242]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(242),
      I1 => s_axis_tdata(498),
      I2 => arb_sel_i,
      O => m_axis_tdata(242)
    );
\m_axis_tdata[243]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(243),
      I1 => s_axis_tdata(499),
      I2 => arb_sel_i,
      O => m_axis_tdata(243)
    );
\m_axis_tdata[244]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(244),
      I1 => s_axis_tdata(500),
      I2 => arb_sel_i,
      O => m_axis_tdata(244)
    );
\m_axis_tdata[245]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(245),
      I1 => s_axis_tdata(501),
      I2 => arb_sel_i,
      O => m_axis_tdata(245)
    );
\m_axis_tdata[246]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(246),
      I1 => s_axis_tdata(502),
      I2 => arb_sel_i,
      O => m_axis_tdata(246)
    );
\m_axis_tdata[247]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(247),
      I1 => s_axis_tdata(503),
      I2 => arb_sel_i,
      O => m_axis_tdata(247)
    );
\m_axis_tdata[248]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(248),
      I1 => s_axis_tdata(504),
      I2 => arb_sel_i,
      O => m_axis_tdata(248)
    );
\m_axis_tdata[249]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(249),
      I1 => s_axis_tdata(505),
      I2 => arb_sel_i,
      O => m_axis_tdata(249)
    );
\m_axis_tdata[24]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(24),
      I1 => s_axis_tdata(280),
      I2 => arb_sel_i,
      O => m_axis_tdata(24)
    );
\m_axis_tdata[250]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(250),
      I1 => s_axis_tdata(506),
      I2 => arb_sel_i,
      O => m_axis_tdata(250)
    );
\m_axis_tdata[251]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(251),
      I1 => s_axis_tdata(507),
      I2 => arb_sel_i,
      O => m_axis_tdata(251)
    );
\m_axis_tdata[252]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(252),
      I1 => s_axis_tdata(508),
      I2 => arb_sel_i,
      O => m_axis_tdata(252)
    );
\m_axis_tdata[253]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(253),
      I1 => s_axis_tdata(509),
      I2 => arb_sel_i,
      O => m_axis_tdata(253)
    );
\m_axis_tdata[254]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(254),
      I1 => s_axis_tdata(510),
      I2 => arb_sel_i,
      O => m_axis_tdata(254)
    );
\m_axis_tdata[255]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(255),
      I1 => s_axis_tdata(511),
      I2 => arb_sel_i,
      O => m_axis_tdata(255)
    );
\m_axis_tdata[25]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(25),
      I1 => s_axis_tdata(281),
      I2 => arb_sel_i,
      O => m_axis_tdata(25)
    );
\m_axis_tdata[26]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(26),
      I1 => s_axis_tdata(282),
      I2 => arb_sel_i,
      O => m_axis_tdata(26)
    );
\m_axis_tdata[27]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(27),
      I1 => s_axis_tdata(283),
      I2 => arb_sel_i,
      O => m_axis_tdata(27)
    );
\m_axis_tdata[28]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(28),
      I1 => s_axis_tdata(284),
      I2 => arb_sel_i,
      O => m_axis_tdata(28)
    );
\m_axis_tdata[29]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(29),
      I1 => s_axis_tdata(285),
      I2 => arb_sel_i,
      O => m_axis_tdata(29)
    );
\m_axis_tdata[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(2),
      I1 => s_axis_tdata(258),
      I2 => arb_sel_i,
      O => m_axis_tdata(2)
    );
\m_axis_tdata[30]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(30),
      I1 => s_axis_tdata(286),
      I2 => arb_sel_i,
      O => m_axis_tdata(30)
    );
\m_axis_tdata[31]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(31),
      I1 => s_axis_tdata(287),
      I2 => arb_sel_i,
      O => m_axis_tdata(31)
    );
\m_axis_tdata[32]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(32),
      I1 => s_axis_tdata(288),
      I2 => arb_sel_i,
      O => m_axis_tdata(32)
    );
\m_axis_tdata[33]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(33),
      I1 => s_axis_tdata(289),
      I2 => arb_sel_i,
      O => m_axis_tdata(33)
    );
\m_axis_tdata[34]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(34),
      I1 => s_axis_tdata(290),
      I2 => arb_sel_i,
      O => m_axis_tdata(34)
    );
\m_axis_tdata[35]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(35),
      I1 => s_axis_tdata(291),
      I2 => arb_sel_i,
      O => m_axis_tdata(35)
    );
\m_axis_tdata[36]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(36),
      I1 => s_axis_tdata(292),
      I2 => arb_sel_i,
      O => m_axis_tdata(36)
    );
\m_axis_tdata[37]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(37),
      I1 => s_axis_tdata(293),
      I2 => arb_sel_i,
      O => m_axis_tdata(37)
    );
\m_axis_tdata[38]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(38),
      I1 => s_axis_tdata(294),
      I2 => arb_sel_i,
      O => m_axis_tdata(38)
    );
\m_axis_tdata[39]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(39),
      I1 => s_axis_tdata(295),
      I2 => arb_sel_i,
      O => m_axis_tdata(39)
    );
\m_axis_tdata[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(3),
      I1 => s_axis_tdata(259),
      I2 => arb_sel_i,
      O => m_axis_tdata(3)
    );
\m_axis_tdata[40]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(40),
      I1 => s_axis_tdata(296),
      I2 => arb_sel_i,
      O => m_axis_tdata(40)
    );
\m_axis_tdata[41]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(41),
      I1 => s_axis_tdata(297),
      I2 => arb_sel_i,
      O => m_axis_tdata(41)
    );
\m_axis_tdata[42]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(42),
      I1 => s_axis_tdata(298),
      I2 => arb_sel_i,
      O => m_axis_tdata(42)
    );
\m_axis_tdata[43]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(43),
      I1 => s_axis_tdata(299),
      I2 => arb_sel_i,
      O => m_axis_tdata(43)
    );
\m_axis_tdata[44]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(44),
      I1 => s_axis_tdata(300),
      I2 => arb_sel_i,
      O => m_axis_tdata(44)
    );
\m_axis_tdata[45]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(45),
      I1 => s_axis_tdata(301),
      I2 => arb_sel_i,
      O => m_axis_tdata(45)
    );
\m_axis_tdata[46]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(46),
      I1 => s_axis_tdata(302),
      I2 => arb_sel_i,
      O => m_axis_tdata(46)
    );
\m_axis_tdata[47]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(47),
      I1 => s_axis_tdata(303),
      I2 => arb_sel_i,
      O => m_axis_tdata(47)
    );
\m_axis_tdata[48]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(48),
      I1 => s_axis_tdata(304),
      I2 => arb_sel_i,
      O => m_axis_tdata(48)
    );
\m_axis_tdata[49]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(49),
      I1 => s_axis_tdata(305),
      I2 => arb_sel_i,
      O => m_axis_tdata(49)
    );
\m_axis_tdata[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(4),
      I1 => s_axis_tdata(260),
      I2 => arb_sel_i,
      O => m_axis_tdata(4)
    );
\m_axis_tdata[50]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(50),
      I1 => s_axis_tdata(306),
      I2 => arb_sel_i,
      O => m_axis_tdata(50)
    );
\m_axis_tdata[51]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(51),
      I1 => s_axis_tdata(307),
      I2 => arb_sel_i,
      O => m_axis_tdata(51)
    );
\m_axis_tdata[52]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(52),
      I1 => s_axis_tdata(308),
      I2 => arb_sel_i,
      O => m_axis_tdata(52)
    );
\m_axis_tdata[53]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(53),
      I1 => s_axis_tdata(309),
      I2 => arb_sel_i,
      O => m_axis_tdata(53)
    );
\m_axis_tdata[54]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(54),
      I1 => s_axis_tdata(310),
      I2 => arb_sel_i,
      O => m_axis_tdata(54)
    );
\m_axis_tdata[55]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(55),
      I1 => s_axis_tdata(311),
      I2 => arb_sel_i,
      O => m_axis_tdata(55)
    );
\m_axis_tdata[56]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(56),
      I1 => s_axis_tdata(312),
      I2 => arb_sel_i,
      O => m_axis_tdata(56)
    );
\m_axis_tdata[57]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(57),
      I1 => s_axis_tdata(313),
      I2 => arb_sel_i,
      O => m_axis_tdata(57)
    );
\m_axis_tdata[58]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(58),
      I1 => s_axis_tdata(314),
      I2 => arb_sel_i,
      O => m_axis_tdata(58)
    );
\m_axis_tdata[59]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(59),
      I1 => s_axis_tdata(315),
      I2 => arb_sel_i,
      O => m_axis_tdata(59)
    );
\m_axis_tdata[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(5),
      I1 => s_axis_tdata(261),
      I2 => arb_sel_i,
      O => m_axis_tdata(5)
    );
\m_axis_tdata[60]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(60),
      I1 => s_axis_tdata(316),
      I2 => arb_sel_i,
      O => m_axis_tdata(60)
    );
\m_axis_tdata[61]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(61),
      I1 => s_axis_tdata(317),
      I2 => arb_sel_i,
      O => m_axis_tdata(61)
    );
\m_axis_tdata[62]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(62),
      I1 => s_axis_tdata(318),
      I2 => arb_sel_i,
      O => m_axis_tdata(62)
    );
\m_axis_tdata[63]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(63),
      I1 => s_axis_tdata(319),
      I2 => arb_sel_i,
      O => m_axis_tdata(63)
    );
\m_axis_tdata[64]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(64),
      I1 => s_axis_tdata(320),
      I2 => arb_sel_i,
      O => m_axis_tdata(64)
    );
\m_axis_tdata[65]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(65),
      I1 => s_axis_tdata(321),
      I2 => arb_sel_i,
      O => m_axis_tdata(65)
    );
\m_axis_tdata[66]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(66),
      I1 => s_axis_tdata(322),
      I2 => arb_sel_i,
      O => m_axis_tdata(66)
    );
\m_axis_tdata[67]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(67),
      I1 => s_axis_tdata(323),
      I2 => arb_sel_i,
      O => m_axis_tdata(67)
    );
\m_axis_tdata[68]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(68),
      I1 => s_axis_tdata(324),
      I2 => arb_sel_i,
      O => m_axis_tdata(68)
    );
\m_axis_tdata[69]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(69),
      I1 => s_axis_tdata(325),
      I2 => arb_sel_i,
      O => m_axis_tdata(69)
    );
\m_axis_tdata[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(6),
      I1 => s_axis_tdata(262),
      I2 => arb_sel_i,
      O => m_axis_tdata(6)
    );
\m_axis_tdata[70]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(70),
      I1 => s_axis_tdata(326),
      I2 => arb_sel_i,
      O => m_axis_tdata(70)
    );
\m_axis_tdata[71]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(71),
      I1 => s_axis_tdata(327),
      I2 => arb_sel_i,
      O => m_axis_tdata(71)
    );
\m_axis_tdata[72]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(72),
      I1 => s_axis_tdata(328),
      I2 => arb_sel_i,
      O => m_axis_tdata(72)
    );
\m_axis_tdata[73]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(73),
      I1 => s_axis_tdata(329),
      I2 => arb_sel_i,
      O => m_axis_tdata(73)
    );
\m_axis_tdata[74]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(74),
      I1 => s_axis_tdata(330),
      I2 => arb_sel_i,
      O => m_axis_tdata(74)
    );
\m_axis_tdata[75]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(75),
      I1 => s_axis_tdata(331),
      I2 => arb_sel_i,
      O => m_axis_tdata(75)
    );
\m_axis_tdata[76]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(76),
      I1 => s_axis_tdata(332),
      I2 => arb_sel_i,
      O => m_axis_tdata(76)
    );
\m_axis_tdata[77]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(77),
      I1 => s_axis_tdata(333),
      I2 => arb_sel_i,
      O => m_axis_tdata(77)
    );
\m_axis_tdata[78]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(78),
      I1 => s_axis_tdata(334),
      I2 => arb_sel_i,
      O => m_axis_tdata(78)
    );
\m_axis_tdata[79]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(79),
      I1 => s_axis_tdata(335),
      I2 => arb_sel_i,
      O => m_axis_tdata(79)
    );
\m_axis_tdata[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(7),
      I1 => s_axis_tdata(263),
      I2 => arb_sel_i,
      O => m_axis_tdata(7)
    );
\m_axis_tdata[80]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(80),
      I1 => s_axis_tdata(336),
      I2 => arb_sel_i,
      O => m_axis_tdata(80)
    );
\m_axis_tdata[81]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(81),
      I1 => s_axis_tdata(337),
      I2 => arb_sel_i,
      O => m_axis_tdata(81)
    );
\m_axis_tdata[82]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(82),
      I1 => s_axis_tdata(338),
      I2 => arb_sel_i,
      O => m_axis_tdata(82)
    );
\m_axis_tdata[83]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(83),
      I1 => s_axis_tdata(339),
      I2 => arb_sel_i,
      O => m_axis_tdata(83)
    );
\m_axis_tdata[84]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(84),
      I1 => s_axis_tdata(340),
      I2 => arb_sel_i,
      O => m_axis_tdata(84)
    );
\m_axis_tdata[85]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(85),
      I1 => s_axis_tdata(341),
      I2 => arb_sel_i,
      O => m_axis_tdata(85)
    );
\m_axis_tdata[86]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(86),
      I1 => s_axis_tdata(342),
      I2 => arb_sel_i,
      O => m_axis_tdata(86)
    );
\m_axis_tdata[87]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(87),
      I1 => s_axis_tdata(343),
      I2 => arb_sel_i,
      O => m_axis_tdata(87)
    );
\m_axis_tdata[88]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(88),
      I1 => s_axis_tdata(344),
      I2 => arb_sel_i,
      O => m_axis_tdata(88)
    );
\m_axis_tdata[89]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(89),
      I1 => s_axis_tdata(345),
      I2 => arb_sel_i,
      O => m_axis_tdata(89)
    );
\m_axis_tdata[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(8),
      I1 => s_axis_tdata(264),
      I2 => arb_sel_i,
      O => m_axis_tdata(8)
    );
\m_axis_tdata[90]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(90),
      I1 => s_axis_tdata(346),
      I2 => arb_sel_i,
      O => m_axis_tdata(90)
    );
\m_axis_tdata[91]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(91),
      I1 => s_axis_tdata(347),
      I2 => arb_sel_i,
      O => m_axis_tdata(91)
    );
\m_axis_tdata[92]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(92),
      I1 => s_axis_tdata(348),
      I2 => arb_sel_i,
      O => m_axis_tdata(92)
    );
\m_axis_tdata[93]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(93),
      I1 => s_axis_tdata(349),
      I2 => arb_sel_i,
      O => m_axis_tdata(93)
    );
\m_axis_tdata[94]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(94),
      I1 => s_axis_tdata(350),
      I2 => arb_sel_i,
      O => m_axis_tdata(94)
    );
\m_axis_tdata[95]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(95),
      I1 => s_axis_tdata(351),
      I2 => arb_sel_i,
      O => m_axis_tdata(95)
    );
\m_axis_tdata[96]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(96),
      I1 => s_axis_tdata(352),
      I2 => arb_sel_i,
      O => m_axis_tdata(96)
    );
\m_axis_tdata[97]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(97),
      I1 => s_axis_tdata(353),
      I2 => arb_sel_i,
      O => m_axis_tdata(97)
    );
\m_axis_tdata[98]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(98),
      I1 => s_axis_tdata(354),
      I2 => arb_sel_i,
      O => m_axis_tdata(98)
    );
\m_axis_tdata[99]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(99),
      I1 => s_axis_tdata(355),
      I2 => arb_sel_i,
      O => m_axis_tdata(99)
    );
\m_axis_tdata[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => s_axis_tdata(9),
      I1 => s_axis_tdata(265),
      I2 => arb_sel_i,
      O => m_axis_tdata(9)
    );
\m_axis_tvalid[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D8D8D8D8D8D8D800"
    )
        port map (
      I0 => arb_sel_i,
      I1 => s_axis_tvalid(1),
      I2 => s_axis_tvalid(0),
      I3 => \^arb_gnt_r_reg[1]_1\,
      I4 => \^arb_gnt_r_reg[0]_0\,
      I5 => \gen_tdest_router.busy_r\(0),
      O => m_axis_tvalid(0)
    );
\m_axis_tvalid[0]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^arb_gnt_r_reg[1]_0\,
      I1 => \gen_tdest_router.busy_r\(1),
      O => \^arb_gnt_r_reg[1]_1\
    );
\port_priority_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \barrel_cntr[0]_i_1_n_0\,
      D => port_priority_ns(0),
      Q => port_priority_ns(1),
      R => \arb_gnt_r_reg[1]_2\
    );
\port_priority_r_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => \barrel_cntr[0]_i_1_n_0\,
      D => port_priority_ns(1),
      Q => port_priority_ns(0),
      S => \arb_gnt_r_reg[1]_2\
    );
\s_axis_tready[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A800"
    )
        port map (
      I0 => s_axis_tvalid(0),
      I1 => \^arb_gnt_r_reg[0]_0\,
      I2 => \gen_tdest_router.busy_r\(0),
      I3 => m_axis_tready(0),
      O => s_axis_tready(0)
    );
\s_axis_tready[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A800"
    )
        port map (
      I0 => s_axis_tvalid(1),
      I1 => \^arb_gnt_r_reg[1]_0\,
      I2 => \gen_tdest_router.busy_r\(1),
      I3 => m_axis_tready(0),
      O => s_axis_tready(1)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder is
  port (
    \gen_tdest_router.busy_r\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \busy_r_reg[0]_0\ : in STD_LOGIC;
    \busy_r_reg[1]_0\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \busy_r_reg[0]_1\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder : entity is "axis_switch_v1_1_22_axisc_arb_responder";
end axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder is
begin
\busy_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \busy_r_reg[0]_1\,
      Q => \gen_tdest_router.busy_r\(0),
      R => \busy_r_reg[0]_0\
    );
\busy_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \busy_r_reg[1]_0\,
      Q => \gen_tdest_router.busy_r\(1),
      R => \busy_r_reg[0]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_axisc_decoder is
  port (
    \gen_tdest_routing.busy_r_reg[0]_0\ : out STD_LOGIC;
    \arb_req_i__1\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    areset : in STD_LOGIC;
    \gen_tdest_routing.busy_ns\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_req_suppress : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    arb_gnt_i : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_axisc_decoder : entity is "axis_switch_v1_1_22_axisc_decoder";
end axis_switch_0_axis_switch_v1_1_22_axisc_decoder;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_axisc_decoder is
  signal \^gen_tdest_routing.busy_r_reg[0]_0\ : STD_LOGIC;
begin
  \gen_tdest_routing.busy_r_reg[0]_0\ <= \^gen_tdest_routing.busy_r_reg[0]_0\;
\arb_gnt_r[1]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => s_req_suppress(0),
      I1 => s_axis_tvalid(0),
      I2 => \^gen_tdest_routing.busy_r_reg[0]_0\,
      I3 => arb_gnt_i(0),
      O => \arb_req_i__1\(0)
    );
\gen_tdest_routing.busy_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_tdest_routing.busy_ns\,
      Q => \^gen_tdest_routing.busy_r_reg[0]_0\,
      R => areset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0 is
  port (
    \gen_tdest_routing.busy_r_reg[0]_0\ : out STD_LOGIC;
    \arb_req_i__1\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    valid_i : out STD_LOGIC;
    areset : in STD_LOGIC;
    \gen_tdest_routing.busy_ns\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_req_suppress : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_gnt_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_busy_r_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0 : entity is "axis_switch_v1_1_22_axisc_decoder";
end axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0 is
  signal \^arb_req_i__1\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gen_tdest_routing.busy_r_reg[0]_0\ : STD_LOGIC;
begin
  \arb_req_i__1\(0) <= \^arb_req_i__1\(0);
  \gen_tdest_routing.busy_r_reg[0]_0\ <= \^gen_tdest_routing.busy_r_reg[0]_0\;
\arb_gnt_r[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAABAA"
    )
        port map (
      I0 => \^arb_req_i__1\(0),
      I1 => arb_gnt_i(0),
      I2 => arb_busy_r_reg,
      I3 => s_axis_tvalid(0),
      I4 => s_req_suppress(0),
      O => valid_i
    );
\arb_gnt_r[1]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => s_req_suppress(1),
      I1 => s_axis_tvalid(1),
      I2 => \^gen_tdest_routing.busy_r_reg[0]_0\,
      I3 => arb_gnt_i(1),
      O => \^arb_req_i__1\(0)
    );
\gen_tdest_routing.busy_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_tdest_routing.busy_ns\,
      Q => \^gen_tdest_routing.busy_r_reg[0]_0\,
      R => areset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter is
  port (
    areset : out STD_LOGIC;
    s_axis_tready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_gnt_i : out STD_LOGIC_VECTOR ( 1 downto 0 );
    areset_reg_0 : out STD_LOGIC;
    \gen_tdest_routing.busy_ns\ : out STD_LOGIC;
    \gen_tdest_routing.busy_ns_0\ : out STD_LOGIC;
    \arb_gnt_r_reg[0]\ : out STD_LOGIC;
    \arb_gnt_r_reg[1]\ : out STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_tdest_router.busy_r\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    valid_i : in STD_LOGIC;
    \arb_req_i__1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_tdest_routing.busy_r_reg[0]\ : in STD_LOGIC;
    \gen_tdest_routing.busy_r_reg[0]_0\ : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter : entity is "axis_switch_v1_1_22_axis_switch_arbiter";
end axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter is
  signal \^areset\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
begin
  areset <= \^areset\;
areset_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn,
      O => p_0_in
    );
areset_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => p_0_in,
      Q => \^areset\,
      R => '0'
    );
\gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0\: entity work.axis_switch_0_axis_switch_v1_1_22_arb_rr
     port map (
      aclk => aclk,
      \arb_gnt_r_reg[0]_0\ => arb_gnt_i(0),
      \arb_gnt_r_reg[0]_1\ => \arb_gnt_r_reg[0]\,
      \arb_gnt_r_reg[1]_0\ => arb_gnt_i(1),
      \arb_gnt_r_reg[1]_1\ => \arb_gnt_r_reg[1]\,
      \arb_gnt_r_reg[1]_2\ => \^areset\,
      \arb_req_i__1\(1 downto 0) => \arb_req_i__1\(1 downto 0),
      areset_reg => areset_reg_0,
      \gen_tdest_router.busy_r\(1 downto 0) => \gen_tdest_router.busy_r\(1 downto 0),
      \gen_tdest_routing.busy_ns\ => \gen_tdest_routing.busy_ns\,
      \gen_tdest_routing.busy_ns_0\ => \gen_tdest_routing.busy_ns_0\,
      \gen_tdest_routing.busy_r_reg[0]\ => \gen_tdest_routing.busy_r_reg[0]\,
      \gen_tdest_routing.busy_r_reg[0]_0\ => \gen_tdest_routing.busy_r_reg[0]_0\,
      m_axis_tdata(255 downto 0) => m_axis_tdata(255 downto 0),
      m_axis_tready(0) => m_axis_tready(0),
      m_axis_tvalid(0) => m_axis_tvalid(0),
      s_axis_tdata(511 downto 0) => s_axis_tdata(511 downto 0),
      s_axis_tready(1 downto 0) => s_axis_tready(1 downto 0),
      s_axis_tvalid(1 downto 0) => s_axis_tvalid(1 downto 0),
      valid_i => valid_i
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux is
  port (
    \gen_tdest_router.busy_r\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \busy_r_reg[0]\ : in STD_LOGIC;
    \busy_r_reg[1]\ : in STD_LOGIC;
    aclk : in STD_LOGIC;
    \busy_r_reg[0]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux : entity is "axis_switch_v1_1_22_axisc_transfer_mux";
end axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux is
begin
\gen_tdest_router.axisc_arb_responder\: entity work.axis_switch_0_axis_switch_v1_1_22_axisc_arb_responder
     port map (
      aclk => aclk,
      \busy_r_reg[0]_0\ => \busy_r_reg[0]\,
      \busy_r_reg[0]_1\ => \busy_r_reg[0]_0\,
      \busy_r_reg[1]_0\ => \busy_r_reg[1]\,
      \gen_tdest_router.busy_r\(1 downto 0) => \gen_tdest_router.busy_r\(1 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0_axis_switch_v1_1_22_axis_switch is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tlast : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    arb_req : out STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_done : out STD_LOGIC_VECTOR ( 0 to 0 );
    arb_gnt : in STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_sel : in STD_LOGIC_VECTOR ( 0 to 0 );
    arb_last : out STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_id : out STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_dest : out STD_LOGIC_VECTOR ( 1 downto 0 );
    arb_user : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_req_suppress : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_ctrl_aclk : in STD_LOGIC;
    s_axi_ctrl_aresetn : in STD_LOGIC;
    s_axi_ctrl_awvalid : in STD_LOGIC;
    s_axi_ctrl_awready : out STD_LOGIC;
    s_axi_ctrl_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_ctrl_wvalid : in STD_LOGIC;
    s_axi_ctrl_wready : out STD_LOGIC;
    s_axi_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_ctrl_bvalid : out STD_LOGIC;
    s_axi_ctrl_bready : in STD_LOGIC;
    s_axi_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_ctrl_arvalid : in STD_LOGIC;
    s_axi_ctrl_arready : out STD_LOGIC;
    s_axi_ctrl_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_ctrl_rvalid : out STD_LOGIC;
    s_axi_ctrl_rready : in STD_LOGIC;
    s_axi_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_decode_err : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute C_ARB_ALGORITHM : integer;
  attribute C_ARB_ALGORITHM of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_ARB_ON_MAX_XFERS : integer;
  attribute C_ARB_ON_MAX_XFERS of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_ARB_ON_NUM_CYCLES : integer;
  attribute C_ARB_ON_NUM_CYCLES of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_ARB_ON_TLAST : integer;
  attribute C_ARB_ON_TLAST of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 3;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 256;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_COMMON_CLOCK : integer;
  attribute C_COMMON_CLOCK of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_DECODER_REG : integer;
  attribute C_DECODER_REG of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "virtexuplusHBM";
  attribute C_INCLUDE_ARBITER : integer;
  attribute C_INCLUDE_ARBITER of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_LOG_SI_SLOTS : integer;
  attribute C_LOG_SI_SLOTS of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_M_AXIS_BASETDEST_ARRAY : string;
  attribute C_M_AXIS_BASETDEST_ARRAY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "1'b0";
  attribute C_M_AXIS_CONNECTIVITY_ARRAY : string;
  attribute C_M_AXIS_CONNECTIVITY_ARRAY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "2'b11";
  attribute C_M_AXIS_HIGHTDEST_ARRAY : string;
  attribute C_M_AXIS_HIGHTDEST_ARRAY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "1'b0";
  attribute C_NUM_MI_SLOTS : integer;
  attribute C_NUM_MI_SLOTS of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute C_NUM_SI_SLOTS : integer;
  attribute C_NUM_SI_SLOTS of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 2;
  attribute C_OUTPUT_REG : integer;
  attribute C_OUTPUT_REG of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_ROUTING_MODE : integer;
  attribute C_ROUTING_MODE of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute C_S_AXI_CTRL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CTRL_ADDR_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 7;
  attribute C_S_AXI_CTRL_DATA_WIDTH : integer;
  attribute C_S_AXI_CTRL_DATA_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 32;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 1;
  attribute LP_CTRL_REG_WIDTH : integer;
  attribute LP_CTRL_REG_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 15;
  attribute LP_MERGEDOWN_MUX : integer;
  attribute LP_MERGEDOWN_MUX of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 0;
  attribute LP_NUM_SYNCHRONIZER_STAGES : integer;
  attribute LP_NUM_SYNCHRONIZER_STAGES of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 4;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "axis_switch_v1_1_22_axis_switch";
  attribute P_DECODER_CONNECTIVITY_ARRAY : string;
  attribute P_DECODER_CONNECTIVITY_ARRAY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "2'b11";
  attribute P_SINGLE_SLAVE_CONNECTIVITY_ARRAY : string;
  attribute P_SINGLE_SLAVE_CONNECTIVITY_ARRAY of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is "1'b0";
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of axis_switch_0_axis_switch_v1_1_22_axis_switch : entity is 256;
end axis_switch_0_axis_switch_v1_1_22_axis_switch;

architecture STRUCTURE of axis_switch_0_axis_switch_v1_1_22_axis_switch is
  signal \<const0>\ : STD_LOGIC;
  signal arb_gnt_i : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal areset : STD_LOGIC;
  signal \gen_decoder[0].axisc_decoder_0_n_0\ : STD_LOGIC;
  signal \gen_decoder[1].axisc_decoder_0_n_0\ : STD_LOGIC;
  signal \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_5\ : STD_LOGIC;
  signal \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_8\ : STD_LOGIC;
  signal \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_9\ : STD_LOGIC;
  signal \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/valid_i\ : STD_LOGIC;
  signal \gen_tdest_router.busy_r\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gen_tdest_routing.busy_ns\ : STD_LOGIC;
  signal \gen_tdest_routing.busy_ns_0\ : STD_LOGIC;
begin
  arb_dest(1) <= \<const0>\;
  arb_dest(0) <= \<const0>\;
  arb_done(0) <= \<const0>\;
  arb_id(1) <= \<const0>\;
  arb_id(0) <= \<const0>\;
  arb_last(1) <= \<const0>\;
  arb_last(0) <= \<const0>\;
  arb_req(1) <= \<const0>\;
  arb_req(0) <= \<const0>\;
  arb_user(1) <= \<const0>\;
  arb_user(0) <= \<const0>\;
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tkeep(31) <= \<const0>\;
  m_axis_tkeep(30) <= \<const0>\;
  m_axis_tkeep(29) <= \<const0>\;
  m_axis_tkeep(28) <= \<const0>\;
  m_axis_tkeep(27) <= \<const0>\;
  m_axis_tkeep(26) <= \<const0>\;
  m_axis_tkeep(25) <= \<const0>\;
  m_axis_tkeep(24) <= \<const0>\;
  m_axis_tkeep(23) <= \<const0>\;
  m_axis_tkeep(22) <= \<const0>\;
  m_axis_tkeep(21) <= \<const0>\;
  m_axis_tkeep(20) <= \<const0>\;
  m_axis_tkeep(19) <= \<const0>\;
  m_axis_tkeep(18) <= \<const0>\;
  m_axis_tkeep(17) <= \<const0>\;
  m_axis_tkeep(16) <= \<const0>\;
  m_axis_tkeep(15) <= \<const0>\;
  m_axis_tkeep(14) <= \<const0>\;
  m_axis_tkeep(13) <= \<const0>\;
  m_axis_tkeep(12) <= \<const0>\;
  m_axis_tkeep(11) <= \<const0>\;
  m_axis_tkeep(10) <= \<const0>\;
  m_axis_tkeep(9) <= \<const0>\;
  m_axis_tkeep(8) <= \<const0>\;
  m_axis_tkeep(7) <= \<const0>\;
  m_axis_tkeep(6) <= \<const0>\;
  m_axis_tkeep(5) <= \<const0>\;
  m_axis_tkeep(4) <= \<const0>\;
  m_axis_tkeep(3) <= \<const0>\;
  m_axis_tkeep(2) <= \<const0>\;
  m_axis_tkeep(1) <= \<const0>\;
  m_axis_tkeep(0) <= \<const0>\;
  m_axis_tlast(0) <= \<const0>\;
  m_axis_tstrb(31) <= \<const0>\;
  m_axis_tstrb(30) <= \<const0>\;
  m_axis_tstrb(29) <= \<const0>\;
  m_axis_tstrb(28) <= \<const0>\;
  m_axis_tstrb(27) <= \<const0>\;
  m_axis_tstrb(26) <= \<const0>\;
  m_axis_tstrb(25) <= \<const0>\;
  m_axis_tstrb(24) <= \<const0>\;
  m_axis_tstrb(23) <= \<const0>\;
  m_axis_tstrb(22) <= \<const0>\;
  m_axis_tstrb(21) <= \<const0>\;
  m_axis_tstrb(20) <= \<const0>\;
  m_axis_tstrb(19) <= \<const0>\;
  m_axis_tstrb(18) <= \<const0>\;
  m_axis_tstrb(17) <= \<const0>\;
  m_axis_tstrb(16) <= \<const0>\;
  m_axis_tstrb(15) <= \<const0>\;
  m_axis_tstrb(14) <= \<const0>\;
  m_axis_tstrb(13) <= \<const0>\;
  m_axis_tstrb(12) <= \<const0>\;
  m_axis_tstrb(11) <= \<const0>\;
  m_axis_tstrb(10) <= \<const0>\;
  m_axis_tstrb(9) <= \<const0>\;
  m_axis_tstrb(8) <= \<const0>\;
  m_axis_tstrb(7) <= \<const0>\;
  m_axis_tstrb(6) <= \<const0>\;
  m_axis_tstrb(5) <= \<const0>\;
  m_axis_tstrb(4) <= \<const0>\;
  m_axis_tstrb(3) <= \<const0>\;
  m_axis_tstrb(2) <= \<const0>\;
  m_axis_tstrb(1) <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
  m_axis_tuser(0) <= \<const0>\;
  s_axi_ctrl_arready <= \<const0>\;
  s_axi_ctrl_awready <= \<const0>\;
  s_axi_ctrl_bresp(1) <= \<const0>\;
  s_axi_ctrl_bresp(0) <= \<const0>\;
  s_axi_ctrl_bvalid <= \<const0>\;
  s_axi_ctrl_rdata(31) <= \<const0>\;
  s_axi_ctrl_rdata(30) <= \<const0>\;
  s_axi_ctrl_rdata(29) <= \<const0>\;
  s_axi_ctrl_rdata(28) <= \<const0>\;
  s_axi_ctrl_rdata(27) <= \<const0>\;
  s_axi_ctrl_rdata(26) <= \<const0>\;
  s_axi_ctrl_rdata(25) <= \<const0>\;
  s_axi_ctrl_rdata(24) <= \<const0>\;
  s_axi_ctrl_rdata(23) <= \<const0>\;
  s_axi_ctrl_rdata(22) <= \<const0>\;
  s_axi_ctrl_rdata(21) <= \<const0>\;
  s_axi_ctrl_rdata(20) <= \<const0>\;
  s_axi_ctrl_rdata(19) <= \<const0>\;
  s_axi_ctrl_rdata(18) <= \<const0>\;
  s_axi_ctrl_rdata(17) <= \<const0>\;
  s_axi_ctrl_rdata(16) <= \<const0>\;
  s_axi_ctrl_rdata(15) <= \<const0>\;
  s_axi_ctrl_rdata(14) <= \<const0>\;
  s_axi_ctrl_rdata(13) <= \<const0>\;
  s_axi_ctrl_rdata(12) <= \<const0>\;
  s_axi_ctrl_rdata(11) <= \<const0>\;
  s_axi_ctrl_rdata(10) <= \<const0>\;
  s_axi_ctrl_rdata(9) <= \<const0>\;
  s_axi_ctrl_rdata(8) <= \<const0>\;
  s_axi_ctrl_rdata(7) <= \<const0>\;
  s_axi_ctrl_rdata(6) <= \<const0>\;
  s_axi_ctrl_rdata(5) <= \<const0>\;
  s_axi_ctrl_rdata(4) <= \<const0>\;
  s_axi_ctrl_rdata(3) <= \<const0>\;
  s_axi_ctrl_rdata(2) <= \<const0>\;
  s_axi_ctrl_rdata(1) <= \<const0>\;
  s_axi_ctrl_rdata(0) <= \<const0>\;
  s_axi_ctrl_rresp(1) <= \<const0>\;
  s_axi_ctrl_rresp(0) <= \<const0>\;
  s_axi_ctrl_rvalid <= \<const0>\;
  s_axi_ctrl_wready <= \<const0>\;
  s_decode_err(1) <= \<const0>\;
  s_decode_err(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gen_decoder[0].axisc_decoder_0\: entity work.axis_switch_0_axis_switch_v1_1_22_axisc_decoder
     port map (
      aclk => aclk,
      arb_gnt_i(0) => arb_gnt_i(0),
      \arb_req_i__1\(0) => \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1\(0),
      areset => areset,
      \gen_tdest_routing.busy_ns\ => \gen_tdest_routing.busy_ns\,
      \gen_tdest_routing.busy_r_reg[0]_0\ => \gen_decoder[0].axisc_decoder_0_n_0\,
      s_axis_tvalid(0) => s_axis_tvalid(0),
      s_req_suppress(0) => s_req_suppress(0)
    );
\gen_decoder[1].axisc_decoder_0\: entity work.axis_switch_0_axis_switch_v1_1_22_axisc_decoder_0
     port map (
      aclk => aclk,
      arb_busy_r_reg => \gen_decoder[0].axisc_decoder_0_n_0\,
      arb_gnt_i(1 downto 0) => arb_gnt_i(1 downto 0),
      \arb_req_i__1\(0) => \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1\(1),
      areset => areset,
      \gen_tdest_routing.busy_ns\ => \gen_tdest_routing.busy_ns_0\,
      \gen_tdest_routing.busy_r_reg[0]_0\ => \gen_decoder[1].axisc_decoder_0_n_0\,
      s_axis_tvalid(1 downto 0) => s_axis_tvalid(1 downto 0),
      s_req_suppress(1 downto 0) => s_req_suppress(1 downto 0),
      valid_i => \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/valid_i\
    );
\gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter\: entity work.axis_switch_0_axis_switch_v1_1_22_axis_switch_arbiter
     port map (
      aclk => aclk,
      arb_gnt_i(1 downto 0) => arb_gnt_i(1 downto 0),
      \arb_gnt_r_reg[0]\ => \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_8\,
      \arb_gnt_r_reg[1]\ => \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_9\,
      \arb_req_i__1\(1 downto 0) => \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/arb_req_i__1\(1 downto 0),
      areset => areset,
      areset_reg_0 => \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_5\,
      aresetn => aresetn,
      \gen_tdest_router.busy_r\(1 downto 0) => \gen_tdest_router.busy_r\(1 downto 0),
      \gen_tdest_routing.busy_ns\ => \gen_tdest_routing.busy_ns_0\,
      \gen_tdest_routing.busy_ns_0\ => \gen_tdest_routing.busy_ns\,
      \gen_tdest_routing.busy_r_reg[0]\ => \gen_decoder[1].axisc_decoder_0_n_0\,
      \gen_tdest_routing.busy_r_reg[0]_0\ => \gen_decoder[0].axisc_decoder_0_n_0\,
      m_axis_tdata(255 downto 0) => m_axis_tdata(255 downto 0),
      m_axis_tready(0) => m_axis_tready(0),
      m_axis_tvalid(0) => m_axis_tvalid(0),
      s_axis_tdata(511 downto 0) => s_axis_tdata(511 downto 0),
      s_axis_tready(1 downto 0) => s_axis_tready(1 downto 0),
      s_axis_tvalid(1 downto 0) => s_axis_tvalid(1 downto 0),
      valid_i => \gen_mi_arb[0].gen_arb_algorithm.gen_round_robin.inst_arb_rr_0/valid_i\
    );
\gen_transfer_mux[0].axisc_transfer_mux_0\: entity work.axis_switch_0_axis_switch_v1_1_22_axisc_transfer_mux
     port map (
      aclk => aclk,
      \busy_r_reg[0]\ => \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_5\,
      \busy_r_reg[0]_0\ => \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_8\,
      \busy_r_reg[1]\ => \gen_int_arbiter.gen_arbiter.axis_switch_v1_1_22_axis_switch_arbiter_n_9\,
      \gen_tdest_router.busy_r\(1 downto 0) => \gen_tdest_router.busy_r\(1 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axis_switch_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    s_req_suppress : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_decode_err : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of axis_switch_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of axis_switch_0 : entity is "axis_switch_0,axis_switch_v1_1_22_axis_switch,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of axis_switch_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of axis_switch_0 : entity is "axis_switch_v1_1_22_axis_switch,Vivado 2020.2";
end axis_switch_0;

architecture STRUCTURE of axis_switch_0 is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_inst_s_axi_ctrl_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_ctrl_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_ctrl_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_ctrl_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_ctrl_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_arb_dest_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_arb_done_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_arb_id_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_arb_last_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_arb_req_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_arb_user_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tkeep_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axis_tlast_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axis_tuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_ctrl_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_s_axi_ctrl_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_s_axi_ctrl_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_s_decode_err_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_ARB_ALGORITHM : integer;
  attribute C_ARB_ALGORITHM of inst : label is 0;
  attribute C_ARB_ON_MAX_XFERS : integer;
  attribute C_ARB_ON_MAX_XFERS of inst : label is 1;
  attribute C_ARB_ON_NUM_CYCLES : integer;
  attribute C_ARB_ON_NUM_CYCLES of inst : label is 0;
  attribute C_ARB_ON_TLAST : integer;
  attribute C_ARB_ON_TLAST of inst : label is 0;
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of inst : label is 3;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of inst : label is 256;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of inst : label is 1;
  attribute C_COMMON_CLOCK : integer;
  attribute C_COMMON_CLOCK of inst : label is 0;
  attribute C_DECODER_REG : integer;
  attribute C_DECODER_REG of inst : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "virtexuplusHBM";
  attribute C_INCLUDE_ARBITER : integer;
  attribute C_INCLUDE_ARBITER of inst : label is 1;
  attribute C_LOG_SI_SLOTS : integer;
  attribute C_LOG_SI_SLOTS of inst : label is 1;
  attribute C_M_AXIS_BASETDEST_ARRAY : string;
  attribute C_M_AXIS_BASETDEST_ARRAY of inst : label is "1'b0";
  attribute C_M_AXIS_CONNECTIVITY_ARRAY : string;
  attribute C_M_AXIS_CONNECTIVITY_ARRAY of inst : label is "2'b11";
  attribute C_M_AXIS_HIGHTDEST_ARRAY : string;
  attribute C_M_AXIS_HIGHTDEST_ARRAY of inst : label is "1'b0";
  attribute C_NUM_MI_SLOTS : integer;
  attribute C_NUM_MI_SLOTS of inst : label is 1;
  attribute C_NUM_SI_SLOTS : integer;
  attribute C_NUM_SI_SLOTS of inst : label is 2;
  attribute C_OUTPUT_REG : integer;
  attribute C_OUTPUT_REG of inst : label is 0;
  attribute C_ROUTING_MODE : integer;
  attribute C_ROUTING_MODE of inst : label is 0;
  attribute C_S_AXI_CTRL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CTRL_ADDR_WIDTH of inst : label is 7;
  attribute C_S_AXI_CTRL_DATA_WIDTH : integer;
  attribute C_S_AXI_CTRL_DATA_WIDTH of inst : label is 32;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute LP_CTRL_REG_WIDTH : integer;
  attribute LP_CTRL_REG_WIDTH of inst : label is 15;
  attribute LP_MERGEDOWN_MUX : integer;
  attribute LP_MERGEDOWN_MUX of inst : label is 0;
  attribute LP_NUM_SYNCHRONIZER_STAGES : integer;
  attribute LP_NUM_SYNCHRONIZER_STAGES of inst : label is 4;
  attribute P_DECODER_CONNECTIVITY_ARRAY : string;
  attribute P_DECODER_CONNECTIVITY_ARRAY of inst : label is "2'b11";
  attribute P_SINGLE_SLAVE_CONNECTIVITY_ARRAY : string;
  attribute P_SINGLE_SLAVE_CONNECTIVITY_ARRAY of inst : label is "1'b0";
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of inst : label is 256;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 CLKIF CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME CLKIF, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 RSTIF RST";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_tdata : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TDATA";
  attribute X_INTERFACE_PARAMETER of m_axis_tdata : signal is "XIL_INTERFACENAME M00_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_tready : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TREADY";
  attribute X_INTERFACE_INFO of m_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TVALID";
  attribute X_INTERFACE_INFO of s_axis_tdata : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TDATA [255:0] [255:0], xilinx.com:interface:axis:1.0 S01_AXIS TDATA [255:0] [511:256]";
  attribute X_INTERFACE_PARAMETER of s_axis_tdata : signal is "XIL_INTERFACENAME S00_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0, XIL_INTERFACENAME S01_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tready : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TREADY [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TREADY [0:0] [1:1]";
  attribute X_INTERFACE_INFO of s_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TVALID [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TVALID [0:0] [1:1]";
begin
  s_decode_err(1) <= \<const0>\;
  s_decode_err(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.axis_switch_0_axis_switch_v1_1_22_axis_switch
     port map (
      aclk => aclk,
      aclken => '1',
      arb_dest(1 downto 0) => NLW_inst_arb_dest_UNCONNECTED(1 downto 0),
      arb_done(0) => NLW_inst_arb_done_UNCONNECTED(0),
      arb_gnt(1 downto 0) => B"00",
      arb_id(1 downto 0) => NLW_inst_arb_id_UNCONNECTED(1 downto 0),
      arb_last(1 downto 0) => NLW_inst_arb_last_UNCONNECTED(1 downto 0),
      arb_req(1 downto 0) => NLW_inst_arb_req_UNCONNECTED(1 downto 0),
      arb_sel(0) => '0',
      arb_user(1 downto 0) => NLW_inst_arb_user_UNCONNECTED(1 downto 0),
      aresetn => aresetn,
      m_axis_tdata(255 downto 0) => m_axis_tdata(255 downto 0),
      m_axis_tdest(0) => NLW_inst_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_inst_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(31 downto 0) => NLW_inst_m_axis_tkeep_UNCONNECTED(31 downto 0),
      m_axis_tlast(0) => NLW_inst_m_axis_tlast_UNCONNECTED(0),
      m_axis_tready(0) => m_axis_tready(0),
      m_axis_tstrb(31 downto 0) => NLW_inst_m_axis_tstrb_UNCONNECTED(31 downto 0),
      m_axis_tuser(0) => NLW_inst_m_axis_tuser_UNCONNECTED(0),
      m_axis_tvalid(0) => m_axis_tvalid(0),
      s_axi_ctrl_aclk => '0',
      s_axi_ctrl_araddr(6 downto 0) => B"0000000",
      s_axi_ctrl_aresetn => '0',
      s_axi_ctrl_arready => NLW_inst_s_axi_ctrl_arready_UNCONNECTED,
      s_axi_ctrl_arvalid => '0',
      s_axi_ctrl_awaddr(6 downto 0) => B"0000000",
      s_axi_ctrl_awready => NLW_inst_s_axi_ctrl_awready_UNCONNECTED,
      s_axi_ctrl_awvalid => '0',
      s_axi_ctrl_bready => '0',
      s_axi_ctrl_bresp(1 downto 0) => NLW_inst_s_axi_ctrl_bresp_UNCONNECTED(1 downto 0),
      s_axi_ctrl_bvalid => NLW_inst_s_axi_ctrl_bvalid_UNCONNECTED,
      s_axi_ctrl_rdata(31 downto 0) => NLW_inst_s_axi_ctrl_rdata_UNCONNECTED(31 downto 0),
      s_axi_ctrl_rready => '0',
      s_axi_ctrl_rresp(1 downto 0) => NLW_inst_s_axi_ctrl_rresp_UNCONNECTED(1 downto 0),
      s_axi_ctrl_rvalid => NLW_inst_s_axi_ctrl_rvalid_UNCONNECTED,
      s_axi_ctrl_wdata(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_ctrl_wready => NLW_inst_s_axi_ctrl_wready_UNCONNECTED,
      s_axi_ctrl_wvalid => '0',
      s_axis_tdata(511 downto 0) => s_axis_tdata(511 downto 0),
      s_axis_tdest(1 downto 0) => B"00",
      s_axis_tid(1 downto 0) => B"00",
      s_axis_tkeep(63 downto 0) => B"1111111111111111111111111111111111111111111111111111111111111111",
      s_axis_tlast(1 downto 0) => B"11",
      s_axis_tready(1 downto 0) => s_axis_tready(1 downto 0),
      s_axis_tstrb(63 downto 0) => B"1111111111111111111111111111111111111111111111111111111111111111",
      s_axis_tuser(1 downto 0) => B"00",
      s_axis_tvalid(1 downto 0) => s_axis_tvalid(1 downto 0),
      s_decode_err(1 downto 0) => NLW_inst_s_decode_err_UNCONNECTED(1 downto 0),
      s_req_suppress(1 downto 0) => s_req_suppress(1 downto 0)
    );
end STRUCTURE;
