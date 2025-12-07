module test;
	wire [7:0] out;
	reg [7:0] in;
	reg enable;
	wire clk;

	clock_generator m_clock_generator (clk);

	assignment5 m_assignment5 (out, in, enable, clk);
	defparam m_assignment5.size = 10;
	defparam m_assignment5.width = 8;

	task expect_on_negedge (input [7:0] expected_out);
		begin
			@(negedge clk);

			if (out === expected_out)
				$display("PASS: %d", expected_out);
			else
				$display("FAIL: Expected %d, Actual %d", expected_out, out);
		end
	endtask

	initial begin
		enable <= 0;
		in <= 0;

		// starts unknown
		expect_on_negedge('bX);

		// ...and it should still be unknown an arbitrarily long time later,
		// as long as `enable` hasn't been set high
		repeat (20) @(posedge clk);
		expect_on_negedge('bX);

		// load a few values
		enable <= 1;
		in <= 1;
		@(negedge clk);
		in <= 2;
		@(negedge clk);
		in <= 3;
		@(negedge clk);
		in <= 0;

		// wait for the values to propogate through
		repeat (10 - 3) expect_on_negedge('bX);

		// check for first value
		expect_on_negedge(1);
		// ...and make sure it stays there if `enable` is low
		enable <= 0;
		repeat (20) expect_on_negedge(1);

		// check for remaining values
		enable <= 1;
		expect_on_negedge(2);
		expect_on_negedge(3);
		repeat (20) expect_on_negedge(0);

		// test that `in` has no effect if `enable` is low
		enable <= 0;
		in <= 4;
		@(negedge clk);
		enable <= 1;
		in <= 0;
		repeat (20) expect_on_negedge(0);

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
