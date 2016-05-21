// Dual port ram module
// by Chaiyapat Julsri
//
// This is used for data buffering

module dual_port_ram(
  output reg [7:0] data_out,
  input [7:0] data_in,
  input [13:0] read_address,
  input read,
  input read_enable,
  input [13:0] write_address,
  input write,
  input write_enable,
  input clock
);

reg [7:0] ram_data [0:(1<<14)-1];

always @(posedge clock) begin
  if (write&write_enable)
    ram_data[write_address] = data_in;
  if (read&read_enable)
    data_out = ram_data[read_address];
end

endmodule

