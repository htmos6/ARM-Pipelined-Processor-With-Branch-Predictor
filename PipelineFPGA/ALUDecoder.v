module ALUDecoder(
	input [1:0] Op, 
	input [4:0] Funct,
	input ALUOp, Branch,
	input [23:0] bx_inst,
	output reg [1:0] FlagW,
	output reg [3:0] ALUControl);
	
parameter AND=4'b0000,
		  EXOR=4'b0001,
		  SubtractionAB=4'b0010,
		  SubtractionBA=4'b0011,
		  Addition=4'b0100,
		  Addition_Carry=4'b0101,
		  SubtractionAB_Carry=4'b0110,
		  SubtractionBA_Carry=4'b0111,
		  ORR=4'b1100,
		  Move=4'b1101,
		  Bit_Clear=4'b1110,
		  Move_Not=4'b1111;
	
always @(Funct, ALUOp, Branch, bx_inst, Op)	
begin
	case(ALUOp)
	0:
	begin
		FlagW = 2'b00;
		if (( bx_inst == 24'b000100101111111111110001) & (Op == 2'b00)) ALUControl = Move;	// BX
		else ALUControl = Addition;		
	end
	1:
	begin
		//data processing
		case(Funct[4:1])
		// ADD, SUB, AND, ORR, MOV, CMP
		4'b0100:
		begin
			//ADD
			FlagW = Funct[0] ? 2'b11 : 2'b00;
			ALUControl = Addition;
		end
		4'b0010:
		begin
			//SUB
			FlagW = Funct[0] ? 2'b11 : 2'b00;
			ALUControl = SubtractionAB;
		end
		4'b0000:
		begin
			//AND
			FlagW = Funct[0] ? 2'b10 : 2'b00;
			ALUControl = AND;
		end
		4'b1100:
		begin
			//ORR
			FlagW = Funct[0] ? 2'b10 : 2'b00;
			ALUControl = ORR;
		end
		4'b1101:
		begin
			//MOV
			FlagW = Funct[0] ? 2'b10 : 2'b00;
			ALUControl = Move;
		end
		4'b1010:
		begin
			//CMP
			FlagW = 2'b11;
			ALUControl = SubtractionAB;
		end
		default:
		begin
			//for error purposes
			FlagW = 2'b00;
			ALUControl = Move;
		end
		endcase
	end
	endcase
end
	
endmodule 