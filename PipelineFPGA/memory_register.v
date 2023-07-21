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
// CREATED		"Sat Jun 10 15:06:21 2023"

module memory_register(
	clk,
	reset,
	ALUResult_in,
	PCPlus4_in,
	WAE_in,
	WriteData_in,
	ALUResult_out,
	PCPlus4_out,
	WAE_out,
	WriteData_out
);


input wire	clk;
input wire	reset;
input wire	[31:0] ALUResult_in;
input wire	[31:0] PCPlus4_in;
input wire	[3:0] WAE_in;
input wire	[31:0] WriteData_in;
output wire	[31:0] ALUResult_out;
output wire	[31:0] PCPlus4_out;
output wire	[3:0] WAE_out;
output wire	[31:0] WriteData_out;






Register_simple	b2v_memory_regALUResultE(
	.clk(clk),
	.reset(reset),
	.DATA(ALUResult_in),
	.OUT(ALUResult_out));
	defparam	b2v_memory_regALUResultE.WIDTH = 32;


Register_simple	b2v_memory_regPCPlus4(
	.clk(clk),
	.reset(reset),
	.DATA(PCPlus4_in),
	.OUT(PCPlus4_out));
	defparam	b2v_memory_regPCPlus4.WIDTH = 32;


Register_simple	b2v_memory_regWAEM(
	.clk(clk),
	.reset(reset),
	.DATA(WAE_in),
	.OUT(WAE_out));
	defparam	b2v_memory_regWAEM.WIDTH = 4;


Register_simple	b2v_memory_regWriteDataE(
	.clk(clk),
	.reset(reset),
	.DATA(WriteData_in),
	.OUT(WriteData_out));
	defparam	b2v_memory_regWriteDataE.WIDTH = 32;


endmodule
