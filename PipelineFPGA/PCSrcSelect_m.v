module PCSrcSelect_m(
	input PCSrcE_cond, BranchPredictedE, BranchPredicted, BranchTakenE,
	output reg [1:0] PCSrcSelect);

always @(*)
	begin
		if ((PCSrcE_cond == 1'b0) && (BranchPredictedE == BranchTakenE)) 
			begin 
				if (BranchPredicted == 1'b0) PCSrcSelect = 2'b00;			// PCPlus4
				else PCSrcSelect = 2'b10;			// BTA
			end
		else
			begin
				if (PCSrcE_cond == 1'b1) PCSrcSelect = 2'b01;			// ALUResultE
				else 
					begin
						if (BranchPredictedE == 1'b1) PCSrcSelect = 2'b11;			// carriedPCPlus4
						else PCSrcSelect = 2'b01;			// ALUResultE
					end 
			end
		end
	
endmodule
