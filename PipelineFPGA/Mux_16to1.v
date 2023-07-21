module Mux_16to1 #(parameter WIDTH=4)
    (
	  input [3:0] select,
	  input [WIDTH-1:0] input_0, input_1, input_2, input_3, input_4, input_5, input_6, input_7, input_8, input_9, input_10, input_11, input_12, input_13, input_14, input_15,
      output reg [WIDTH-1:0] output_value
    );

always@(*) begin
	case(select)
		4'b0000:output_value = input_0;
		4'b0001:output_value = input_1;
		4'b0010:output_value = input_2;
		4'b0011:output_value = input_3;
		
		4'b0100:output_value = input_4;
		4'b0101:output_value = input_5;
		4'b0110:output_value = input_6;
		4'b0111:output_value = input_7;
		
		4'b1000:output_value = input_8;
		4'b1001:output_value = input_9;
		4'b1010:output_value = input_10;
		4'b1011:output_value = input_11;
		
		4'b1100:output_value = input_12;
		4'b1101:output_value = input_13;
		4'b1110:output_value = input_14;
		4'b1111:output_value = input_15;
		
		default: output_value = {WIDTH{1'b0}};
	endcase
end

endmodule
