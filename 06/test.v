module test;
	wire [15:0] result_part1;
	wire [15:0] result_part2;
	reg signed [8:0] character;
	reg enable_character;
	wire clk;
	reg rst;

	integer input_fd;
	reg [639:0] input_error;

	clock_generator m_clock_generator (clk);
	assignment6_part1 m_assignment6_part1 (result_part1, character[7:0], enable_character, clk, rst);
	assignment6_part2 m_assignment6_part2 (result_part2, character[7:0], enable_character, clk, rst);

	task expect_on_negedge (input [15:0] expected, input [15:0] actual);
		begin
			@(negedge clk);

			if (actual === expected)
				$display("PASS: %d", expected);
			else
				$display("FAIL: Expected %d, Actual %d", expected, actual);
		end
	endtask

	initial begin
		rst = 1;
		enable_character = 0;
		input_fd = $fopen("input", "rb");

		if (!input_fd) begin
			$display("Error opening input file");
			$finish;
		end

		@(negedge clk);
		rst = 0;

		begin :break
			forever begin
				@(negedge clk);

				character = $fgetc(input_fd);
				enable_character = character != -1;

				if (!enable_character)
					disable break;
			end
		end

		if ($ferror(input_fd, input_error))
			$display("Error reading input file:\n%s", input_error);
		else begin
			expect_on_negedge(1021, result_part1);
			expect_on_negedge(5933, result_part2);
		end

		$fclose(input_fd);
		$finish;
	end

	initial begin
		$dumpfile("out.vcd");
		$dumpvars(0, test);
	end
endmodule

module clock_generator (output reg clk);
	initial begin
		clk <= 1;
		forever #10 clk <= !clk;
	end
endmodule
