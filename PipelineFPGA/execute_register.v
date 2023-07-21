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
// CREATED		"Sat Jun 10 15:05:57 2023"

module execute_register(
	clk,
	reset,
	flushE,
	stallE,
	ExtImm_in,
	PCPlus4_in,
	RD1_in,
	RD2_in,
	WA3_in,
	ExtImm_out,
	PCPlus4_out,
	RD1_out,
	RD2_out,
	WA3_out
);


input wire	clk;
input wire	reset;
input wire	flushE;
input wire	stallE;
input wire	[31:0] ExtImm_in;
input wire	[31:0] PCPlus4_in;
input wire	[31:0] RD1_in;
input wire	[31:0] RD2_in;
input wire	[3:0] WA3_in;
output wire	[31:0] ExtImm_out;
output wire	[31:0] PCPlus4_out;
output wire	[31:0] RD1_out;
output wire	[31:0] RD2_out;
output wire	[3:0] WA3_out;

wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;





Register_sync_rw	b2v_execute_regExtImm(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_10),
	.we(SYNTHESIZED_WIRE_11),
	.DATA(ExtImm_in),
	.OUT(ExtImm_out));
	defparam	b2v_execute_regExtImm.WIDTH = 32;


Register_sync_rw	b2v_execute_regPCPlus4(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_10),
	.we(SYNTHESIZED_WIRE_11),
	.DATA(PCPlus4_in),
	.OUT(PCPlus4_out));
	defparam	b2v_execute_regPCPlus4.WIDTH = 32;


Register_sync_rw	b2v_execute_regRD1(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_10),
	.we(SYNTHESIZED_WIRE_11),
	.DATA(RD1_in),
	.OUT(RD1_out));
	defparam	b2v_execute_regRD1.WIDTH = 32;


Register_sync_rw	b2v_execute_regRD2(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_10),
	.we(SYNTHESIZED_WIRE_11),
	.DATA(RD2_in),
	.OUT(RD2_out));
	defparam	b2v_execute_regRD2.WIDTH = 32;


Register_sync_rw	b2v_execute_regWA3E(
	.clk(clk),
	.reset(SYNTHESIZED_WIRE_10),
	.we(SYNTHESIZED_WIRE_11),
	.DATA(WA3_in),
	.OUT(WA3_out));
	defparam	b2v_execute_regWA3E.WIDTH = 4;

assign	SYNTHESIZED_WIRE_11 =  ~stallE;

assign	SYNTHESIZED_WIRE_10 = flushE | reset;


endmodule
