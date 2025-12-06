module assignment3 (
	output wire [8:0] out,
	input wire [7:0] in,
	input wire [1:0] op,
	input wire clock
);
	reg [8:0] out_register; assign out = out_register;
	reg [7:0] in_register;

	function [8:0] count_ones (input [7:0] in);
		begin
			count_ones = 0;

			for (integer i = 0; i < 8; i = i + 1) begin
				count_ones = count_ones + in[i];
			end
		end
	endfunction

	always @ (posedge clock) begin
		in_register <= in;

		case (op)
			0: out_register <= in_register;
			1: out_register <= in_register + 2;
			2: out_register <= in_register * 2;
			3: out_register <= count_ones(in_register);
		endcase
	end
endmodule
