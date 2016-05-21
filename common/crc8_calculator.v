// CRC-8 Calculator module
// by Chaiyapat Julsri

module crc8_calculator(
  output reg [7:0] crc,
  output finish,
  input [7:0] data_in,
  input calculate,
  input clock,
  input reset
);

parameter polynomial = {1'b1, 8'h07};

reg extend;
reg [2:0] count;

reg [1:0] state, next_state;
wire Idle, Load, Divide, Shift;
assign Idle = (state == 0);
assign Load = (state == 1);
assign Divide = (state == 3);
assign Shift = (state == 2);

always @(*) begin
  if (reset)
    next_state = 0;
  else if (Idle)
    next_state = calculate ? 1 : 0;
  else if (Load)
    next_state = 3;
  else if (Divide)
    next_state = (count == 7) ? 2 : 0;
  else if (Shift)
    next_state = 3;
  else
    next_state = 0;
end

always @(posedge clock) begin
  if (reset)
    ;
  else if (Load) begin
    crc = data_in;
    extend = 0;
    count = 0;
  end
  else if (Divide) begin
    if (crc[7])
      {crc, extend} = {crc, extend} ^ polynomial;
    count = count + 1;
  end
  else if (Shift) begin
    crc = crc << 1;
    crc[0] = extend;
    extend = 0;
  end
end

endmodule

