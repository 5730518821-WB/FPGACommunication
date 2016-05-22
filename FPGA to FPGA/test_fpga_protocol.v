`timescale 1ns/1ns

module test_fpga_protocol();

reg [7:0] sent_data;
reg start, processed;
wire busy;

wire [7:0] data_out;
wire received;

reg clock, reset;

fpga_protocol fp(
	.data_out(data_out),
	.received(received),
	.busy(busy),
	.data_in(sent_data),
	.start(start),
	.processed(processed),
	.clock(clock),
	.reset(reset)
);

always
	#20 clock = ~clock;
	
task transmit;
input [7:0] data;
begin
	#100 sent_data = data;
	#100 start = 1;
	#100 start = 0;
	while (~received) #100;
	#100 processed = 1;
	#100 processed = 0;
	while (busy) #100;
	#100;
end
endtask


initial
begin
clock = 0;
reset = 0;
sent_data = 0;
start = 0;
processed = 0;

// ------------- reset ------------

#100 reset = 1;
#200 reset = 0;
#100;


// ------------- start ------------
transmit(45);
transmit(2);
transmit(4);
transmit(8);
transmit(16);
transmit(32);
transmit(64);
transmit(128);
transmit(255);
transmit(99);
transmit(3);

// -------------- end -------------

#100 ;
$stop;

end

endmodule
