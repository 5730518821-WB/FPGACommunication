module uart_transmitter_system_io(
	output data_out,
	output acknowledge,
	output [7:0] ss_result,
	output [3:0] ss_digit,
	input hold,
	input data_in,
	input send,
	input finish,
	input clock,
	input nreset
);

wire [7:0] crc8;

show_number sn(ss_result, ss_digit, 4'h0, 4'h0, crc8[7:4], crc8[3:0], clock);

uart_transmitter_system uts(data_out, acknowledge, crc8, hold, data_in, send, finish, clock, ~nreset);

endmodule
