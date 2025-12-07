module assignment5 (
	output reg [width - 1 : 0] out,
	input wire [width - 1 : 0] in,
	input wire enable,
	input wire clk
);
	parameter size = 1;
	parameter width = 1;

	reg [size - 1 : 0][width - 1 : 0] items;

	always @(posedge clk) begin
		if (enable) begin
			{out, items[size - 1 : 0]} <= {items[size - 1 : 0], in};
		end
	end
endmodule
