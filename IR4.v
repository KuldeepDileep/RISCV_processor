module IR4(
	input clk, reset, RegWrite_IR3, MemtoReg_IR3,
	input [63:0] Read_Data, Mem_Addr,
	input [4:0] instb_IR3,
	output reg RegWrite_IR4, MemtoReg_IR4,
	output reg [63:0] Read_Data_IR4, Mem_Addr_IR4,
	output reg [4:0] instb_IR4
);

always @ (posedge clk)
begin
	if (reset)
	begin
		RegWrite_IR4 <= 1'd0; 
		MemtoReg_IR4 <= 1'd0;
		Read_Data_IR4 <= 64'd0;
		Mem_Addr_IR4 <= 64'd0;
		instb_IR4 <= 5'd0;	
	end
	else
	begin
		RegWrite_IR4 <= RegWrite_IR3; 
		MemtoReg_IR4 <= MemtoReg_IR3;
		Read_Data_IR4 <= Read_Data;
		Mem_Addr_IR4 <= Mem_Addr;
		instb_IR4 <= instb_IR3;
	end
end

endmodule