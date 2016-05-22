// Dual port ram module
// by Chaiyapat Julsri
//
// This is used for data buffering

module dual_port_ram(
  data_out,
  data_in,
  read_address,
  write_address,
  write_enable,
  clock
);

	parameter RAM_WIDTH = 8;
   parameter RAM_ADDR_BITS = 14;

   (* RAM_STYLE="{AUTO | BLOCK |  BLOCK_POWER1 | BLOCK_POWER2}" *)
   reg [RAM_WIDTH-1:0] ram_data [(2**RAM_ADDR_BITS)-1:0];
   output reg [RAM_WIDTH-1:0] data_out;

   input [RAM_ADDR_BITS-1:0] read_address, write_address;
   input [RAM_WIDTH-1:0] data_in;
	input write_enable;
	
	input clock;

   always @(posedge clock) begin
      if (write_enable)
         ram_data[write_address] <= data_in;
      data_out <= ram_data[read_address];
   end

endmodule

