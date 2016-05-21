// The FIFO RAM module
// by Chaiyapat Julsri
//
// For data buffering

module fifo_ram(
  // Output data
  output [7:0] data_out,

  // RAM status
  output reg full,
  output reg empty,

  // Input data
  input [7:0] data_in,

  // Read, Write port
  input read,
  input write,

  // RAM Enable signal
  input enable,

  // The system clock
  input clock,

  // System reset
  input reset
);

reg [13:0] read_address, write_address;

wire read_enable, write_enable;
assign read_enable = enable&(~empty);
assign write_enable = enable&(~full);

// Connecting to the Dual Port RAM
dual_port_ram dpr(data_out, data_in, read_address, read, read_enable, write_address, write, write_enable, clock);

always @(posedge clock) begin
  if (read&read_enable) begin
    read_address = read_address+1;
    if (read_address == write_address) empty = 1;
    full = 0;
  end
  if (write&write_enable) begin
    write_address = write_address+1;
    if (write_address == read_address) full = 1;
    empty = 0;
end

endmodule

