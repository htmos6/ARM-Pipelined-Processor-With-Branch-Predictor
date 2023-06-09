module topmodule (
	input clk, rst,
	output [31:0] PC_out, RD1, RD2,
	output wire [31:0] Inst,
	output REGWr, PCSrcM,
	output [3:0] ALUCnt,
	output [31:0] ALUOutW, ReadDataW,
	output [3:0] CondE,
	output [3:0] ALUFlags_w,
	output [1:0] FlagWriteD,
	output [1:0] FlagWriteE,
	output condEx,
	output [3:0] Flags, 
	output [1:0] FlagWrite,
	output RegSrcW, WriteSrcW,
	output [31:0] PCPlus4W
	);

	

wire [31:0] Instruction;

assign Inst = Instruction;
assign REGWr = RegWriteW;
assign ALUCnt = ALUControlE;

wire ALU_CI;	
wire WriteSrcD, WriteSrcE, WriteSrcM;
//wire WriteSrcW;
wire [1:0] ImmSrcD;
wire [2:0] RegSrc;
wire [1:0] RegSrcD;	
wire [3:0] ALUControlD, ALUControlE;
wire [4:0] shamtD, shamtE;
wire [1:0] shiftControlD, shiftControlE;
wire RegSrcD2;
wire ALU_N, ALU_Z, ALU_CO, ALU_OVF;
wire [3:0] ALUFlags;
//wire [1:0] FlagWriteD; 
//wire [1:0] FlagWriteE; 
wire PCSrcD, BranchD, RegWriteD, MemWriteD, ALUSrcD, MemtoRegD;
wire ALUSrcE, PCSrcE, BranchE, RegWriteE, MemWriteE, MemtoRegE, RegSrcE;
wire RegWriteE_cond, MemWriteE_cond;
wire [3:0] Cond;
//wire [3:0] CondE;
wire RegWriteM, MemWriteM, MemtoRegM, RegSrcM;
wire PCSrcW;
//wire PCSrcM;
wire PCSrcE_cond;
wire RegWriteW, MemtoRegW;
//wire RegSrcW;

assign ALUFlags = {ALU_N, ALU_Z, ALU_CO, ALU_OVF};
assign Cond = Instruction[31:28];
assign RegSrcD = RegSrc[1:0];
assign RegSrcD2 = RegSrc[2];


assign ALUFlags_w = ALUFlags;

datapath datapath(
	.clk(clk),
	.RESET(rst),
	.MemWriteM(MemWriteM),
	.PCSrcW(PCSrcW),
	.ALUSrcE(ALUSrcE),
	.MemtoRegW(MemtoRegW),
	.RegWriteW(RegWriteW),
	.WriteSrcW(WriteSrcW),
	.RegSrcW(RegSrcW),
	.ALU_CI(ALU_CI),
	.ALUControlE(ALUControlE),
	.ImmSrcD(ImmSrcD),
	.RegSrc(RegSrcD),
	.shamt(shamtE),
	.ShiftCont(shiftControlE),
	.ALU_CO(ALU_CO),
	.ALU_OVF(ALU_OVF),
	.ALU_N(ALU_N),
	.ALU_Z(ALU_Z),
	.Instruction(Instruction),
	.PC_out(PC_out), 
	.RD1_out(RD1), 
	.RD2_out(RD2),
	.ALUOutW(ALUOutW),
	.ReadDataW(ReadDataW),
	.PCPlus4W(PCPlus4W));


ConditionalLogic conditionalLogic(
	.Cond(CondE),
	.ALUFlags(ALUFlags),
	.FlagW(FlagWriteE),
	.PCS(PCSrcE), .Branch(BranchE), 		
	.RegW(RegWriteE), .MemW(MemWriteE),
	.clk(clk), .rst(rst),
	.RegWrite(RegWriteE_cond), .MemWrite(MemWriteE_cond),
	.PCWrite(PCSrcE_cond),
	.ALU_CI(ALU_CI),
	.CondEx(condEx),
	.Flags_wire(Flags),
	.FlagWrite_w(FlagWrite));

	
	
Decoder_control decoder_control(
	.Op(Instruction[27:26]), 
	.Funct(Instruction[25:20]), 
	.Rd(Instruction[15:12]),
	.shamt5(Instruction[11:7]),
	.sh(Instruction[6:5]),
	.L(Instruction[24]), 
	.bx_inst(Instruction[27:4]), 
	.FlagW(FlagWriteD),
	.PCSrc(PCSrcD), .RegW(RegWriteD), .MemW(MemWriteD),
	.MemtoReg(MemtoRegD), .ALUSrc(ALUSrcD), .WriteSrc(WriteSrcD),
	.ImmSrc(ImmSrcD),
	.RegSrc(RegSrc),	
	.ALUControl(ALUControlD),
	.shamt(shamtD),
	.shiftControl(shiftControlD),
	.BranchD(BranchD));


// Execute Pipeline Registers

Register_simple #(.WIDTH(1)) execute_PCSrc
    (
	  .clk(clk), .reset(rst),
	  .DATA(PCSrcD),
	  .OUT(PCSrcE)
    );
	 
Register_simple  #(.WIDTH(1)) execute_BranchD
    (
	  .clk(clk), .reset(rst),
	  .DATA(BranchD),
	  .OUT(BranchE)
    );

Register_simple  #(.WIDTH(1)) execute_RegWriteD
    (
	  .clk(clk), .reset(rst),
	  .DATA(RegWriteD),
	  .OUT(RegWriteE)
    );
	 
Register_simple  #(.WIDTH(1)) execute_MemWriteD
    (
	  .clk(clk), .reset(rst),
	  .DATA(MemWriteD),
	  .OUT(MemWriteE)
    );

Register_simple  #(.WIDTH(1)) execute_MemtoRegD
    (
	  .clk(clk), .reset(rst),
	  .DATA(MemtoRegD),
	  .OUT(MemtoRegE)
    );
	 
Register_simple  #(.WIDTH(4)) execute_ALUControlD
    (
	  .clk(clk), .reset(rst),
	  .DATA(ALUControlD),
	  .OUT(ALUControlE)
    );	 
	  
Register_simple  #(.WIDTH(1)) execute_ALUSrcD
    (
	  .clk(clk), .reset(rst),
	  .DATA(ALUSrcD),
	  .OUT(ALUSrcE)
    );	
	 
Register_simple  #(.WIDTH(2)) execute_FlagWriteD
    (
	  .clk(clk), .reset(rst),
	  .DATA(FlagWriteD),
	  .OUT(FlagWriteE)
    );	
	 
Register_simple  #(.WIDTH(4)) execute_Cond  //////////////////////////////////////////////////////////////////////////////////////////////////
    (
	  .clk(clk), .reset(rst),
	  .DATA(Cond),
	  .OUT(CondE)
    ); 
	 
Register_simple  #(.WIDTH(1)) execute_RegSrcD2
    (
	  .clk(clk), .reset(rst),
	  .DATA(RegSrcD2),
	  .OUT(RegSrcE)
    );	 
 

Register_simple  #(.WIDTH(5)) execute_shamtD
    (
	  .clk(clk), .reset(rst),
	  .DATA(shamtD),
	  .OUT(shamtE)
    );	

Register_simple  #(.WIDTH(2)) execute_shiftControlD
    (
	  .clk(clk), .reset(rst),
	  .DATA(shiftControlD),
	  .OUT(shiftControlE)
    );	

Register_simple  #(.WIDTH(1)) execute_WriteSrcD
    (
	  .clk(clk), .reset(rst),
	  .DATA(WriteSrcD),
	  .OUT(WriteSrcE)
    );		 
	 
// Memory Pipeline Registers

Register_simple  #(.WIDTH(1)) memory_PCSrcE_cond
    (
	  .clk(clk), .reset(rst),
	  .DATA(PCSrcE_cond),
	  .OUT(PCSrcM)
    );	

	 
Register_simple  #(.WIDTH(1)) memory_RegWriteE_cond
    (
	  .clk(clk), .reset(rst),
	  .DATA(RegWriteE_cond),
	  .OUT(RegWriteM)
    );	
	 
Register_simple  #(.WIDTH(1)) memory_MemWriteE_cond
    (
	  .clk(clk), .reset(rst),
	  .DATA(MemWriteE_cond),
	  .OUT(MemWriteM)
    );		 
	
Register_simple  #(.WIDTH(1)) memory_MemtoRegE
    (
	  .clk(clk), .reset(rst),
	  .DATA(MemtoRegE),
	  .OUT(MemtoRegM)
    );
	 
	
Register_simple  #(.WIDTH(1)) memory_WriteSrcE
    (
	  .clk(clk), .reset(rst),
	  .DATA(WriteSrcE),
	  .OUT(WriteSrcM)
    );
	 
Register_simple  #(.WIDTH(1)) memory_RegSrcE
    (
	  .clk(clk), .reset(rst),
	  .DATA(RegSrcE),
	  .OUT(RegSrcM)
    );
	
// Write Back Pipeline Registers

Register_simple  #(.WIDTH(1)) writeback_PCSrcM
    (
	  .clk(clk), .reset(rst),
	  .DATA(PCSrcM),
	  .OUT(PCSrcW)
    );
	
Register_simple  #(.WIDTH(1)) writeback_RegWriteM
    (
	  .clk(clk), .reset(rst),
	  .DATA(RegWriteM),
	  .OUT(RegWriteW)
    );
	
Register_simple  #(.WIDTH(1)) writeback_MemtoRegM
    (
	  .clk(clk), .reset(rst),
	  .DATA(MemtoRegM),
	  .OUT(MemtoRegW)
    );	
	 
Register_simple  #(.WIDTH(1)) writeback_WriteSrcM
    (
	  .clk(clk), .reset(rst),
	  .DATA(WriteSrcM),
	  .OUT(WriteSrcW)
    );

Register_simple  #(.WIDTH(1)) writeback_RegSrcM  ////////////////////////////////////////////////////////////////////////////////////////
    (
	  .clk(clk), .reset(rst),
	  .DATA(RegSrcM),
	  .OUT(RegSrcW)
    );
	
endmodule 