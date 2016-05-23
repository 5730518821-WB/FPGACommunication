// CRC-8 Calculator module
// by Chaiyapat Julsri

module crc8_calculator(
  output reg [7:0] crc,
  input [7:0] data_in,
  input calculate,
  input clear,
  input clock,
  input reset
);

parameter polynomial = {1'b1, 8'h07};
integer i;

reg [8:0] calc;

always @(posedge clock) begin
	if (clear | reset) begin
		calc = 0;
	end
	else if (calculate) begin
		calc = calc ^ {data_in, 1'b0};
		for (i = 0; i < 8; i = i+1) begin
			if (calc[8])
				calc = calc ^ polynomial;
			calc = calc << 1;
		end
		crc = calc[8:1];
	end
end

endmodule

