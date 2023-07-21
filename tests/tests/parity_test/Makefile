# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog


VERILOG_SOURCES += $(PWD)/../../hdl/*.v



# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = topmodule


# MODULE is the basename of the Python test file
MODULE := parity_test
COCOTB_HDL_TIMEUNIT=1us
COCOTB_HDL_TIMEPRECISION=1us

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
