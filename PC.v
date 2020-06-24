module PC(
	input [63:0] PC_In,
	input clk,reset,
	output reg [63:0] PC_Out
);

always @ (posedge clk or posedge reset)
begin
	if (reset)
		PC_Out = 64'd0;
	else
		PC_Out <= PC_In;
end

endmodule