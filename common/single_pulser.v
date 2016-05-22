module single_pulser(
	output reg pulse,
	input trigger,
	input clock,
	input reset
);

reg pulsing;

always @(posedge clock) begin
	if (reset) begin
		pulse = 0;
		pulsing = 0;
	end
	else if (~pulsing) begin
		if (trigger) begin
			pulse = 1;
			pulsing = 1;
		end
	end
	else if (pulsing) begin
		if (pulse) pulse = 0;
		if (~trigger) pulsing = 0;
	end
	else begin
		pulse = 0;
		pulsing = 0;
	end
end

endmodule
