module fpga_communication_bridge(
	output [7:0] data_out,
	output processed,
	output transmit,
	input [7:0] data_in,
	input received,
	input busy,
	input clock,
	input reset
);

reg [1:0] state, next_state;
wire Idle, Transmit, Processed;
assign Idle = (state == 0);
assign Transmit = (state == 1);
assign Processed = (state == 2);

always @(*) begin
	if (reset)
		next_state = 0;
	else if (Idle)
		next_state = received ? 1 : 0;
	else if (Transmit)
		next_state = busy ? 1 : 2;
	else if (Processed)
		next_state = 0;
	else
		next_state = 0;
end

always @(posedge clock)
	state = next_state;
	
assign transmit = Transmit;
assign processed = Processed;

register r(data_out, data_in, received, clock, reset);

endmodule
