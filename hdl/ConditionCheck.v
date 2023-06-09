module ConditionCheck(
	input [3:0] Cond,
	input [3:0] Flags,			// Flags[3:0] = NZCV
	output reg CondEx);

always @(*)
begin
	case(Cond)
	4'b0000: 
	begin
		// EQ
		CondEx = Flags[2];
	end
	4'b0001: 
	begin
		// NE
		CondEx = ~Flags[2];
	end
	4'b0010: 
	begin
		// CS/HS
		CondEx = Flags[1];
	end
	4'b0011: 
	begin
		// CC/LO
		CondEx = ~Flags[1];
	end
	4'b0100: 
	begin
		// MI
		CondEx = Flags[3];
	end
	4'b0101: 
	begin
		// PL
		CondEx = ~Flags[3];
	end
	4'b0110: 
	begin
		// VS
		CondEx = Flags[0];
	end
	4'b0111: 
	begin
		// VC
		CondEx = ~Flags[0];
	end
	4'b1000: 
	begin
		// HI
		CondEx = (~Flags[2]) & Flags[1];
	end
	4'b1001: 
	begin
		// LS
		CondEx = Flags[2] | (~Flags[1]);
	end
	4'b1010: 
	begin
		// GE
		CondEx = ~(Flags[3] ^ Flags[0]);
	end
	4'b1011: 
	begin
		// LT
		CondEx = Flags[3] ^ Flags[0];
	end
	4'b1100: 
	begin
		// GT
		CondEx = (~Flags[2]) & (~(Flags[3] ^ Flags[0]));
	end
	4'b1101: 
	begin
		// LE
		CondEx = Flags[2] | (Flags[3] ^ Flags[0]);
	end
	default: CondEx = 1'b1;			//always or not defined
	endcase
end	
	
endmodule 