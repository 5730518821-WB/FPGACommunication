// The FPGA shift register module
// by Chaiyapat Julsri
// for use with FPGA to FPGA transmission

module fpga_shift_register(
  // Parallel data out
  output [7:0] data_out,

  // Serial data in
  input data_in,

  // Shift signal
  input shift,

  // The system clock
  input clock,

  // System reset
  input reset
);

wire [1:0] mode;
assign mode = {shift, 1'b0}

shift_register s(data_out, 8'hZ, data_in, mode, clock, reset);

endmodule

