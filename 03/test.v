module test;
	wire [8:0] out;
	reg [7:0] in;
	reg [1:0] op;
	wire clock;

	clock_generator m1 (clock);
	assignment3 m2 (out, in, op, clock);

	task expect (input integer expected_out);
		if (out == expected_out)
			$display("PASS: %d", expected_out);
		else
			$display("FAIL: Expected %d, Actual %d", expected_out, out);
	endtask

	initial begin
		#5;

		in = 0; op = 0; #10;
		/* expect out to be unknown here */ #10;

		// in is buffered for one clock cycle
		in = 9; #10;
		expect(0); #10;

		// ...so only at this point we'll see the updated value
		#10;
		expect(9); #10;

		// but op is not buffered, so it will affect out on the next clock cycle
		op = 1; #10;
		expect(11); #10;

		op = 2; #10;
		expect(18); #10;

		op = 3; #10;
		expect(2); #10;

		in = 128 + 15; #10;
		expect(2); #10;

		#10;
		expect(5); #10;

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
