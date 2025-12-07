module assignment5 (
	output reg [width - 1 : 0] out,
	input wire [width - 1 : 0] in,
	input wire enable,
	input wire clk
);
	parameter size = 1;
	parameter width = 1;

	reg [width - 1 : 0] items [size - 1 : 0];

	always @(posedge clk) begin
		if (enable) begin
			items[0] <= in;

			for (integer i = 1; i < size; i = i + 1) begin
				items[i] <= items[i - 1];
			end

			out <= items[size - 1];
		end
	end
endmodule
