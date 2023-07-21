module hex_number_to_7_seg_converter (input [3:0] inp_hex_number, output reg [6:0] out_hex_number);
	
	always @ (inp_hex_number) begin
		case (inp_hex_number)     //6543210
			0 : out_hex_number = 7'b1000000;
			1 : out_hex_number = 7'b1111001;
			2 : out_hex_number = 7'b0100100;
			3 : out_hex_number = 7'b0110000;
			4 : out_hex_number = 7'b0011001;
			5 : out_hex_number = 7'b0010010;
			6 : out_hex_number = 7'b0000010;
			7 : out_hex_number = 7'b1111000;
			8 : out_hex_number = 7'b0000000;
			9 : out_hex_number = 7'b0010000;
			10 : out_hex_number = 7'b0001000;
			11 : out_hex_number = 7'b0000011;
			12 : out_hex_number = 7'b0100111;
			13 : out_hex_number = 7'b0100001;
			14 : out_hex_number = 7'b0000110;
			15 : out_hex_number = 7'b0001110;
			default: out_hex_number = 0;
		endcase
	end

endmodule