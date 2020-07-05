module forwarding(
	input clk, RegWrite_IR3, RegWrite_IR4,
	input [4:0] rs1_IR2,rs2_IR2, instb_IR3, instb_IR4,
	output reg [1:0] forwardA, forwardB
);

always @ (posedge clk)
begin
	if (RegWrite_IR3 & (instb_IR3 != 0) & (instb_IR3 == rs1_IR2))
		forwardA <= 2'b10;
	else if (RegWrite_IR3 & (instb_IR3 != 0) & (instb_IR3 == rs1_IR2))
		forwardB <= 2'b10;
	else if (RegWrite_IR4 & (instb_IR4 != 0) & (instb_IR3 == rs1_IR2))
		forwardA <= 2'b01;
	else
	begin
		forwardA <= 2'b00;
		forwardB <= 2'b00;
	end
end

endmodule