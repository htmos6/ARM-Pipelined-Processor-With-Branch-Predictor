module topmodule (
	input clk, rst, reset_bp,
	output [31:0] PC_out, RD1, RD2,
	output wire [31:0] Inst, currentBTA, ALUBranchAddressPlus4,
	output condEx,
	output [3:0] Flags, 
	output [1:0] FlagWrite,
	output [1:0] ForwardAE_o, ForwardBE_o,
	output StallF_o, FlushD_o, StallD_o, FlushE_o, StallE_o,
	output [1:0] PCSrcSelect,
	output BranchE, BranchPredictedE, BranchPredicted, hit, branchPredictionResult, BranchTakenE
	);
	

wire [31:0] Instruction;
wire [31:0] ALU_Result_M, ReadDataW, PCPlus4W;
assign Inst = Instruction;
//assign REGWr = RegWriteW;
//assign ALUCnt = ALUControlE;
//assign ALUFlags_w = ALUFlags;
assign StallF_o = StallF;
assign FlushD_o = FlushD;
assign StallD_o = StallD;
assign FlushE_o = FlushE;
assign StallE_o = StallE;
assign ForwardAE_o = ForwardAE;
assign ForwardBE_o = ForwardBE;

wire ALU_CI;	
wire WriteSrcD, WriteSrcE, WriteSrcM;
wire WriteSrcW;
wire [1:0] ImmSrcD;
wire [2:0] RegSrc;
wire [1:0] RegSrcD;	
wire [3:0] ALUControlD, ALUControlE;
wire [4:0] shamtD, shamtE;
wire [1:0] shiftControlD, shiftControlE;
wire RegSrcD2;
wire ALU_N, ALU_Z, ALU_CO, ALU_OVF;
wire [3:0] ALUFlags;
wire [1:0] FlagWriteD; 
wire [1:0] FlagWriteE; 
wire BranchD, RegWriteD, MemWriteD, ALUSrcD, MemtoRegD;
wire ALUSrcE, RegWriteE, MemWriteE, MemtoRegE, RegSrcE;
wire RegWriteE_cond, MemWriteE_cond;
wire [3:0] Cond;
wire [3:0] CondE;
wire RegWriteM, MemWriteM, MemtoRegM, RegSrcM;
//wire [1:0] PCSrcSelect;    
//wire BranchE, BranchPredictedE, BranchPredicted, BranchTakenE;
wire PCSrcE_cond, PCSrcE, PCSrcD, PCSrcM;
wire RegWriteW, MemtoRegW;
wire RegSrcW;

wire StallF, FlushD, StallD, FlushE, StallE;
wire BranchPredictedD;
wire [31:0] ALUResultE, currentPC;
//wire [31:0] currentBTA;
wire [1:0] ForwardAE, ForwardBE;
wire RA1E_valid, RA2E_valid, WA3M_valid, WA3W_valid;
wire [3:0] RA1E, RA2E, WA3M, WA3W, RA1D, RA2D, WA3E;
wire RA1D_valid, RA2D_valid, WA3D_valid, WA3E_valid;
wire rstD, rstE;
wire [31:0] PCPlus4E;
//wire [31:0] ALUBranchAddressPlus4;
assign rstD = rst | FlushD;
assign rstE = rst | FlushE;
assign StallE = 1'b0;

assign ALUFlags = {ALU_N, ALU_Z, ALU_CO, ALU_OVF};
assign Cond = Instruction[31:28];
assign RegSrcD = RegSrc[1:0];
assign RegSrcD2 = RegSrc[2];

assign ALUBranchAddressPlus4 = PCPlus4E;



HazardUnit hazardUnit(
	.RA1E(RA1E), .RA2E(RA2E), .WA3M(WA3M), .WA3W(WA3W), .RA1D(RA1D), .RA2D(RA2D), .WA3E(WA3E),
	.RA1E_valid(RA1E_valid), .RA2E_valid(RA2E_valid), .WA3M_valid(WA3M_valid), .WA3W_valid(WA3W_valid),
	.RA1D_valid(RA1D_valid), .RA2D_valid(RA2D_valid), .WA3E_valid(WA3E_valid),
	.ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
	.StallF(StallF), .StallD(StallD), .FlushD(FlushD), .FlushE(FlushE),
	.RegWriteM(RegWriteM), .RegWriteW(RegWriteW), .MemtoRegE(MemtoRegE), .BranchTakenE(BranchTakenE),
	.BranchPredictedE(BranchPredictedE), .PCWrTakenE(PCSrcE_cond));


datapath datapath(
	.clk(clk),
	.RESET(rst),
	.MemWriteM(MemWriteM),
	.PCSrcSelect(PCSrcSelect),
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
	.ALU_Result_M(ALU_Result_M),
	.ALUResultE(ALUResultE),
	.ReadDataW(ReadDataW),
	.PCPlus4W(PCPlus4W),
	.PCPlus4E(PCPlus4E),
	.StallF(StallF),
	.FlushD(FlushD),
	.StallD(StallD),
	.FlushE(FlushE),
	.StallE(StallE),
	.currentBTA(currentBTA),
	.ForwardAE(ForwardAE),
	.ForwardBE(ForwardBE),
	.RA1D(RA1D),
	.RA2D(RA2D),
	.WA3E(WA3E),
	.WA3M(WA3M),
	.WA3W(WA3W));


ConditionalLogic conditionalLogic(
	.Cond(CondE),
	.ALUFlags(ALUFlags),
	.FlagW(FlagWriteE),
	.PCS(PCSrcE), .Branch(BranchE), 		
	.RegW(RegWriteE), .MemW(MemWriteE),
	.clk(clk), .rst(rst),
	.RegWrite(RegWriteE_cond), .MemWrite(MemWriteE_cond),
	.PCWrite(PCSrcE_cond), .PCWriteBranch(BranchTakenE),
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
	.rot(Instruction[11:8]),
	.FlagW(FlagWriteD),
	.PCSrc(PCSrcD), .RegW(RegWriteD), .MemW(MemWriteD),
	.MemtoReg(MemtoRegD), .ALUSrc(ALUSrcD), .WriteSrc(WriteSrcD),
	.ImmSrc(ImmSrcD),
	.RegSrc(RegSrc),	
	.ALUControl(ALUControlD),
	.shamt(shamtD),
	.shiftControl(shiftControlD),
	.BranchD(BranchD),
	.RA1D_valid(RA1D_valid), .RA2D_valid(RA2D_valid), .WA3D_valid(WA3D_valid));


branch_predictor_unit branch_predictor_unit(
	.clk(clk),
	.reset(reset_bp),
	.BranchE(BranchE),
	.BranchPredictedE(BranchPredictedE),
	.BranchTakenE(BranchTakenE),
	.ALUBranchAddressPlus4(ALUBranchAddressPlus4),
	.ALUResultE(ALUResultE),
	.currentPC(PC_out),
	.BranchPredicted(BranchPredicted),
	.currentBTA(currentBTA),
	.hit(hit),
	.branchPredictionResult(branchPredictionResult)
);
	
	
PCSrcSelect_m pcSrcSelect_m(
	.PCSrcE_cond(PCSrcE_cond), .BranchPredictedE(BranchPredictedE), .BranchPredicted(BranchPredicted), .BranchTakenE(BranchTakenE),
	.PCSrcSelect(PCSrcSelect));
	
	
// Depode Pipeline Registers
Register_sync_rw #(.WIDTH(1)) decode_BranchPredicted
    (
	  .clk(clk), .reset(rstD),
	  .DATA(BranchPredicted),
	  .OUT(BranchPredictedD),
	  .we(~StallD)
    );
	
// Execute Pipeline Registers

Register_simple #(.WIDTH(1))execute_WA3D_valid
    (
	  .clk(clk), .reset(rstE),
	  .DATA(WA3D_valid),
	  .OUT(WA3E_valid)
    );

Register_simple #(.WIDTH(1))execute_RA1D_valid
    (
	  .clk(clk), .reset(rstE),
	  .DATA(RA1D_valid),
	  .OUT(RA1E_valid)
    );

Register_simple #(.WIDTH(1))execute_RA2D_valid
    (
	  .clk(clk), .reset(rstE),
	  .DATA(RA2D_valid),
	  .OUT(RA2E_valid)
    );

Register_simple #(.WIDTH(4))execute_RA1D
    (
	  .clk(clk), .reset(rstE),
	  .DATA(RA1D),
	  .OUT(RA1E)
    );
	 
Register_simple #(.WIDTH(4))execute_RA2D
    (
	  .clk(clk), .reset(rstE),
	  .DATA(RA2D),
	  .OUT(RA2E)
    );

Register_simple #(.WIDTH(1))execute_BranchPredicted
    (
	  .clk(clk), .reset(rstE),
	  .DATA(BranchPredictedD),
	  .OUT(BranchPredictedE)
    );

Register_simple #(.WIDTH(1)) execute_PCSrc
    (
	  .clk(clk), .reset(rstE),
	  .DATA(PCSrcD),
	  .OUT(PCSrcE)
    );
	 
Register_simple  #(.WIDTH(1)) execute_BranchD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(BranchD),
	  .OUT(BranchE)
    );

Register_simple  #(.WIDTH(1)) execute_RegWriteD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(RegWriteD),
	  .OUT(RegWriteE)
    );
	 
Register_simple  #(.WIDTH(1)) execute_MemWriteD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(MemWriteD),
	  .OUT(MemWriteE)
    );

Register_simple  #(.WIDTH(1)) execute_MemtoRegD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(MemtoRegD),
	  .OUT(MemtoRegE)
    );
	 
Register_simple  #(.WIDTH(4)) execute_ALUControlD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(ALUControlD),
	  .OUT(ALUControlE)
    );	 
	  
Register_simple  #(.WIDTH(1)) execute_ALUSrcD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(ALUSrcD),
	  .OUT(ALUSrcE)
    );	
	 
Register_simple  #(.WIDTH(2)) execute_FlagWriteD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(FlagWriteD),
	  .OUT(FlagWriteE)
    );	
	 
Register_simple  #(.WIDTH(4)) execute_Cond  //////////////////////////////////////////////////////////////////////////////////////////////////
    (
	  .clk(clk), .reset(rstE),
	  .DATA(Cond),
	  .OUT(CondE)
    ); 
	 
Register_simple  #(.WIDTH(1)) execute_RegSrcD2
    (
	  .clk(clk), .reset(rstE),
	  .DATA(RegSrcD2),
	  .OUT(RegSrcE)
    );	 
 

Register_simple  #(.WIDTH(5)) execute_shamtD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(shamtD),
	  .OUT(shamtE)
    );	

Register_simple  #(.WIDTH(2)) execute_shiftControlD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(shiftControlD),
	  .OUT(shiftControlE)
    );	

Register_simple  #(.WIDTH(1)) execute_WriteSrcD
    (
	  .clk(clk), .reset(rstE),
	  .DATA(WriteSrcD),
	  .OUT(WriteSrcE)
    );		 
	 
// Memory Pipeline Registers	

Register_simple #(.WIDTH(1))execute_WA3E_valid
    (
	  .clk(clk), .reset(rst),
	  .DATA(WA3E_valid),
	  .OUT(WA3M_valid)
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
Register_simple #(.WIDTH(1))execute_WA3M_valid
    (
	  .clk(clk), .reset(rst),
	  .DATA(WA3M_valid),
	  .OUT(WA3W_valid)
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