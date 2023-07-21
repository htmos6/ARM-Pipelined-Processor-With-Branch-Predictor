module Adder #(parameter WIDTH=32)
    (
	  input	[WIDTH-1:0] DATA_A,
	  input	[WIDTH-1:0] DATA_B,
	  output [WIDTH-1:0] OUT
    );
	 
assign OUT = DATA_A + DATA_B;
	 
endmodule	 