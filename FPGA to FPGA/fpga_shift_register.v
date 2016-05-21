// The FPGA shift register module
// by Chaiyapat Julsri
//
// for use with FPGA to FPGA transmission

module fpga_shift_register(
  // Parallel data out
  output [7:0] data_out,

  // Parallel and Serial data in
  input [7:0] data_in_p,
  input data_in_s,

  // Shift and load signal
  input shift,
  input load,

  // The system clock
  input clock,

  // System reset
  input reset
);

wire [1:0] mode;
assign mode = {shift|load, load};

shift_register s(data_out, 8'hZ, data_in_s, mode, clock, reset);

endmodule

