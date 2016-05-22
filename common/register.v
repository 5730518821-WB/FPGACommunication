module register(
	output [7:0] data_out,
	input [7:0] data_in,
	input enable,
	input clock,
	input reset
);

wire [1:0] mode;
assign mode = {enable, enable};

shift_register sr(data_out, data_in, 1'bZ, mode, clock, reset);

endmodule
