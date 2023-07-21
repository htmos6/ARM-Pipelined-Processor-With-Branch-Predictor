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
// CREATED		"Sat Jun 10 15:06:29 2023"

module writeback_register(
	clk,
	reset,
	ALUOut_in,
	PCPlus4_in,
	ReadData_in,
	WA3_in,
	ALUOut_out,
	PCPlus4_out,
	ReadData_out,
	WA3_out
);


input wire	clk;
input wire	reset;
input wire	[31:0] ALUOut_in;
input wire	[31:0] PCPlus4_in;
input wire	[31:0] ReadData_in;
input wire	[3:0] WA3_in;
output wire	[31:0] ALUOut_out;
output wire	[31:0] PCPlus4_out;
output wire	[31:0] ReadData_out;
output wire	[3:0] WA3_out;






Register_simple	b2v_writeback_regALUOutM(
	.clk(clk),
	.reset(reset),
	.DATA(ALUOut_in),
	.OUT(ALUOut_out));
	defparam	b2v_writeback_regALUOutM.WIDTH = 32;


Register_simple	b2v_writeback_regPCPlus4(
	.clk(clk),
	.reset(reset),
	.DATA(PCPlus4_in),
	.OUT(PCPlus4_out));
	defparam	b2v_writeback_regPCPlus4.WIDTH = 32;


Register_simple	b2v_writeback_regReadDataW(
	.clk(clk),
	.reset(reset),
	.DATA(ReadData_in),
	.OUT(ReadData_out));
	defparam	b2v_writeback_regReadDataW.WIDTH = 32;


Register_simple	b2v_writeback_regWA3W(
	.clk(clk),
	.reset(reset),
	.DATA(WA3_in),
	.OUT(WA3_out));
	defparam	b2v_writeback_regWA3W.WIDTH = 4;


endmodule
