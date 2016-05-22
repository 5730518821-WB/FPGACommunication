module sdc_cmd(
  output [47:0] cmd,
  input [31:0] address,
  input nread_write
);

wire [5:0] index;
assign index = (nread_write) ? 6'd24 : 6'd17;
assign cmd = {2'b01, index, address, 8'hFF};

endmodule

