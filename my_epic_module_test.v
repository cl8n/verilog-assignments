module grade_my_epic_module_cuz_im_a_ta_now_just_like_francisco_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay;
	reg [7:0] in;
	wire [8:0] out;

	top subject (.out (out), .in (in));

	initial begin
		in = 8'b00000000; #10; // i think the #10 waits or something
		in = 8'b00000001; #10;
		in = 8'b10000000; #10;
		in = 8'b11111111; #10;

		$finish;
	end

	initial begin
		$dumpfile("out.vcd");
		$dumpvars(0, grade_my_epic_module_cuz_im_a_ta_now_just_like_francisco_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay_yay);
	end
endmodule
