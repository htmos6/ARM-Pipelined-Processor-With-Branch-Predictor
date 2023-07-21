module Mux_4to1 #(parameter WIDTH=4)
    (
	  input [1:0] select,
	  input [WIDTH-1:0] input_0, input_1, input_2, input_3,
      output reg [WIDTH-1:0] output_value
    );

always@(*) begin
	case(select)
		2'b00:output_value = input_0;
		2'b01:output_value = input_1;
		2'b10:output_value = input_2;
		2'b11:output_value = input_3;
		default: output_value = {WIDTH{1'b0}};
	endcase
end

endmodule
