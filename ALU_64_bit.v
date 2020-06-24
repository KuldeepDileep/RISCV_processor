module ALU_64_bit(
input [63:0] a,
input [63:0] b,
//input CarryIn,
input [3:0] ALUOp,
output [63:0] Result,
//output reg CarryOut,
output reg zero
);

wire [63:0] abar, bbar, mux1out, mux2out;
reg[63:0] ALUOut ;

//assign abar = ~a;
//assign bbar = ~b;
//assign mux1out =(ALUOp[3] == 1’b1)? abar:a;
//assign mux2out =(ALUOp[2] == 1’b1)? bbar:b;
always @ (a or b or ALUOp)
begin
	case (ALUOp)
		4'b0000: 
		begin
			ALUOut = a & b;
			//ALUOut = mux1out & mux2out;
			//CarryOut = 1’b0;
		end
		4'b0001: 
		begin
			ALUOut = a | b;
			//ALUOut = mux1out | mux2out;
			//CarryOut = 1’b0;
		end
		4'b0010: 
		begin
			ALUOut = a + b;
			//ALUOut = mux1out + mux2out + CarryIn;
			//CarryOut = (mux1out & CarryIn) | (mux2out & CarryIn) | (mux2out & mux1out);
		end
		4'b0110:
		begin
			ALUOut = a - b;
		end
		4'b1100:
		begin
			ALUOut = ~(a|b);
		end
	endcase
	case (ALUOut)
		64'b0000000000000000000000000000000000000000000000000000000000000000: 
		zero = 1'b1;
		default : zero = 1'b0;
	endcase
end
assign Result = ALUOut ;
endmodule