module Mux_2to1 #(parameter WIDTH=4)
    (
	  input select,
	  input [WIDTH-1:0] input_0, input_1,
      output [WIDTH-1:0] output_value
    );

assign output_value = select ? input_1 : input_0;

endmodule
