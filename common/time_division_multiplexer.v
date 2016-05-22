// The time division multiplexer
// by Chaiyapat Julsri
//
// This is a shifting multiplexer
// for common cathode seven segment display
// with four digits

module time_division_multiplexer(
  output reg [3:0] select,
  input clock
);

wire valid;
assign valid = (select[0]+select[1]+select[2]+select[3] == 3);

wire [15:0] timing;
counter c(timing, 16'hZ, 1'b0, 1'b1, clock, 1'b0);

always @(posedge timing[15])
  if (valid)
    select = {select[0], select[3:1]};
  else
    select = 4'b0111;

endmodule

