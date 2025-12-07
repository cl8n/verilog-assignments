module test;
	wire pass;
	wire clk;
	reg rst;

	clock_generator m1 (clk);
	assignment4 m2 (pass, clk, rst);

	task expect_on_negedge (input expected_pass);
		begin
			@(negedge clk);

			if (pass === expected_pass)
				$display("PASS: %d", expected_pass);
			else
				$display("FAIL: Expected %d, Actual %d", expected_pass, pass);
		end
	endtask

	initial begin
		rst <= 1;

		// starts on green
		expect_on_negedge(1);
		rst <= 0;

		// yellow after 5 cycles
		repeat (5) @(posedge clk);
		expect_on_negedge(1);

		// red after 2 cycles
		repeat (2) @(posedge clk);
		expect_on_negedge(0);

		// green after 7 cycles
		repeat (7) @(posedge clk);
		expect_on_negedge(1);

		// wait 6 cycles (1 away from red), reset, wait another 6, should be yellow
		repeat (5) @(posedge clk);
		@(negedge clk);
		rst <= 1;
		@(posedge clk);
		@(negedge clk);
		rst <= 0;
		repeat (6) @(posedge clk);
		expect_on_negedge(1);

		// red after 1 cycle
		@(posedge clk);
		expect_on_negedge(0);

		// red after 1 cycle
		@(posedge clk);
		expect_on_negedge(0);

		// reset after 1 cycle, should be green
		rst <= 1;
		@(posedge clk);
		expect_on_negedge(1);
		rst <= 0;

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
