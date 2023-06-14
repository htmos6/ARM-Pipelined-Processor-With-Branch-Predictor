module BTB #(parameter W_PC = 8, W_BTA = 32) 
	(
		input reset,
		input [W_PC-1:0] pc, // LSB 8 bits
		input [31:0] aluBranchAddress,
		input [31:0] pcOfAluBranchAddress, // pc + 4
		input [0:0] branchTakenE,
		input [0:0] branchPredictedE,
		output reg [W_BTA-1:0] BTA, // MSB 32 bits
		output reg hit
		//output reg [39:0] cache0, cache1, cache2
		// output reg [2:0] lastUsedID
	);
	
	reg [39:0] cache0, cache1, cache2;
	reg [39:0] pcOfAluBranchAddressReg; // First 8 bits are PC, Remaining 32 bits are BTA
	reg [2:0] lastUsedID;
	reg [39:0] temp0, temp1;

	initial 
		begin
			lastUsedID = 0;	
			cache0 = 40'h0000001108;
			cache1 = 40'h0000002212;
			cache2 = 40'h0000003316;
		end
	
	always @(reset or pc or pcOfAluBranchAddress or aluBranchAddress or branchTakenE or branchPredictedE)
		begin
			pcOfAluBranchAddressReg = pcOfAluBranchAddress - 4;
			if (reset == 1)
				begin
					lastUsedID = 4; // Reset signal
				end
			else if ((cache0[7:0] != pcOfAluBranchAddress[7:0]) && (cache1[7:0] != pcOfAluBranchAddress[7:0]) && (cache2[7:0] != pcOfAluBranchAddress[7:0]) && (branchTakenE == 1) && (branchPredictedE == 0))
				begin
					lastUsedID = 3; // It could not find it in the BTB
				end
			else if (cache0[7:0] == pc)
				begin
					hit = 1;
					BTA = cache0[39:8];
					lastUsedID = 0;
				end
			else if (cache1[7:0] == pc)
				begin
					hit = 1;
					BTA = cache1[39:8];
					lastUsedID = 1;
				end
			else if (cache2[7:0] == pc)
				begin
					hit = 1;
					BTA = cache2[39:8];
					lastUsedID = 2;
				end
		end



	always @(lastUsedID)
		begin 
			if (lastUsedID == 0) // Stay same
				begin
					cache0 = cache0;
					cache1 = cache1;
					cache2 = cache2;
				end
			else if (lastUsedID == 2)
				begin
					temp0 = cache0;
					temp1 = cache1;
					cache0 = cache2;
					cache1 = temp0;
					cache2 = temp1;
				end
			else  if (lastUsedID == 1)
				begin
					temp0 = cache0;
					temp1 = cache1;
					cache0 = temp1;
					cache1 = temp0;
 				end
			else  if (lastUsedID == 4)
				begin
					cache0 = 0;
					cache1 = 0;
					cache2 = 0;
 				end
			else if (lastUsedID == 3)
				begin
					temp0 = cache0;
					temp1 = cache1;
					cache0 = {aluBranchAddress,pcOfAluBranchAddressReg[7:0]};
					cache1 = temp0;
					cache2 = temp1;
 				end
		end
endmodule
