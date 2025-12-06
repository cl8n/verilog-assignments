module test;
	wire [8:0] out;
	reg [7:0] in;
	reg [1:0] op;
	wire clock;

	clock_generator m1 (clock);
	assignment3 m2 (out, in, op, clock);

	task expect_after_clock (input [8:0] expected_out);
		begin
			@(posedge clock); #1;

			if (out == expected_out)
				$display("PASS: %d", expected_out);
			else
				$display("FAIL: Expected %d, Actual %d", expected_out, out);
		end
	endtask

	initial begin
		in = 0; op = 0;
		@(posedge clock); #1;
		// expect_after_clock(9'bX);

		// in is buffered for one clock cycle
		in = 9;
		expect_after_clock(0);

		// ...so only at this point we'll see the updated value
		expect_after_clock(9);

		// but op is not buffered, so it will affect out on the next clock cycle
		op = 1;
		expect_after_clock(11);

		op = 2;
		expect_after_clock(18);

		op = 3;
		expect_after_clock(2);

		in = 128 + 15;
		expect_after_clock(2);

		expect_after_clock(5);

		$finish;
	end

	initial begin
		$dumpfile("out.vcd");
		$dumpvars(0, test);
	end
endmodule

module clock_generator (output reg clock);
	initial begin
		clock = 0;
		forever #10 clock = !clock;
	end
endmodule
