module Register_file #(parameter WIDTH=32)
    (
	  input clk, write_enable, reset,
	  input [3:0] Source_select_0, Source_select_1, Destination_select,
	  input	[WIDTH-1:0] DATA, Reg_15,
	  output wire [WIDTH-1:0] out_0, out_1
    );

wire [WIDTH-1:0] Reg_Out [14:0];
wire [15:0] Reg_enable;

genvar i;
generate
    for (i = 0 ; i < 15 ; i = i + 1) begin : registers
        Register_sync_rw #(WIDTH) Reg (.clk(clk),.reset(reset),.we(Reg_enable[i]& write_enable),.DATA(DATA),.OUT(Reg_Out[i]));
    end
endgenerate

Decoder_4to16 dec (.IN(Destination_select),.OUT(Reg_enable));

Mux_16to1 #(WIDTH) mux_0 (.select(Source_select_0),
	.input_0 (Reg_Out[0]),
	.input_1 (Reg_Out[1]),
	.input_2 (Reg_Out[2]),
	.input_3 (Reg_Out[3]),
	.input_4 (Reg_Out[4]),
	.input_5 (Reg_Out[5]),
	.input_6 (Reg_Out[6]),
	.input_7 (Reg_Out[7]),
	.input_8 (Reg_Out[8]),
	.input_9 (Reg_Out[9]),
	.input_10(Reg_Out[10]),
	.input_11(Reg_Out[11]),
	.input_12(Reg_Out[12]),
	.input_13(Reg_Out[13]),
	.input_14(Reg_Out[14]),
	.input_15(Reg_15),
	.output_value(out_0)
    );
	
Mux_16to1 #(WIDTH) mux_1 (.select(Source_select_1),
	.input_0 (Reg_Out[0]),
	.input_1 (Reg_Out[1]),
	.input_2 (Reg_Out[2]),
	.input_3 (Reg_Out[3]),
	.input_4 (Reg_Out[4]),
	.input_5 (Reg_Out[5]),
	.input_6 (Reg_Out[6]),
	.input_7 (Reg_Out[7]),
	.input_8 (Reg_Out[8]),
	.input_9 (Reg_Out[9]),
	.input_10(Reg_Out[10]),
	.input_11(Reg_Out[11]),
	.input_12(Reg_Out[12]),
	.input_13(Reg_Out[13]),
	.input_14(Reg_Out[14]),
	.input_15(Reg_15),
	.output_value(out_1)
    );

endmodule
