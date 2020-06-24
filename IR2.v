module IR2(
	input clk, reset, RegWrite, Branch, MemRead, MemtoReg, MemWrite, ALUSrc,
	input [1:0] ALUOp,
	input [63:0] PC_Out_IR1, 
	input [63:0] readData1, readData2,
	input [63:0] imm_data,
	input [3:0] insta_IR1,
	input [4:0] instb_IR1,
	output reg RegWrite_IR2, Branch_IR2, MemRead_IR2, MemtoReg_IR2, MemWrite_IR2, ALUSrc_IR2,
	output reg [1:0] ALUOp_IR2,
	output reg [63:0] PC_Out_IR2,
	output reg [63:0] readData1_IR2, readData2_IR2,
	output reg [63:0] imm_data_IR2,
	output reg [3:0] insta_IR2, 
	output reg [4:0] instb_IR2
);

always @ (posedge clk or posedge reset)
begin
	if (reset)
	begin
		RegWrite_IR2 <= 1'd0;
		Branch_IR2 <= 1'd0;
		MemRead_IR2 <= 1'd0;
		MemtoReg_IR2 <= 1'd0;
		MemWrite_IR2 <= 1'd0;
		ALUSrc_IR2 <= 1'd0;
		ALUOp_IR2 <= 2'd0;
		PC_Out_IR2 <= 64'd0;
		readData1_IR2 <= 64'd0;
		readData2_IR2 <= 64'd0;
		imm_data_IR2 <= 64'd0;
		insta_IR2 <= 4'd0;
		instb_IR2 <= 5'd0;
	end
	else
	begin
		RegWrite_IR2 <= RegWrite;
		Branch_IR2 <= Branch;
		MemRead_IR2 <= MemRead;
		MemtoReg_IR2 <= MemtoReg;
		MemWrite_IR2 <= MemWrite;
		ALUSrc_IR2 <= ALUSrc;
		ALUOp_IR2 <= ALUOp;
		PC_Out_IR2 <= PC_Out_IR1;
		readData1_IR2 <= readData1;
		readData2_IR2 <= readData2;
		imm_data_IR2 <= imm_data;
		insta_IR2 <= insta_IR1;
		instb_IR2 <= instb_IR1;
	end
end

endmodule