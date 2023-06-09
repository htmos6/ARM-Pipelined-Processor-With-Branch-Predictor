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
// CREATED		"Thu Jun  8 22:19:24 2023"

module datapath(
	clk,
	ALU_CI,
	PCSrcW,
	WriteSrcW,
	RegSrcW,
	RESET,
	MemWriteM,
	RegWriteW,
	ALUSrcE,
	MemtoRegW,
	ALUControlE,
	ImmSrcD,
	RegSrc,
	shamt,
	ShiftCont,
	ALU_CO,
	ALU_OVF,
	ALU_N,
	ALU_Z,
	ALUOutW,
	Instruction,
	PC_out,
	PCPlus4W,
	RD1_out,
	RD2_out,
	ReadDataW
);


input wire	clk;
input wire	ALU_CI;
input wire	PCSrcW;
input wire	WriteSrcW;
input wire	RegSrcW;
input wire	RESET;
input wire	MemWriteM;
input wire	RegWriteW;
input wire	ALUSrcE;
input wire	MemtoRegW;
input wire	[3:0] ALUControlE;
input wire	[1:0] ImmSrcD;
input wire	[1:0] RegSrc;
input wire	[4:0] shamt;
input wire	[1:0] ShiftCont;
output wire	ALU_CO;
output wire	ALU_OVF;
output wire	ALU_N;
output wire	ALU_Z;
output wire	[31:0] ALUOutW;
output wire	[31:0] Instruction;
output wire	[31:0] PC_out;
output wire	[31:0] PCPlus4W;
output wire	[31:0] RD1_out;
output wire	[31:0] RD2_out;
output wire	[31:0] ReadDataW;

wire	[31:0] Instr;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_39;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_40;
wire	[31:0] SYNTHESIZED_WIRE_41;
wire	SYNTHESIZED_WIRE_8;
wire	[31:0] SYNTHESIZED_WIRE_9;
wire	[3:0] SYNTHESIZED_WIRE_10;
wire	[3:0] SYNTHESIZED_WIRE_12;
wire	[3:0] SYNTHESIZED_WIRE_13;
wire	[31:0] SYNTHESIZED_WIRE_15;
wire	[31:0] SYNTHESIZED_WIRE_42;
wire	[31:0] SYNTHESIZED_WIRE_17;
wire	[31:0] SYNTHESIZED_WIRE_18;
wire	[31:0] SYNTHESIZED_WIRE_19;
wire	[31:0] SYNTHESIZED_WIRE_20;
wire	[31:0] SYNTHESIZED_WIRE_43;
wire	[31:0] SYNTHESIZED_WIRE_22;
wire	[31:0] SYNTHESIZED_WIRE_23;
wire	[31:0] SYNTHESIZED_WIRE_24;
wire	[3:0] SYNTHESIZED_WIRE_25;
wire	[3:0] SYNTHESIZED_WIRE_27;
wire	[3:0] SYNTHESIZED_WIRE_28;
wire	[31:0] SYNTHESIZED_WIRE_29;
wire	[31:0] SYNTHESIZED_WIRE_30;
wire	[3:0] SYNTHESIZED_WIRE_31;
wire	[31:0] SYNTHESIZED_WIRE_34;
wire	[31:0] SYNTHESIZED_WIRE_36;
wire	[31:0] SYNTHESIZED_WIRE_37;
wire	[3:0] SYNTHESIZED_WIRE_38;

assign	ALUOutW = SYNTHESIZED_WIRE_23;
assign	PC_out = SYNTHESIZED_WIRE_39;
assign	PCPlus4W = SYNTHESIZED_WIRE_15;
assign	RD1_out = SYNTHESIZED_WIRE_19;
assign	RD2_out = SYNTHESIZED_WIRE_42;
assign	ReadDataW = SYNTHESIZED_WIRE_24;




Register_simple	b2v_decode_regInst(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_0),
	.OUT(Instr));
	defparam	b2v_decode_regInst.WIDTH = 32;


Register_simple	b2v_execute_regExtImm(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_1),
	.OUT(SYNTHESIZED_WIRE_17));
	defparam	b2v_execute_regExtImm.WIDTH = 32;


Register_simple	b2v_execute_regPCPlus4(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_39),
	.OUT(SYNTHESIZED_WIRE_30));
	defparam	b2v_execute_regPCPlus4.WIDTH = 32;


Register_simple	b2v_execute_regRD1(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_3),
	.OUT(SYNTHESIZED_WIRE_19));
	defparam	b2v_execute_regRD1.WIDTH = 32;


Register_simple	b2v_execute_regRD2(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_4),
	.OUT(SYNTHESIZED_WIRE_42));
	defparam	b2v_execute_regRD2.WIDTH = 32;


Register_simple	b2v_execute_regWA3E(
	.clk(clk),
	.reset(RESET),
	.DATA(Instr[15:12]),
	.OUT(SYNTHESIZED_WIRE_31));
	defparam	b2v_execute_regWA3E.WIDTH = 4;


Register_simple	b2v_FetchReg(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_5),
	.OUT(SYNTHESIZED_WIRE_39));
	defparam	b2v_FetchReg.WIDTH = 32;


Mux_2to1	b2v_inst(
	.select(PCSrcW),
	.input_0(SYNTHESIZED_WIRE_40),
	.input_1(SYNTHESIZED_WIRE_41),
	.output_value(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst.WIDTH = 32;


Register_file	b2v_inst1(
	.clk(SYNTHESIZED_WIRE_8),
	.write_enable(RegWriteW),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_9),
	.Destination_select(SYNTHESIZED_WIRE_10),
	.Reg_15(SYNTHESIZED_WIRE_40),
	.Source_select_0(SYNTHESIZED_WIRE_12),
	.Source_select_1(SYNTHESIZED_WIRE_13),
	.out_0(SYNTHESIZED_WIRE_3),
	.out_1(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst1.WIDTH = 32;


ConstGen	b2v_inst10(
	.out(SYNTHESIZED_WIRE_34));
	defparam	b2v_inst10.value = 4;
	defparam	b2v_inst10.W = 32;


Mux_2to1	b2v_inst11(
	.select(WriteSrcW),
	.input_0(SYNTHESIZED_WIRE_41),
	.input_1(SYNTHESIZED_WIRE_15),
	.output_value(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst11.WIDTH = 32;


Mux_2to1	b2v_inst13(
	.select(ALUSrcE),
	.input_0(SYNTHESIZED_WIRE_42),
	.input_1(SYNTHESIZED_WIRE_17),
	.output_value(SYNTHESIZED_WIRE_18));
	defparam	b2v_inst13.WIDTH = 32;


shifter	b2v_inst14(
	.control(ShiftCont),
	.DATA(SYNTHESIZED_WIRE_18),
	.shamt(shamt),
	.OUT(SYNTHESIZED_WIRE_20));
	defparam	b2v_inst14.WIDTH = 32;


ALU	b2v_inst15(
	.CI(ALU_CI),
	.control(ALUControlE),
	.DATA_A(SYNTHESIZED_WIRE_19),
	.DATA_B(SYNTHESIZED_WIRE_20),
	.CO(ALU_CO),
	.OVF(ALU_OVF),
	.N(ALU_N),
	.Z(ALU_Z),
	.OUT(SYNTHESIZED_WIRE_29));
	defparam	b2v_inst15.WIDTH = 32;


Memory	b2v_inst17(
	.clk(clk),
	.WE(MemWriteM),
	.ADDR(SYNTHESIZED_WIRE_43),
	.WD(SYNTHESIZED_WIRE_22),
	.RD(SYNTHESIZED_WIRE_37));
	defparam	b2v_inst17.ADDR_WIDTH = 32;
	defparam	b2v_inst17.BYTE_SIZE = 4;


Mux_2to1	b2v_inst18(
	.select(MemtoRegW),
	.input_0(SYNTHESIZED_WIRE_23),
	.input_1(SYNTHESIZED_WIRE_24),
	.output_value(SYNTHESIZED_WIRE_41));
	defparam	b2v_inst18.WIDTH = 32;


Mux_2to1	b2v_inst2(
	.select(RegSrc[0]),
	.input_0(Instr[19:16]),
	.input_1(SYNTHESIZED_WIRE_25),
	.output_value(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst2.WIDTH = 4;


ConstGen	b2v_inst3(
	.out(SYNTHESIZED_WIRE_25));
	defparam	b2v_inst3.value = 15;
	defparam	b2v_inst3.W = 4;


Mux_2to1	b2v_inst4(
	.select(RegSrc[1]),
	.input_0(Instr[3:0]),
	.input_1(Instr[15:12]),
	.output_value(SYNTHESIZED_WIRE_13));
	defparam	b2v_inst4.WIDTH = 4;


Instruction_memory	b2v_inst5(
	.ADDR(SYNTHESIZED_WIRE_39),
	.RD(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst5.ADDR_WIDTH = 32;
	defparam	b2v_inst5.BYTE_SIZE = 4;


Mux_2to1	b2v_inst6(
	.select(RegSrcW),
	.input_0(SYNTHESIZED_WIRE_27),
	.input_1(SYNTHESIZED_WIRE_28),
	.output_value(SYNTHESIZED_WIRE_10));
	defparam	b2v_inst6.WIDTH = 4;


ConstGen	b2v_inst7(
	.out(SYNTHESIZED_WIRE_28));
	defparam	b2v_inst7.value = 14;
	defparam	b2v_inst7.W = 4;


Extender	b2v_inst8(
	.A(Instr[23:0]),
	.select(ImmSrcD),
	.Q(SYNTHESIZED_WIRE_1));

assign	SYNTHESIZED_WIRE_8 =  ~clk;


Register_simple	b2v_memory_regALUResultE(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_29),
	.OUT(SYNTHESIZED_WIRE_43));
	defparam	b2v_memory_regALUResultE.WIDTH = 32;


Register_simple	b2v_memory_regPCPlus4(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_30),
	.OUT(SYNTHESIZED_WIRE_36));
	defparam	b2v_memory_regPCPlus4.WIDTH = 32;


Register_simple	b2v_memory_regWAEM(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_31),
	.OUT(SYNTHESIZED_WIRE_38));
	defparam	b2v_memory_regWAEM.WIDTH = 4;


Register_simple	b2v_memory_regWriteDataE(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_42),
	.OUT(SYNTHESIZED_WIRE_22));
	defparam	b2v_memory_regWriteDataE.WIDTH = 32;


Adder	b2v_PCPlus4(
	.DATA_A(SYNTHESIZED_WIRE_39),
	.DATA_B(SYNTHESIZED_WIRE_34),
	.OUT(SYNTHESIZED_WIRE_40));
	defparam	b2v_PCPlus4.WIDTH = 32;


Register_simple	b2v_writeback_regALUOutM(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_43),
	.OUT(SYNTHESIZED_WIRE_23));
	defparam	b2v_writeback_regALUOutM.WIDTH = 32;


Register_simple	b2v_writeback_regPCPlus4(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_36),
	.OUT(SYNTHESIZED_WIRE_15));
	defparam	b2v_writeback_regPCPlus4.WIDTH = 32;


Register_simple	b2v_writeback_regReadDataW(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_37),
	.OUT(SYNTHESIZED_WIRE_24));
	defparam	b2v_writeback_regReadDataW.WIDTH = 32;


Register_simple	b2v_writeback_regWA3W(
	.clk(clk),
	.reset(RESET),
	.DATA(SYNTHESIZED_WIRE_38),
	.OUT(SYNTHESIZED_WIRE_27));
	defparam	b2v_writeback_regWA3W.WIDTH = 4;

assign	Instruction = Instr;

endmodule
