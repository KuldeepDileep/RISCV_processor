module mux64_3(
	input [63:0] a, b, c,
	input [1:0] d,
	output [63:0] dataout2
);

reg[63:0] out;
always @(a or b or d)
   begin
	case (sel)
		2'b00: out = a;
		2'b01: out = b;
		2'b10: out = c;
	endcase
end
assign dataout2 = out;
endmodule