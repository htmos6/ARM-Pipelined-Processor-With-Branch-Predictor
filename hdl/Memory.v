// Memory Unit
// Little Endian convention
// combinational read, sequential write

// W is a parameter specifying the data width of write data and read data in bytes
module Memory #(parameter BYTE_SIZE = 4, ADDR_WIDTH = 12) (
	input clk, WE,  
	input [(8*BYTE_SIZE-1):0] WD,
	input [(ADDR_WIDTH-1):0] ADDR,					// 12-bit address selected
	//input [7:0] address,
	output reg [(8*BYTE_SIZE-1):0] RD);

	reg [7:0] mem [0:19];				// byte-addressable, 12-bit address space
	//reg [7:0] mem [0:255];
	
initial begin
//mem[0]=8'h01;
//mem[1]=8'h02;
//mem[2]=8'h03;
//mem[3]=8'h04;
$readmemh("mem_data.txt",mem);
end
	
	// combinational read
	always @(*)
	begin
		integer r;
			
		for (r = 0; r < BYTE_SIZE; r=r+1)
		begin
			RD[(8*r) +: 8] = mem[ADDR + r];
		end
	end
	
		// sequential write
	always @ (posedge clk)
	begin
		if(WE)
		// write data
		begin
			integer i;
			
			for (i = 0; i < BYTE_SIZE; i = i + 1)
			begin
				mem[ADDR + i] <= WD[(8*i)+:8];
			end
			
		end
	end
	
endmodule 