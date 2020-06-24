module IR1(
	input clk, reset,
	input [63:0] PC_Out,
	input [31:0] Instruction,
	output reg [63:0] PC_Out_IR1,
	output reg [31:0] Instruction_IR1
);

always @ (posedge clk or posedge reset)
begin
	if (reset)
		PC_Out_IR1 = 64'd0;
	else
	begin
		PC_Out_IR1 <= PC_Out;
		Instruction_IR1 <= Instruction;
	end
end

endmodule