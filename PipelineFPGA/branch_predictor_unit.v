// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Wed Jun 14 22:00:15 2023"

module branch_predictor_unit(
	clk,
	reset,
	BranchE,
	BranchPredictedE,
	BranchTakenE,
	ALUBranchAddressPlus4,
	ALUResultE,
	currentPC,
	BranchPredicted,
	hit,
	branchPredictionResult,
	currentBTA
);


input wire	clk;
input wire	reset;
input wire	BranchE;
input wire	BranchPredictedE;
input wire	BranchTakenE;
input wire	[31:0] ALUBranchAddressPlus4;
input wire	[31:0] ALUResultE;
input wire	[31:0] currentPC;
output wire	BranchPredicted;
output wire	hit;
output wire	branchPredictionResult;
output wire	[31:0] currentBTA;

wire	[31:0] pc;
wire	[2:0] SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;

assign	hit = SYNTHESIZED_WIRE_2;
assign	branchPredictionResult = SYNTHESIZED_WIRE_1;




BTB	b2v_inst(
	.clk(clk),
	.reset(reset),
	.aluBranchAddress(ALUResultE),
	.branchPredictedE(BranchPredictedE),
	.branchTakenE(BranchTakenE),
	.pc(pc[7:0]),
	.pcOfAluBranchAddress(ALUBranchAddressPlus4),
	.hit(SYNTHESIZED_WIRE_2),
	.BTA(currentBTA));
	defparam	b2v_inst.W_BTA = 32;
	defparam	b2v_inst.W_PC = 8;


GHR	b2v_inst1(
	.clk(clk),
	.shift(BranchE),
	.reset(reset),
	.inp(BranchTakenE),
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst1.W = 3;


PHT	b2v_inst2(
	.clk(clk),
	.reset(reset),
	.branchPredictedE(BranchPredictedE),
	.branchTakenE(BranchTakenE),
	.PHTinpId(SYNTHESIZED_WIRE_0),
	.branchPredictionResult(SYNTHESIZED_WIRE_1));

assign	BranchPredicted = SYNTHESIZED_WIRE_1 & SYNTHESIZED_WIRE_2;

assign	pc = currentPC;

endmodule
