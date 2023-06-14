module GHR #(parameter W = 3) 
	(
		input clk, 
		input shift, 
		input reset, 
		input inp,	
		output reg [W-1:0] out
	);
	// shift = BranchE 
	// inp = BranchTakenE

	always @(posedge clk)
		begin
			if (reset == 1)
				out <= 0;
			else if (reset == 0 && shift == 0)
				out <= out;
			else if (reset == 0 && shift == 1)
				begin
					out[W-1:1] <= out[W-2:0];
					out[0] <= inp;
				end
		end
endmodule