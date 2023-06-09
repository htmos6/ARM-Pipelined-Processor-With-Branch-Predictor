module MainDecoder(
	input [1:0] Op, 
	input [5:0] Funct,			
	input [4:0] shamt5,
	input [1:0] sh,
	input L,
	input [23:0] bx_inst,
	output reg RegW, MemtoReg, ALUSrc, WriteSrc, 
	output wire ALUOp, Branch, MemW,
	output reg [1:0] ImmSrc, 
	output reg [2:0] RegSrc,    // no relative to PC branch
	output reg [4:0] shamt,
	output reg [1:0] shiftControl);

assign ALUOp = (Op == 2'b00) & (~( bx_inst == 24'b000100101111111111110001));
assign Branch = (Op == 2'b10) | (( bx_inst == 24'b000100101111111111110001) & (Op == 2'b00));
assign MemW = (Op == 2'b01) & (Funct[0] == 1'b0);			// STR
	
always @(*)
begin
	case(Op)
	2'b00:
	begin
		if( bx_inst == 24'b000100101111111111110001)
		begin
			//BX
			RegSrc[1] =1'b0;		// Rm
			// RegSrc[2] dont care
			RegSrc[2] = 1'b0;
			RegSrc[0] = 1'b1;
			RegW = 1'b0;
			// WriteSrc dont care
			WriteSrc = 1'b0;
			MemtoReg = 1'b0;		// ALUResult
			ALUSrc = 1'b0;
			shamt = 0;				// no shift
			shiftControl = 0;		// no shift, dont care
			//ImmSrc dont care
			ImmSrc = 2'b00;
		end
		else
		begin
			//data processing
			RegSrc = 3'b000;		// Rn, Rm, Rd
			WriteSrc = 1'b0;		// Result
			shamt = shamt5;
			shiftControl = sh;
			MemtoReg = 1'b0;
			if(Funct[4:1] == 4'b1010)
			begin
				//CMP
				RegW = 1'b0;
			end
			else
			begin
				RegW = 1'b1;
			end
			case(Funct[5])
			0:
			begin
				// not immediate
				//ImmSrc dont care
				ImmSrc = 2'b00;
				ALUSrc = 1'b0; 		// RD2
			end
			1:
			begin
				// immediate
				ImmSrc = 2'b00;		//imm8
				ALUSrc = 1'b1;			//ExtImm
				// RegSrc[1] dont care
			end
			endcase
		end
	end
	2'b01:
	begin
		//memory
		ALUSrc = 1'b1; 		// ExtImm
		ImmSrc = 2'b01;		// imm12
		shamt = 0;				// no shift
		shiftControl = 0;		// no shift, dont care
		RegSrc[0] = 1'b0;		// Rn
		WriteSrc = 1'b0;		// Result
		
		case(Funct[0])
		0:
		begin
			//STR
			RegSrc[1] =1'b1;		// Rd
			// RegSrc[2] dont care
			RegSrc[2] = 1'b0;
			RegW = 1'b0;
			// MemtoReg dont care
			MemtoReg = 1'b0;
		end
		1:
		begin
			//LDR
			RegSrc[2] =1'b0;		// Rd
			// RegSrc[1] dont care
			RegSrc[1] = 1'b0;
			RegW = 1'b1;
			MemtoReg = 1'b1;
		end
		endcase
	end
	2'b10:
	begin
		//branch
		ImmSrc = 2'b10;				// imm24
		case(L)
		0:
		begin
			// B, BEQ
			// RegSrc dont care
			RegSrc = 3'b001;
			RegW = 1'b0;
			// WriteSrc dont care
			WriteSrc = 1'b0;
			ALUSrc = 1'b1;
			shamt = 0;				// no shift
			shiftControl = 0;		// no shift, dont care
			MemtoReg = 1'b0;		// ALU result
		end
		1:
		begin
			// BL
			RegSrc[2] =1'b1;		// 14
			// RegSrc[1] dont care
			RegSrc[1:0] = 2'b01;
			WriteSrc = 1'b1;		// PC
			ALUSrc = 1'b1;			// ExtImm
			shamt = 0;				// no shift
			shiftControl = 0;		// no shift, dont care
			RegW = 1'b1;			
			MemtoReg = 1'b0;		// ALU result
		end
		endcase
	end
	default:
	begin
		//no operation, all signals are dont care
		RegSrc =3'b000;
		RegW = 1'b0;
		WriteSrc = 1'b0;
		MemtoReg = 1'b0;		
		ALUSrc = 1'b0;
		shamt = 0;				
		shiftControl = 0;		
		ImmSrc = 2'b00;
	end
	endcase
end	
	

endmodule 