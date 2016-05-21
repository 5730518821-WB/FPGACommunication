// The shift register module
// by Chaiyapat Julsri

module shift_register(

  // data_out is the parallel output data
  // data_in_p is the parallel input data
  // data_in_s is the serial input data
  output reg [7:0] data_out,

  input [7:0] data_in_p,
  input data_in_s,

  // Shifting mode
  // 00: Hold
  // 01: Shift left
  // 10: Shift right
  // 11: Load
  input [1:0] mode,

  // The system clock
  input clock,

  // System reset
  input reset
);

// Name the modes into wires for easier coding
wire hold, shift_left, shift_right, load;
assign hold = (mode == 0);
assign shift_left = (mode == 1);
assign shift_right = (mode == 2);
assign load = (mode == 3);

// The logic for data_out register
always @(posedge clock) begin
  if (reset) data_out = 0;
  else if (hold) data_out = data_out;
  else if (shift_left) data_out = {data_out[6:0], data_in_s};
  else if (shift_right) data_out = {data_in_s, data_out[7:1]};
  else if (load) data_out = data_in_p;
  else data_out = data_out;
end

endmodule

