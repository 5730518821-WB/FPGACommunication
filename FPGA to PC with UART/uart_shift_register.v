// The UART shift register module
// by Chaiyapat Julsri
//
// This module is an 11-bit shift register
// for use with UART transmitter and receiver

module uart_shift_register(
  // These wires are redirected from the UART modules
  output [10:0] data_out,
  input [10:0] data_in_p,
  input data_in_s,
  input shift,
  input load,
  input clock,
  input reset
);

wire [7:0] data_output [1:0];
wire [7:0] data_input [1:0];

assign data_out = {data_output[1], data_output[0][7:5]};
assign {data_input[1], data_input[0]} = {data_in_p, 5'b0};

wire [1:0] mode;
assign mode = {load, load|shift};

shift_register s1(data_output[1], data_input[1], data_in_s, mode, clock, reset);
shift_register s0(data_output[0], data_input[0], data_output[1][0], mode, clock, reset);

endmodule

