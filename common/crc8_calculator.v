// CRC-8 Calculator module
// by Chaiyapat Julsri

module crc8_calculator(
  output [7:0] crc,
  input [7:0] data_in
);

parameter polynomial = {1'b1, 8'h07};
integer i;

reg [8:0] calc;
wire extend;
reg [2:0] count;
assign {crc, extend} = calc;

always @(*) begin
	calc = {data_in, 1'b0};
	for (i = 0; i < 8; i = i+1) begin
		if (calc[8])
			calc = calc ^ polynomial;
		calc = calc << 1;
	end
end

endmodule

