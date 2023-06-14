module BranchPredictor(
	input BranchPredictedE, BranchTakenE, BranchE, 
	input [31:0] ALUResultE, currentPC, ALUBranchAddressPlus4,
	output BranchPredicted,
	output [31:0] currentBTA);

	
assign BranchPredicted = 0;
assign currentBTA = 32'b0;

endmodule
