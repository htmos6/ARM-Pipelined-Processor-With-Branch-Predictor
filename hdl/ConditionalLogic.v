module ConditionalLogic(
	input [3:0] Cond,
	input [3:0] ALUFlags,
	input [1:0] FlagW,
	input PCS, Branch,
	input RegW, MemW,
	input clk, rst,
	output PCWrite, RegWrite, MemWrite, PCWriteBranch,
	output ALU_CI,
	output CondEx,
	output [3:0] Flags_wire,
	output [1:0] FlagWrite_w);
	
wire [1:0] FlagWrite;
//reg [3:0] Flags;
wire [3:0] Flags;
//wire CondEx;

ConditionCheck conditionCheck(
	.Cond(Cond),
	.Flags(Flags),			
	.CondEx(CondEx));
	
assign FlagWrite[1] = FlagW[1] & CondEx;
assign FlagWrite[0] = FlagW[0] & CondEx;
assign PCWrite = (PCS) & CondEx;
assign PCWriteBranch = (Branch) & CondEx;
assign RegWrite = RegW & CondEx;
assign MemWrite = MemW & CondEx;
assign ALU_CI = Flags[1];			//ALU Carry In


assign Flags_wire = Flags;
assign FlagWrite_w = FlagWrite;
		
		
Register_sync_rw #(.WIDTH(2)) r1
    (
	  .clk(clk), .reset(rst),.we(FlagWrite[0]),
	  .DATA( ALUFlags[1:0]),
	  .OUT(Flags[1:0])
    );		
		
Register_sync_rw #(.WIDTH(2)) r2
    (
	  .clk(clk), .reset(rst),.we(FlagWrite[1]),
	  .DATA(ALUFlags[3:2]),
	  .OUT(Flags[3:2])
    );
	 	
endmodule 