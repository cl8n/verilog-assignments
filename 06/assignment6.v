module assignment6_part1 (
	output reg [15:0] result,
	input wire [7:0] character,
	input wire enable_character,
	input wire clk,
	input wire rst
);
	localparam L = 0;
	localparam R = 1;

	reg signed [15:0] dial;

	reg direction;
	reg signed [15:0] amount;

	always @(posedge clk) begin
		if (rst) begin
			result <= 0;
			dial <= 50;
			reset_parser();
		end else if (enable_character)
			case (character)
				"L": direction <= L;
				"R": direction <= R;
				"\n":
					begin
						turn_dial();
						reset_parser();
					end
				default:
					if (character >= "0" && character <= "9")
						amount <= amount * 10 + character - "0";
			endcase
	end

	task turn_dial;
		begin
			case (direction)
				L:
					begin
						dial = (dial - amount) % 100;
						if (dial < 0)
							dial = dial + 100;
					end
				R: dial = (dial + amount) % 100;
			endcase

			if (dial == 0)
				result <= result + 1;
		end
	endtask

	task reset_parser;
		begin
			direction <= L;
			amount <= 0;
		end
	endtask
endmodule

module assignment6_part2 (
	output reg [15:0] result,
	input wire [7:0] character,
	input wire enable_character,
	input wire clk,
	input wire rst
);
	localparam L = 0;
	localparam R = 1;

	reg signed [15:0] dial;

	reg direction;
	reg signed [15:0] amount;

	always @(posedge clk) begin
		if (rst) begin
			result <= 0;
			dial <= 50;
			reset_parser();
		end else if (enable_character)
			case (character)
				"L": direction <= L;
				"R": direction <= R;
				"\n":
					begin
						turn_dial();
						reset_parser();
					end
				default:
					if (character >= "0" && character <= "9")
						amount <= amount * 10 + character - "0";
			endcase
	end

	task turn_dial;
		begin
			if (
				(direction == L && amount % 100 >= dial && dial != 0) ||
				(direction == R && amount % 100 + dial >= 100)
			)
				result <= result + amount / 100 + 1;
			else
				result <= result + amount / 100;

			case (direction)
				L:
					begin
						dial = (dial - amount) % 100;
						if (dial < 0)
							dial = dial + 100;
					end
				R: dial = (dial + amount) % 100;
			endcase
		end
	endtask

	task reset_parser;
		begin
			direction <= L;
			amount <= 0;
		end
	endtask
endmodule
