module pipeline_RISCV(
	input clk, reset
);

wire [63:0] dataout2, dataout3, PC_Out, PC_Out_IR1, PC_Out_IR2, readData1, readData1_IR2, readData2_IR2, readData2_IR3, readData2, muxOut1, muxOut2, muxOut3, Result, Result_IR3, Read_Data, imm_data, imm_data_IR2, out1, out2, out_IR3, Read_Data_IR4, Mem_Addr_IR4;
wire [31:0] Instruction, Instruction_IR1;
wire [6:0] opcode, funct7;
wire [4:0] rs1, rs2, rd, instb_IR4, instb_IR2, instb_IR3, rs1_IR2, rs2_IR2;
wire [3:0] Operation, insta_IR2;
wire [2:0] funct3;
wire [1:0] ALUOp, ALUOp_IR2, forwardA, forwardB;
wire g, Branch, Branch_IR2, Branch_IR3, MemRead, MemRead_IR2, MemRead_IR3, MemtoReg, MemtoReg_IR2, MemtoReg_IR3, MemtoReg_IR4, MemWrite, MemWrite_IR2, MemWrite_IR3, ALUSrc, ALUSrc_IR2, RegWrite, RegWrite_IR2, RegWrite_IR3, RegWrite_IR4, zero, zero_IR3;

PC counter(
	.PC_In(muxOut3),
	.clk(clk),
	.reset(reset),
	.PC_Out(PC_Out)
);

mux_64 mux3(
	.a(out1),
	.b(out_IR3),
	.sel(Branch_IR3 & zero_IR3),
	.dataout(muxOut3)
);

Adder add1(
	.a(PC_Out),
	.b(64'd4),
	.out(out1)
);

Instruction_Memory IM(
	.Inst_Address(PC_Out),
	.Instruction(Instruction)
);

IR1 R1(
	.clk(clk),
	.reset(reset),
	.PC_Out(PC_Out),
	.Instruction(Instruction),
	.PC_Out_IR1(PC_Out_IR1),
	.Instruction_IR1(Instruction_IR1)
);

Inst_parser IP(
	.instruction(Instruction_IR1),
	.opcode(opcode),
	.funct7(funct7),
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd),
	.funct3(funct3)
);

registerFile RF(
	.data(muxOut2),
	.rs1(rs1),
	.rs2(rs2),
	.rd(instb_IR4),
	.regWrite(RegWrite_IR4),
	.clk(clk),
	.reset(reset),
	.readData1(readData1),
	.readData2(readData2)
);

Imm_data_extractor IDE(
	.instruction(Instruction_IR1),
	.imm_data(imm_data)
);

Control_Unit CU(
	.Opcode(opcode),
	.ALUOp(ALUOp),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite)
);

IR2 R2(
	.clk(clk), 
	.reset(reset),
	.RegWrite(RegWrite), 
	.Branch(Branch), 
	.MemRead(MemRead), 
	.MemtoReg(MemtoReg), 
	.MemWrite(MemWrite), 
	.ALUSrc(ALUSrc),
	.ALUOp(ALUOp),
	.PC_Out_IR1(PC_Out_IR1), 
	.readData1(readData1), 
	.readData2(readData2),
	.imm_data(imm_data),
	.insta_IR1({Instruction_IR1[30], Instruction_IR1[14:12]}),
	.instb_IR1(rd),
	.rs1(rs1),
	.rs2(rs2),
	.RegWrite_IR2(RegWrite_IR2), 
	.Branch_IR2(Branch_IR2), 
	.MemRead_IR2(MemRead_IR2), 
	.MemtoReg_IR2(MemtoReg_IR2), 
	.MemWrite_IR2(MemWrite_IR2), 
	.ALUSrc_IR2(ALUSrc_IR2),
	.ALUOp_IR2(ALUOp_IR2),
	.PC_Out_IR2(PC_Out_IR2),
	.readData1_IR2(readData1_IR2), 
	.readData2_IR2(readData2_IR2),
	.imm_data_IR2(imm_data_IR2),
	.insta_IR2(insta_IR2), 
	.instb_IR2(instb_IR2),
	.rs1_IR2(rs1_IR2),
	.rs2_IR2(rs2_IR2)
);

ALU_64_bit ALU(
	.a(dataout2),
	.b(muxOut1),
	.ALUOp(Operation),
	.Result(Result),
	.zero(zero)
);

mux64_3 mux4(
	.a(readData1_IR2),
	.b(muxOut2),
	.c(Result_IR3),
	.d(forwardA),
	.dataout2(dataout2)
);

forwarding FU(
	.clk(clk), 
	.RegWrite_IR3(RegWrite_IR3), 
	.RegWrite_IR4(RegWrite_IR4),
	.rs1_IR2(rs1_IR2),
	.rs2_IR2(rs2_IR2), 
	.instb_IR3(instb_IR3), 
	.instb_IR4(instb_IR4),
	.forwardA(fowardA), 
	.forwardB(forwardB)
);

bgt bgt1(
	.a(readData1_IR2), 
	.b(muxOut1),
	.funct3(funct3),
	.g(g)
);

mux_64 mux1(
	.a(dataout3),
	.b(imm_data_IR2),
	.sel(ALUSrc_IR2),
	.dataout(muxOut1)
);

ALU_Control ALU_C(
	.ALUOp(ALUOp_IR2),
	.Funct(insta_IR2),
	.Operation(Operation)
);

Adder add2(
	.a(PC_Out_IR2),
	.b(imm_data_IR2<<1),
	.out(out2)
);

mux64_3 mux5(
	.a(readData2_IR2),
	.b(muxOut2),
	.c(Result_IR3),
	.d(forwardB),
	.dataout2(dataout3)
);

IR3 R3(
	.clk(clk), 
	.reset(reset),
	.RegWrite_IR2(RegWrite_IR2), 
	.MemtoReg_IR2(MemtoReg_IR2), 
	.Branch_IR2(Branch_IR2), 
	.MemRead_IR2(MemRead_IR2), 
	.MemWrite_IR2(MemWrite_IR2),
	.out(out2),
	.zero(g), 
	.Result(Result),
    .readData2_IR2(readData2_IR2),
	.instb_IR2(instb_IR2),
	.RegWrite_IR3(RegWrite_IR3), 
	.MemtoReg_IR3(MemtoReg_IR3), 
	.Branch_IR3(Branch_IR3), 
	.MemRead_IR3(MemRead_IR3), 
	.MemWrite_IR3(MemWrite_IR3),
	.out_IR3(out_IR3),
	.zero_IR3(zero_IR3),
	.Result_IR3(Result_IR3),
    .readData2_IR3(readData2_IR3),
	.instb_IR3(instb_IR3)
);

Data_Memory DM(
	.Mem_Addr(Result_IR3),
	.Write_Data(readData2_IR3),
	.clk(clk),
	.MemWrite(MemWrite_IR3),
	.MemRead(MemRead_IR3),
	.Read_Data(Read_Data)
);

IR4 R4(
	.clk(clk),
	.reset(reset),
	.RegWrite_IR3(RegWrite_IR3), 
	.MemtoReg_IR3(MemtoReg_IR3),
	.Read_Data(Read_Data), 
	.Mem_Addr(Result_IR3),
	.instb_IR3(instb_IR3),
	.RegWrite_IR4(RegWrite_IR4), 
	.MemtoReg_IR4(MemtoReg_IR4),
	.Read_Data_IR4(Read_Data_IR4), 
	.Mem_Addr_IR4(Mem_Addr_IR4),
	.instb_IR4(instb_IR4)
);

mux_64 mux2(
	.a(Mem_Addr_IR4),
	.b(Read_Data_IR4),
	.sel(MemtoReg_IR4),
	.dataout(muxOut2)
);

endmodule