module IR3(
	input clk, reset, RegWrite_IR2, MemtoReg_IR2, Branch_IR2, MemRead_IR2, MemWrite_IR2,
	input [63:0] out,
	input zero, 
	input [63:0] Result,
    input [63:0] readData2_IR2,
	input [4:0] instb_IR2,
	output reg RegWrite_IR3, MemtoReg_IR3, Branch_IR3, MemRead_IR3, MemWrite_IR3,
	output reg [63:0] out_IR3,
	output reg zero_IR3,
	output reg [63:0] Result_IR3,
    output reg [63:0] readData2_IR3,
	output reg [4:0] instb_IR3
);

always @ (posedge clk or posedge reset)
begin
	if (reset)
	begin
		RegWrite_IR3 <= 1'd0;
		MemtoReg_IR3 <= 1'd0;
		Branch_IR3 <= 1'd0;
		MemRead_IR3 <= 1'd0;
		MemWrite_IR3 <= 1'd0;
		out_IR3 <= 64'd0;
		zero_IR3 <= 1'd0;
		Result_IR3 <= 64'd0;
		readData2_IR3 <= 64'd0;
		instb_IR3 <= 5'd0;
	end
	else	
	begin
		RegWrite_IR3 <= RegWrite_IR2;
		MemtoReg_IR3 <= MemtoReg_IR2;
		Branch_IR3 <= Branch_IR2;
		MemRead_IR3 <= MemRead_IR2;
		MemWrite_IR3 <= MemWrite_IR2;
		out_IR3 <= out;
		zero_IR3 <= zero;
		Result_IR3 <= Result;
		readData2_IR3 <= readData2_IR2;
		instb_IR3 <= instb_IR2;
	end
end

endmodule