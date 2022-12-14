# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "S_AXIS_H2C_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IN_FIFO_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_FIFO_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IN_FIFO_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_FIFO_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IN_FIFO_DATA_COUNT_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_FIFO_DATA_COUNT_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH { PARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to update IN_FIFO_DATA_COUNT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH { PARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to validate IN_FIFO_DATA_COUNT_WIDTH
	return true
}

proc update_PARAM_VALUE.IN_FIFO_DATA_WIDTH { PARAM_VALUE.IN_FIFO_DATA_WIDTH } {
	# Procedure called to update IN_FIFO_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN_FIFO_DATA_WIDTH { PARAM_VALUE.IN_FIFO_DATA_WIDTH } {
	# Procedure called to validate IN_FIFO_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.IN_FIFO_DEPTH { PARAM_VALUE.IN_FIFO_DEPTH } {
	# Procedure called to update IN_FIFO_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN_FIFO_DEPTH { PARAM_VALUE.IN_FIFO_DEPTH } {
	# Procedure called to validate IN_FIFO_DEPTH
	return true
}

proc update_PARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH { PARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to update OUT_FIFO_DATA_COUNT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH { PARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to validate OUT_FIFO_DATA_COUNT_WIDTH
	return true
}

proc update_PARAM_VALUE.OUT_FIFO_DATA_WIDTH { PARAM_VALUE.OUT_FIFO_DATA_WIDTH } {
	# Procedure called to update OUT_FIFO_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_FIFO_DATA_WIDTH { PARAM_VALUE.OUT_FIFO_DATA_WIDTH } {
	# Procedure called to validate OUT_FIFO_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.OUT_FIFO_DEPTH { PARAM_VALUE.OUT_FIFO_DEPTH } {
	# Procedure called to update OUT_FIFO_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_FIFO_DEPTH { PARAM_VALUE.OUT_FIFO_DEPTH } {
	# Procedure called to validate OUT_FIFO_DEPTH
	return true
}

proc update_PARAM_VALUE.S_AXIS_H2C_DATA_WIDTH { PARAM_VALUE.S_AXIS_H2C_DATA_WIDTH } {
	# Procedure called to update S_AXIS_H2C_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.S_AXIS_H2C_DATA_WIDTH { PARAM_VALUE.S_AXIS_H2C_DATA_WIDTH } {
	# Procedure called to validate S_AXIS_H2C_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.S_AXIS_H2C_DATA_WIDTH { MODELPARAM_VALUE.S_AXIS_H2C_DATA_WIDTH PARAM_VALUE.S_AXIS_H2C_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.S_AXIS_H2C_DATA_WIDTH}] ${MODELPARAM_VALUE.S_AXIS_H2C_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.IN_FIFO_DEPTH { MODELPARAM_VALUE.IN_FIFO_DEPTH PARAM_VALUE.IN_FIFO_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN_FIFO_DEPTH}] ${MODELPARAM_VALUE.IN_FIFO_DEPTH}
}

proc update_MODELPARAM_VALUE.OUT_FIFO_DEPTH { MODELPARAM_VALUE.OUT_FIFO_DEPTH PARAM_VALUE.OUT_FIFO_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_FIFO_DEPTH}] ${MODELPARAM_VALUE.OUT_FIFO_DEPTH}
}

proc update_MODELPARAM_VALUE.IN_FIFO_DATA_WIDTH { MODELPARAM_VALUE.IN_FIFO_DATA_WIDTH PARAM_VALUE.IN_FIFO_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN_FIFO_DATA_WIDTH}] ${MODELPARAM_VALUE.IN_FIFO_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.OUT_FIFO_DATA_WIDTH { MODELPARAM_VALUE.OUT_FIFO_DATA_WIDTH PARAM_VALUE.OUT_FIFO_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_FIFO_DATA_WIDTH}] ${MODELPARAM_VALUE.OUT_FIFO_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH { MODELPARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH PARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH}] ${MODELPARAM_VALUE.IN_FIFO_DATA_COUNT_WIDTH}
}

proc update_MODELPARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH { MODELPARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH PARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH}] ${MODELPARAM_VALUE.OUT_FIFO_DATA_COUNT_WIDTH}
}

