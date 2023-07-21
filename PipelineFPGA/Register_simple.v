module Register_simple #(
     parameter WIDTH=8)
    (
	  input  clk, reset,
	  input	[WIDTH-1:0] DATA,
	  output reg [WIDTH-1:0] OUT
    );
	
	
always@(posedge clk) begin
	if(reset == 1'b1)
		OUT<={WIDTH{1'b0}};
	else	
		OUT<=DATA;
end
	 
endmodule	 