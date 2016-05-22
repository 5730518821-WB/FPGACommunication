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
  input pop,
  input push,

  // RAM Enable signal
  input enable,

  // The system clock
  input clock,

  // System reset
  input reset
);

reg [13:0] read_address, write_address;

wire do_pop, do_push;
assign do_pop = pop&(~empty);
assign do_push = push&(~full);

// Connecting to the Dual Port RAM
dual_port_ram dpr(data_out, data_in, read_address, write_address, do_push&enable, clock);

always @(posedge clock) begin
  if (reset) begin
    read_address = 0;
	 write_address = 0;
	 empty = 1;
	 full = 0;
  end
  else if (enable) begin
    if (do_push) begin
      write_address = write_address+1;
      if (write_address == read_address) full = 1;
      empty = 0;
    end
    if (do_pop) begin
      read_address = read_address+1;
      if (read_address == write_address) empty = 1;
      full = 0;
    end
  end
end

endmodule

