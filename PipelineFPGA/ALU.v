module ALU #(parameter WIDTH=8)
    (
	  input [3:0] control,
	  input CI,
	  input [WIDTH-1:0] DATA_A,
	  input [WIDTH-1:0] DATA_B,
      output reg [WIDTH-1:0] OUT,
	  output reg CO,
	  output reg OVF,
	  output N, Z
    );

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

// Assign the zero and negative flasg here since it is very simple
assign N = OUT[WIDTH-1];
assign Z = ~(|OUT);
	 
always@(*) begin
	case(control)
		AND:begin
			OUT = DATA_A & DATA_B;
			CO = 1'b0;
			OVF = 1'b0;
		end
		EXOR:begin
			OUT = DATA_A ^ DATA_B;
			CO = 1'b0;
			OVF = 1'b0;
		end
		SubtractionAB:begin
			OUT = DATA_A - DATA_B;
			CO = ~N; // ARM uses inverted borrow for subtraction with carry
			OVF = (DATA_A[WIDTH-1] & ~DATA_B[WIDTH-1] & ~OUT[WIDTH-1]) | (~DATA_A[WIDTH-1] & DATA_B[WIDTH-1] & OUT[WIDTH-1]);
		end
		SubtractionBA:begin
			OUT = DATA_B - DATA_A;
			CO = ~N; // ARM uses inverted borrow for subtraction with carry
			OVF = (DATA_B[WIDTH-1] & ~DATA_A[WIDTH-1] & ~OUT[WIDTH-1]) | (~DATA_B[WIDTH-1] & DATA_A[WIDTH-1] & OUT[WIDTH-1]);
		end
		Addition:begin
			{CO,OUT} = DATA_A + DATA_B;
			OVF = (DATA_A[WIDTH-1] & DATA_B[WIDTH-1] & ~OUT[WIDTH-1]) | (~DATA_A[WIDTH-1] & ~DATA_B[WIDTH-1] & OUT[WIDTH-1]);
		end
		Addition_Carry:begin
			{CO,OUT} = DATA_A + DATA_B + CI;
			OVF = (DATA_A[WIDTH-1] & DATA_B[WIDTH-1] & ~OUT[WIDTH-1]) | (~DATA_A[WIDTH-1] & ~DATA_B[WIDTH-1] & OUT[WIDTH-1]);
		end
		SubtractionAB_Carry:begin
			OUT = DATA_A - DATA_B + CI - 1;
			CO = ~N; // ARM uses inverted borrow for subtraction with carry
			OVF = (DATA_A[WIDTH-1] & ~DATA_B[WIDTH-1] & ~OUT[WIDTH-1]) | (~DATA_A[WIDTH-1] & DATA_B[WIDTH-1] & OUT[WIDTH-1]);
		end
		SubtractionBA_Carry:begin
			OUT = DATA_B - DATA_A + CI - 1;
			CO = ~N; // ARM uses inverted borrow for subtraction with carry
			OVF = (DATA_B[WIDTH-1] & ~DATA_A[WIDTH-1] & ~OUT[WIDTH-1]) | (~DATA_B[WIDTH-1] & DATA_A[WIDTH-1] & OUT[WIDTH-1]);
		end
		ORR:begin
			OUT = DATA_A | DATA_B;
			CO = 1'b0;
			OVF = 1'b0;
		end
		Move:begin
			OUT = DATA_B;
			CO = 1'b0;
			OVF = 1'b0;
		end
		Bit_Clear:begin
			OUT = DATA_A ^ ~DATA_B;
			CO = 1'b0;
			OVF = 1'b0;
		end
		Move_Not:begin
			OUT = ~DATA_B;
			CO = 1'b0;
			OVF = 1'b0;
		end
		default:begin
		OUT = {WIDTH{1'b0}};
		CO = 1'b0;
		OVF = 1'b0;
		end
	endcase
end
	 
endmodule	 