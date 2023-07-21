//Constant Value Generator

module ConstGen  #(parameter W=8, value=4) (output wire [(W -1) : 0] out);
	assign out = value;

endmodule 