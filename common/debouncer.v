module debouncer(
	output reg debounced,
	input switch,
	input clock,
	input reset
);

wire [15:0] timing;

counter c(timing, 16'hZ, 1'b0, 1'b1, clock, reset);

always @(posedge timing[15])
	debounced = switch;

endmodule
