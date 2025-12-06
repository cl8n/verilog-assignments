module assignment3 (
	output wire [8:0] out,
	input wire [7:0] in,
	input wire [1:0] op,
	input wire clock
);
	reg [8:0] out_register; assign out = out_register;
	reg [7:0] in_register;

	function integer count_ones (input [7:0] in);
		begin
			count_ones = 0;

			for (integer i = 0; i < 8; i++) begin
				if (in[i] == 1'b1)
					count_ones++;
			end
		end
	endfunction

	always @ (posedge clock) begin
		in_register <= in;

		case (op)
			2'b00: out_register <= in_register;
			2'b01: out_register <= in_register + 2;
			2'b10: out_register <= in_register * 2;
			2'b11: out_register <= count_ones(in_register);
		endcase
	end
endmodule
