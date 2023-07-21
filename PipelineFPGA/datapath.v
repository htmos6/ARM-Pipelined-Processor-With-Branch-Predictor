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
// CREATED		"Wed Jun 14 13:16:53 2023"

module datapath(
	clk,
	ALU_CI,
	WriteSrcW,
	RegSrcW,
	RESET,
	MemWriteM,
	RegWriteW,
	ALUSrcE,
	MemtoRegW,
	StallF,
	FlushD,
	StallD,
	FlushE,
	StallE,
	ALUControlE,
	currentBTA,
	ForwardAE,
	ForwardBE,
	ImmSrcD,
	PCSrcSelect,
	RegSrc,
	shamt,
	ShiftCont,
	ALU_CO,
	ALU_OVF,
	ALU_N,
	ALU_Z,
	ALU_Result_M,
	ALUResultE,
	Instruction,
	PC_out,
	PCPlus4E,
	PCPlus4W,
	RA1D,
	RA2D,
	RD1_out,
	RD2_out,
	ReadDataW,
	WA3E,
	WA3M,
	WA3W
);


input wire	clk;
input wire	ALU_CI;
input wire	WriteSrcW;
input wire	RegSrcW;
input wire	RESET;
input wire	MemWriteM;
input wire	RegWriteW;
input wire	ALUSrcE;
input wire	MemtoRegW;
input wire	StallF;
input wire	FlushD;
input wire	StallD;
input wire	FlushE;
input wire	StallE;
input wire	[3:0] ALUControlE;
input wire	[31:0] currentBTA;
input wire	[1:0] ForwardAE;
input wire	[1:0] ForwardBE;
input wire	[1:0] ImmSrcD;
input wire	[1:0] PCSrcSelect;
input wire	[1:0] RegSrc;
input wire	[4:0] shamt;
input wire	[1:0] ShiftCont;
output wire	ALU_CO;
output wire	ALU_OVF;
output wire	ALU_N;
output wire	ALU_Z;
output wire	[31:0] ALU_Result_M;
output wire	[31:0] ALUResultE;
output wire	[31:0] Instruction;
output wire	[31:0] PC_out;
output wire	[31:0] PCPlus4E;
output wire	[31:0] PCPlus4W;
output wire	[3:0] RA1D;
output wire	[3:0] RA2D;
output wire	[31:0] RD1_out;
output wire	[31:0] RD2_out;
output wire	[31:0] ReadDataW;
output wire	[3:0] WA3E;
output wire	[3:0] WA3M;
output wire	[3:0] WA3W;

wire	[31:0] Instr;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_48;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_49;
wire	[31:0] SYNTHESIZED_WIRE_50;
wire	[31:0] SYNTHESIZED_WIRE_51;
wire	SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;
wire	[3:0] SYNTHESIZED_WIRE_12;
wire	[31:0] SYNTHESIZED_WIRE_52;
wire	[3:0] SYNTHESIZED_WIRE_14;
wire	[3:0] SYNTHESIZED_WIRE_15;
wire	[31:0] SYNTHESIZED_WIRE_53;
wire	[31:0] SYNTHESIZED_WIRE_54;
wire	[31:0] SYNTHESIZED_WIRE_21;
wire	[31:0] SYNTHESIZED_WIRE_22;
wire	[31:0] SYNTHESIZED_WIRE_23;
wire	[31:0] SYNTHESIZED_WIRE_24;
wire	[31:0] SYNTHESIZED_WIRE_25;
wire	[31:0] SYNTHESIZED_WIRE_26;
wire	[31:0] SYNTHESIZED_WIRE_31;
wire	[31:0] SYNTHESIZED_WIRE_32;
wire	[31:0] SYNTHESIZED_WIRE_33;
wire	[3:0] SYNTHESIZED_WIRE_34;
wire	[3:0] SYNTHESIZED_WIRE_36;
wire	[3:0] SYNTHESIZED_WIRE_37;
wire	[31:0] SYNTHESIZED_WIRE_39;
wire	[3:0] SYNTHESIZED_WIRE_40;
wire	[31:0] SYNTHESIZED_WIRE_43;
wire	[31:0] SYNTHESIZED_WIRE_45;
wire	[31:0] SYNTHESIZED_WIRE_46;
wire	[3:0] SYNTHESIZED_WIRE_47;

assign	ALU_Result_M = SYNTHESIZED_WIRE_51;
assign	ALUResultE = SYNTHESIZED_WIRE_54;
assign	PC_out = SYNTHESIZED_WIRE_48;
assign	PCPlus4E = SYNTHESIZED_WIRE_39;
assign	PCPlus4W = SYNTHESIZED_WIRE_53;
assign	RA1D = SYNTHESIZED_WIRE_14;
assign	RA2D = SYNTHESIZED_WIRE_15;
assign	RD1_out = SYNTHESIZED_WIRE_26;
assign	RD2_out = SYNTHESIZED_WIRE_49;
assign	ReadDataW = SYNTHESIZED_WIRE_33;
assign	WA3E = SYNTHESIZED_WIRE_40;
assign	WA3M = SYNTHESIZED_WIRE_47;
assign	WA3W = SYNTHESIZED_WIRE_36;




decode_register	b2v_decode(
	.clk(clk),
	.reset(RESET),
	.flushD(FlushD),
	.stallD(StallD),
	.Inst_in(SYNTHESIZED_WIRE_0),
	.Inst_out(Instr));


execute_register	b2v_execute(
	.clk(clk),
	.reset(RESET),
	.flushE(FlushE),
	.stallE(StallE),
	.ExtImm_in(SYNTHESIZED_WIRE_1),
	.PCPlus4_in(SYNTHESIZED_WIRE_48),
	.RD1_in(SYNTHESIZED_WIRE_3),
	.RD2_in(SYNTHESIZED_WIRE_4),
	.WA3_in(Instr[15:12]),
	.ExtImm_out(SYNTHESIZED_WIRE_22),
	.PCPlus4_out(SYNTHESIZED_WIRE_39),
	.RD1_out(SYNTHESIZED_WIRE_26),
	.RD2_out(SYNTHESIZED_WIRE_49),
	.WA3_out(SYNTHESIZED_WIRE_40));


fetch_register	b2v_fetch(
	.clk(clk),
	.reset(RESET),
	.stallF(StallF),
	.PC_in(SYNTHESIZED_WIRE_5),
	.PC_out(SYNTHESIZED_WIRE_48));


Mux_4to1	b2v_inst(
	.input_0(SYNTHESIZED_WIRE_49),
	.input_1(SYNTHESIZED_WIRE_50),
	.input_2(SYNTHESIZED_WIRE_51),
	.input_3(SYNTHESIZED_WIRE_51),
	.select(ForwardBE),
	.output_value(SYNTHESIZED_WIRE_21));
	defparam	b2v_inst.WIDTH = 32;


Register_file	b2v_inst1(
	.clk(SYNTHESIZED_WIRE_10),
	.write_enable(RegWriteW),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_11),
	.Destination_select(SYNTHESIZED_WIRE_12),
	.Reg_15(SYNTHESIZED_WIRE_52),
	.Source_select_0(SYNTHESIZED_WIRE_14),
	.Source_select_1(SYNTHESIZED_WIRE_15),
	.out_0(SYNTHESIZED_WIRE_3),
	.out_1(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst1.WIDTH = 32;


ConstGen	b2v_inst10(
	.out(SYNTHESIZED_WIRE_43));
	defparam	b2v_inst10.value = 4;
	defparam	b2v_inst10.W = 32;


Mux_2to1	b2v_inst11(
	.select(WriteSrcW),
	.input_0(SYNTHESIZED_WIRE_50),
	.input_1(SYNTHESIZED_WIRE_53),
	.output_value(SYNTHESIZED_WIRE_11));
	defparam	b2v_inst11.WIDTH = 32;


Mux_4to1	b2v_inst12(
	.input_0(SYNTHESIZED_WIRE_52),
	.input_1(SYNTHESIZED_WIRE_54),
	.input_2(currentBTA),
	.input_3(SYNTHESIZED_WIRE_53),
	.select(PCSrcSelect),
	.output_value(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst12.WIDTH = 32;


Mux_2to1	b2v_inst13(
	.select(ALUSrcE),
	.input_0(SYNTHESIZED_WIRE_21),
	.input_1(SYNTHESIZED_WIRE_22),
	.output_value(SYNTHESIZED_WIRE_23));
	defparam	b2v_inst13.WIDTH = 32;


shifter	b2v_inst14(
	.control(ShiftCont),
	.DATA(SYNTHESIZED_WIRE_23),
	.shamt(shamt),
	.OUT(SYNTHESIZED_WIRE_25));
	defparam	b2v_inst14.WIDTH = 32;


ALU	b2v_inst15(
	.CI(ALU_CI),
	.control(ALUControlE),
	.DATA_A(SYNTHESIZED_WIRE_24),
	.DATA_B(SYNTHESIZED_WIRE_25),
	.CO(ALU_CO),
	.OVF(ALU_OVF),
	.N(ALU_N),
	.Z(ALU_Z),
	.OUT(SYNTHESIZED_WIRE_54));
	defparam	b2v_inst15.WIDTH = 32;


Mux_4to1	b2v_inst16(
	.input_0(SYNTHESIZED_WIRE_26),
	.input_1(SYNTHESIZED_WIRE_50),
	.input_2(SYNTHESIZED_WIRE_51),
	.input_3(SYNTHESIZED_WIRE_51),
	.select(ForwardAE),
	.output_value(SYNTHESIZED_WIRE_24));
	defparam	b2v_inst16.WIDTH = 32;


Memory	b2v_inst17(
	.clk(clk),
	.WE(MemWriteM),
	.ADDR(SYNTHESIZED_WIRE_51),
	.WD(SYNTHESIZED_WIRE_31),
	.RD(SYNTHESIZED_WIRE_46));
	defparam	b2v_inst17.ADDR_WIDTH = 32;
	defparam	b2v_inst17.BYTE_SIZE = 4;


Mux_2to1	b2v_inst18(
	.select(MemtoRegW),
	.input_0(SYNTHESIZED_WIRE_32),
	.input_1(SYNTHESIZED_WIRE_33),
	.output_value(SYNTHESIZED_WIRE_50));
	defparam	b2v_inst18.WIDTH = 32;


Mux_2to1	b2v_inst2(
	.select(RegSrc[0]),
	.input_0(Instr[19:16]),
	.input_1(SYNTHESIZED_WIRE_34),
	.output_value(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst2.WIDTH = 4;


ConstGen	b2v_inst3(
	.out(SYNTHESIZED_WIRE_34));
	defparam	b2v_inst3.value = 15;
	defparam	b2v_inst3.W = 4;


Mux_2to1	b2v_inst4(
	.select(RegSrc[1]),
	.input_0(Instr[3:0]),
	.input_1(Instr[15:12]),
	.output_value(SYNTHESIZED_WIRE_15));
	defparam	b2v_inst4.WIDTH = 4;


Instruction_memory	b2v_inst5(
	.ADDR(SYNTHESIZED_WIRE_48),
	.RD(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst5.ADDR_WIDTH = 32;
	defparam	b2v_inst5.BYTE_SIZE = 4;


Mux_2to1	b2v_inst6(
	.select(RegSrcW),
	.input_0(SYNTHESIZED_WIRE_36),
	.input_1(SYNTHESIZED_WIRE_37),
	.output_value(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst6.WIDTH = 4;


ConstGen	b2v_inst7(
	.out(SYNTHESIZED_WIRE_37));
	defparam	b2v_inst7.value = 14;
	defparam	b2v_inst7.W = 4;


Extender	b2v_inst8(
	.A(Instr[23:0]),
	.select(ImmSrcD),
	.Q(SYNTHESIZED_WIRE_1));

assign	SYNTHESIZED_WIRE_10 =  ~clk;


memory_register	b2v_memory(
	.clk(clk),
	.reset(RESET),
	.ALUResult_in(SYNTHESIZED_WIRE_54),
	.PCPlus4_in(SYNTHESIZED_WIRE_39),
	.WAE_in(SYNTHESIZED_WIRE_40),
	.WriteData_in(SYNTHESIZED_WIRE_49),
	.ALUResult_out(SYNTHESIZED_WIRE_51),
	.PCPlus4_out(SYNTHESIZED_WIRE_45),
	.WAE_out(SYNTHESIZED_WIRE_47),
	.WriteData_out(SYNTHESIZED_WIRE_31));


Adder	b2v_PCPlus4(
	.DATA_A(SYNTHESIZED_WIRE_48),
	.DATA_B(SYNTHESIZED_WIRE_43),
	.OUT(SYNTHESIZED_WIRE_52));
	defparam	b2v_PCPlus4.WIDTH = 32;


writeback_register	b2v_writeback(
	.clk(clk),
	.reset(RESET),
	.ALUOut_in(SYNTHESIZED_WIRE_51),
	.PCPlus4_in(SYNTHESIZED_WIRE_45),
	.ReadData_in(SYNTHESIZED_WIRE_46),
	.WA3_in(SYNTHESIZED_WIRE_47),
	.ALUOut_out(SYNTHESIZED_WIRE_32),
	.PCPlus4_out(SYNTHESIZED_WIRE_53),
	.ReadData_out(SYNTHESIZED_WIRE_33),
	.WA3_out(SYNTHESIZED_WIRE_36));

assign	Instruction = Instr;

endmodule
