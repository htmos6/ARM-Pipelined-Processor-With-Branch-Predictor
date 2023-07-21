module Decoder_4to16
    (
	  input [3:0] IN,
      output reg [15:0] OUT
    );

always @(*) begin
	case(IN)
		4'h0:OUT=16'h0001;
		4'h1:OUT=16'h0002;
		4'h2:OUT=16'h0004;
		4'h3:OUT=16'h0008;

		4'h4:OUT=16'h0010;
		4'h5:OUT=16'h0020;
		4'h6:OUT=16'h0040;
		4'h7:OUT=16'h0080;

		4'h8:OUT=16'h0100;
		4'h9:OUT=16'h0200;
		4'ha:OUT=16'h0400;
		4'hb:OUT=16'h0800;

		4'hc:OUT=16'h1000;
		4'hd:OUT=16'h2000;
		4'he:OUT=16'h4000;
		4'hf:OUT=16'h8000;
	endcase
end

endmodule
