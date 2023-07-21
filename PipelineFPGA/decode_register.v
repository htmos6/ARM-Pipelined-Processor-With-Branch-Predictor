// Copyright (C) 2023  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 22.1std.1 Build 917 02/14/2023 SC Lite Edition"
// CREATED		"Sat Jun 10 15:06:07 2023"

module decode_register(
	clk,
	reset,
	stallD,
	flushD,
	Inst_in,
	Inst_out
);


input wire	clk;
input wire	reset;
input wire	stallD;
input wire	flushD;
input wire	[31:0] Inst_in;
output wire	[31:0] Inst_out;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





Register_sync_rw	b2v_inst(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_0),
	.we(SYNTHESIZED_WIRE_1),
	.DATA(Inst_in),
	.OUT(Inst_out));
	defparam	b2v_inst.WIDTH = 32;

assign	SYNTHESIZED_WIRE_1 =  ~stallD;

assign	SYNTHESIZED_WIRE_0 = flushD | reset;


endmodule
