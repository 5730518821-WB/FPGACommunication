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

reg [1:0] state, next_state;
wire Reset, Idle, Clear, Calculate;
assign Reset = (state == 0);
assign Idle = (state == 1);
assign Clear = (state == 2);
assign Calculate = (state == 3);

always @(*) begin
	if (reset)
		next_state = 0;
	else if (Reset)
		next_state = 1;
	else if (Idle) begin
		if (calculate)
			next_state = 3;
		else if (clear)
			next_state = 2;
		else
			next_state = 1;
	end
	else if (Clear)
		next_state = 1;
	else if (Calculate)
		next_state = 1;
	else
		next_state = 0;
end

always @(posedge clock) begin
	if (Clear | Reset) begin
		calc = 0;
		crc = 0;
	end
	else if (Calculate) begin
		calc = calc ^ {data_in, 1'b0};
		for (i = 0; i < 8; i = i+1) begin
			if (calc[8])
				calc = calc ^ polynomial;
			calc = calc << 1;
		end
		crc = calc[8:1];
	end
	state = next_state;
end

endmodule
