module bgt(
	input [63:0] a, b,
	input [2:0] funct3,
	output reg g
);

always @ (*)
begin 
	case (funct3)
	3'b000:	//beq
	begin
		if (a == b)
			g = 1'b1;
		else 
			g = 1'b0;
	end
	3'b100: //blt
	begin
		if (a < b)
			g = 1'b1;
		else 
			g = 1'b0;
	end
	3'b101:	//bge
	begin
		if (a >= b)
			g = 1'b1;
		else 
			g = 1'b0;
	end
	endcase
end

endmodule