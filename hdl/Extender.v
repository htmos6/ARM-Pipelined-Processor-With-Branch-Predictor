module Extender(
input [23:0] A,
input [1:0] select,
output reg [31:0] Q

);

always @(*)
begin
	case(select)
	0: Q = {24'b0,A[7:0]};
	1: Q = {20'b0,A[11:0]};
	2: Q = {{6{A[23]}}, A, 2'b0};
	default: Q = 0;
	endcase
end

endmodule
