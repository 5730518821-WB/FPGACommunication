// The UART Transmitter module
// by Chaiyapat Julsri
//
// This module transmits the data from FPGA board to UART port

module uart_transmitter(
  // The output data line
  output data_out,

  // The busy line telling the host to hold sending
  output busy,

  // The data to be transmitted, and send signal
  input [7:0] data_in,
  input send,

  // The hold signal for handshaking with the receiver
  input hold,

  // The system clock
  input clock,

  // System reset
  input reset
);

// Redirect wires according to the block diagram
wire shift, load, increment, set;
wire next_bit, all;
wire [15:0] count;

assign all = (count == 10);

uart_transmitter_state uts(busy, shift, load, increment, set, send, hold, all, next_bit, clock, reset);

counter c(count, 16'h0, set, increment, clock, reset);
uart_timer ut(next_bit, set, clock, reset);

wire [10:0] data_sent, data_input;

assign data_input = {1'b1, data_in, 1'b0};
uart_shift_register usr(data_sent, data_input, 1'b1, shift, load, clock, reset);
assign data_out = data_sent[0];

endmodule

