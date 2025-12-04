module grade_my_epic_module_cuz_im_a_ta_now_just_like_francisco_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay;
	reg [7:0] in;
	reg clock;
	wire [8:0] out;

	top subject (.out (out), .in (in), .clock (clock));

	initial begin
		clock = 0;
		forever #10 clock = !clock; // pos edge on odd * 10
	end

	initial begin
		#5;
		in = 8'b00000000; #10;
		in = 8'b00000001; #10;
		in = 8'b00000010; #10;
		in = 8'b00000100; #10;
		in = 8'b10000000; #10;
		in = 8'b11111111; #10;

		$finish;
	end

	initial begin
		$dumpfile("out.vcd");
		$dumpvars(0, grade_my_epic_module_cuz_im_a_ta_now_just_like_francisco_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay);
	end
endmodule
