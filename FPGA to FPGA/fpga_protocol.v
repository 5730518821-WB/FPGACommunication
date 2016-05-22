module fpga_protocol(
	output [7:0] data_out,
	output received,
	output busy,
	input [7:0] data_in,
	input start,
	input processed,
	input clock,
	input reset
);

// Communication lines
wire send, acknowledge, finish, data_line;

fpga_transmitter ft(send, finish, busy, data_line, data_in, acknowledge, start, clock, reset);
fpga_receiver fr(data_out, received, acknowledge, data_line, processed, send, finish, clock, reset);

endmodule
