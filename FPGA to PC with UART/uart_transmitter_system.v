module uart_transmitter_system(
	output data_out,
	output acknowledge,
	output [7:0] crc8,
	input hold,
	input data_in,
	input send,
	input finish,
	input clear_crc,
	input clock,
	input reset
);

wire [7:0] received_data, running_data;
wire sreceived, received;
wire processed;

wire busy;
wire transmit;

fpga_receiver fr(running_data, received, acknowledge, data_in, processed, send, finish, clock, reset);

fpga_communication_bridge fcb(received_data, processed, transmit, running_data, received, busy, clock, reset);

single_pulser sr(sreceived, received, clock, reset);

crc8_calculator c(crc8, received_data, sreceived, clear_crc, clock, reset);

uart_transmitter ut(data_out, busy, received_data, transmit, hold, clock, reset);

endmodule
