module assignment6_part1 (
	output reg [15:0] result,
	input wire [7:0] character,
	input wire enable_character,
	input wire clk,
	input wire rst
);
	wire parsed_turn;
	wire signed [15:0] amount;
	parser m_parser (parsed_turn, amount, character, enable_character, clk, rst);

	reg signed [15:0] dial;

	reg signed [15:0] s_dial_signed;
	reg [15:0] s_dial;
	reg [15:0] s_result;

	always @* begin
		s_dial_signed = (dial + amount) % 100;
		s_dial = s_dial_signed < 0 ? s_dial_signed + 100 : s_dial_signed;
		s_result = s_dial == 0 ? result + 1 : result;
	end

	always @(posedge clk) begin
		if (rst) begin
			dial <= 50;
			result <= 0;
		end else if (parsed_turn) begin
			dial <= s_dial;
			result <= s_result;
		end
	end
endmodule

module assignment6_part2 (
	output reg [15:0] result,
	input wire [7:0] character,
	input wire enable_character,
	input wire clk,
	input wire rst
);
	wire parsed_turn;
	wire signed [15:0] amount;
	parser m_parser (parsed_turn, amount, character, enable_character, clk, rst);

	reg signed [15:0] dial;

	reg signed [15:0] s_dial_signed;
	reg [15:0] s_dial;
	reg [15:0] s_result;
	reg [15:0] s_amount_unsigned;
	reg s_zero_hit_after_mod_100;

	always @* begin
		s_dial_signed = (dial + amount) % 100;
		s_dial = s_dial_signed < 0 ? s_dial_signed + 100 : s_dial_signed;

		s_amount_unsigned = amount < 0 ? -amount : amount;
		s_zero_hit_after_mod_100 =
			(amount < 0 && s_amount_unsigned % 100 >= dial && dial != 0) ||
			(amount >= 0 && s_amount_unsigned % 100 + dial >= 100);

		s_result = result + s_amount_unsigned / 100 + s_zero_hit_after_mod_100;
	end

	always @(posedge clk) begin
		if (rst) begin
			dial <= 50;
			result <= 0;
		end else if (parsed_turn) begin
			dial <= s_dial;
			result <= s_result;
		end
	end
endmodule

module parser (
	output wire parsed_turn,
	output wire signed [15:0] amount,
	input wire [7:0] character,
	input wire enable_character,
	input wire clk,
	input wire rst
);
	localparam L = 0;
	localparam R = 1;

	assign parsed_turn = character == "\n" && enable_character;
	assign amount = s_amount;

	reg direction;
	reg [15:0] abs_amount;

	reg s_direction;
	reg [15:0] s_abs_amount;
	reg signed [15:0] s_amount;

	always @* begin
		case (character)
			"L": s_direction = L;
			"R": s_direction = R;
			default: s_direction = direction;
		endcase

		case (character)
			"L",
			"R": s_abs_amount = abs_amount;
			default:
				if (character >= "0" && character <= "9")
					s_abs_amount = abs_amount * 10 + character - "0";
				else
					s_abs_amount = 0;
		endcase

		case (direction)
			L: s_amount = -abs_amount;
			R: s_amount = abs_amount;
		endcase
	end

	always @(posedge clk) begin
		if (rst)
			abs_amount <= 0;
		else if (enable_character) begin
			direction <= s_direction;
			abs_amount <= s_abs_amount;
		end
	end
endmodule
