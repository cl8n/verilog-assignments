module top (
	output reg [8:0] out,
	input wire [7:0] in,
	input wire clock
);
	reg [7:0] in_register;

	always @(posedge clock) begin
		in_register <= in;
		out <= in_register << 1;
	end
endmodule
