module HazardUnit(
	input [3:0] RA1E, RA2E, WA3M, WA3W, RA1D, RA2D, WA3E,
	input RA1E_valid, RA2E_valid, WA3M_valid, WA3W_valid, RA1D_valid, RA2D_valid, WA3E_valid,
	input RegWriteM, RegWriteW, MemtoRegE, BranchTakenE, BranchPredictedE, PCWrTakenE, 
	output reg [1:0] ForwardAE, ForwardBE,
	output StallF, StallD, FlushD, FlushE);
	
wire Match_1E_M, Match_1E_W;
assign Match_1E_M = (RA1E ==WA3M) & (RA1E_valid == 1'b1) & (WA3M_valid == 1'b1);
assign Match_1E_W = (RA1E ==WA3W) & (RA1E_valid == 1'b1) & (WA3W_valid == 1'b1);
	
wire Match_2E_M, Match_2E_W;
assign Match_2E_M = (RA2E ==WA3M) & (RA2E_valid == 1'b1) & (WA3M_valid == 1'b1);
assign Match_2E_W = (RA2E ==WA3W) & (RA2E_valid == 1'b1) & (WA3W_valid == 1'b1);
	
wire Match_12D_E, LDRstall;
assign Match_12D_E = (RA1D_valid == 1'b1) & (WA3E_valid == 1'b1) & (RA1D == WA3E) + (RA2D_valid == 1'b1) & (WA3E_valid == 1'b1) & (RA2D == WA3E);
assign LDRstall = Match_12D_E & MemtoRegE;

// outputs
assign StallF = LDRstall;
assign StallD = LDRstall;
assign FlushD = (BranchTakenE^BranchPredictedE) + PCWrTakenE;
assign FlushE = (BranchTakenE^BranchPredictedE) + PCWrTakenE + LDRstall;

	
always @(*)
begin
	// SrcAE
	if (Match_1E_M & RegWriteM)  ForwardAE = 2'b10;
	else if (Match_1E_W & RegWriteW) ForwardAE = 2'b01;
	else ForwardAE = 2'b00;
	
	// SrcBE
	if (Match_2E_M & RegWriteM)  ForwardBE = 2'b10;
	else if (Match_2E_W & RegWriteW) ForwardBE = 2'b01;
	else ForwardBE = 2'b00;
	
end

	
endmodule