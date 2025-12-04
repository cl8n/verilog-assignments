module top (
	output reg [8:0] out,
	input [7:0] in,
	input clock
);
	always @(posedge clock) begin
		assign out = in << 1;
	end
endmodule
