module tb(
);

reg clk, reset;

pipeline_RISCV riscv(
	.clk(clk),
	.reset(reset)
);

initial
begin 
	reset = 1'b1;
	clk = 1'b1;
	#7 reset = 1'b0;
end

always
#10 clk = ~clk;

endmodule