module sdc_shift_register(
	output [47:0] data_out,
	input [47:0] data_in_p,
	input data_in_s,
	input shift,
	input load,
	input clock,
	input reset
);

wire [7:0] data_o [5:0];
wire [7:0] data_i [5:0];
assign data_out = {data_o[5], data_o[4], data_o[3], data_o[2], data_o[1], data_o[0]};
assign {data_i[5], data_i[4], data_i[3], data_i[2], data_i[1], data_i[0]} = data_in_p;

wire [1:0] mode;
assign mode = {load, shift|load};

shift_register s5(data_o[5], data_i[5], data_o[4][7], mode, clock, reset);
shift_register s4(data_o[4], data_i[4], data_o[3][7], mode, clock, reset);
shift_register s3(data_o[3], data_i[3], data_o[2][7], mode, clock, reset);
shift_register s2(data_o[2], data_i[2], data_o[1][7], mode, clock, reset);
shift_register s1(data_o[1], data_i[1], data_o[0][7], mode, clock, reset);
shift_register s0(data_o[0], data_i[0], data_in_s, mode, clock, reset);

endmodule
