module assignment4 (
	output wire pass,
	input wire clk,
	input wire rst
);
	localparam green  = 2'd0;
	localparam yellow = 2'd1;
	localparam red    = 2'd2;

	reg [1:0] light;
	reg [3:0] count;

	assign pass = light != red;

	always @(posedge clk) begin
		if (rst) begin
			light <= green;
			count <= 0;
		end else begin
			case (light)
				green:  if (count >= 5 - 1) begin light <= yellow; count <= 0; end else count <= count + 1;
				yellow: if (count >= 2 - 1) begin light <= red;    count <= 0; end else count <= count + 1;
				red:    if (count >= 7 - 1) begin light <= green;  count <= 0; end else count <= count + 1;
			endcase
		end
	end
endmodule
