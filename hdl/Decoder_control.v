module Decoder_control(
	input [1:0] Op, 
	input [5:0] Funct, 
	input [3:0] Rd,
	input [4:0] shamt5,
	input [1:0] sh,
	input L, 
	input [23:0] bx_inst,
	input [3:0] rot,
	output wire [1:0] FlagW,
	output PCSrc, RegW, MemW,
	output MemtoReg, ALUSrc, WriteSrc,
	output [1:0] ImmSrc,
	output [2:0] RegSrc,	
	output [3:0] ALUControl,
	output [4:0] shamt,
	output [1:0] shiftControl,
	output BranchD);
	
wire ALUOp, Branch;

assign BranchD = Branch;
	
ALUDecoder ALUdecoder(
	.Funct(Funct[4:0]),
	.ALUOp(ALUOp), .Branch(Branch),
	.bx_inst(bx_inst),
	.FlagW(FlagW),
	.ALUControl(ALUControl));
	
PCLogic pclogic( 
	.Rd(Rd), 
	.RegW(RegW), 
	.bx_inst(bx_inst),
	.Op(Op),
	.PCSrc(PCSrc));
	
MainDecoder mainDecoder(
	.Op(Op), 
	.Funct(Funct),			
	.shamt5(shamt5),
	.sh(sh),
	.L(L),
	.bx_inst(bx_inst),
	.rot(rot),
	.RegW(RegW), .MemtoReg(MemtoReg), .ALUSrc(ALUSrc), .WriteSrc(WriteSrc), 
	.ALUOp(ALUOp), .Branch(Branch), .MemW(MemW),
	.ImmSrc(ImmSrc), 
	.RegSrc(RegSrc),    
	.shamt(shamt),
	.shiftControl(shiftControl));

endmodule 