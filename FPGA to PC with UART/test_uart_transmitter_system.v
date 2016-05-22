`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:25:20 05/22/2016
// Design Name:   uart_transmitter_system
// Module Name:   D:/workSpace/HDL/verilog/FPGAproject/FPGAprojectISE/test_uart_transmitter_system.v
// Project Name:  FPGAprojectISE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_transmitter_system
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_uart_transmitter_system;

	// Inputs
	reg hold;
	reg data_in;
	reg send;
	reg finish;
	reg clock;
	reg reset;

	// Outputs
	wire data_out;
	wire acknowledge;
	wire [7:0] crc8;
	
	parameter CLOCK_WIDTH = 40;
	
	always
		#(CLOCK_WIDTH/2) clock = ~clock;
		
	reg [7:0]s;	

	// Instantiate the Unit Under Test (UUT)
	uart_transmitter_system uut (
		.data_out(data_out), 
		.acknowledge(acknowledge), 
		.crc8(crc8), 
		.hold(hold), 
		.data_in(data_in), 
		.send(send), 
		.finish(finish), 
		.clock(clock), 
		.reset(reset)
	);
	
	task send_and_wait;
	begin
		#CLOCK_WIDTH send = 1;
		#CLOCK_WIDTH send = 0;
		while(!acknowledge) #CLOCK_WIDTH;
	end
	endtask
	
	integer i;
	task transmit;
	input [7:0] sent_data;
	begin
		send_and_wait();
		for (i = 0; i < 8; i = i+1) begin
			#CLOCK_WIDTH data_in = sent_data[i];
			send_and_wait();
		end
		#CLOCK_WIDTH finish = 1;
		#CLOCK_WIDTH finish = 0;
		while(!acknowledge) #CLOCK_WIDTH;
	end
	endtask

	initial begin
		// Initialize Inputs
		hold = 0;
		data_in = 0;
		send = 0;
		finish = 0;
		clock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#100 reset = 1;
		#100 reset = 0;
		#600;
        
		// Add stimulus here
		
		s = 0 ; transmit(s);
		s = 1 ; transmit(s);
		s = 2 ; transmit(s);
		s = 4 ; transmit(s);
		s = 8 ; transmit(s);
		s = 16 ; transmit(s);
		s = 32 ; transmit(s);
		s = 64 ; transmit(s);
		s = 128 ; transmit(s);
		s = 255 ; transmit(s);
		s = 3 ; transmit(s);
		s = 5 ; transmit(s);
		s = 7 ; transmit(s);
		s = 11 ; transmit(s);
		s = 13 ; transmit(s);
		s = 17 ; transmit(s);
		s = 21 ; transmit(s);
		#100;
		$stop;
	
	end
      
endmodule

