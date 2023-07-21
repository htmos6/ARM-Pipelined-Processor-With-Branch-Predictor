module PCLogic( 
	input [3:0] Rd, 
	input RegW,
	input [23:0] bx_inst, 
	input [1:0] Op,
	output PCSrc);
	
	
	assign PCSrc = ((Rd == 15) & RegW) | (( bx_inst == 24'b000100101111111111110001) & (Op == 2'b00));

endmodule 