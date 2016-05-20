// The counter module
// by Chaiyapat Julsri

module counter(
  // The data output
  output reg [15:0] data_out,

  // The data input, load signal, and counting signal
  input [15:0] data_in,
  input load,
  input count,

  // The system clock
  input clock,

  // System reset
  input reset

);

// The logic for data_out register
always @(posedge clock) begin
  if (reset) data_out = 0;
  else if (load) data_out = data_in;
  else if (count) data_out = data_out + 1;
  else data_out = data_out;
end

endmodule

