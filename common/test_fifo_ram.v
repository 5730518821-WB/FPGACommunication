`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2016 11:12:54 PM
// Design Name: 
// Module Name: test_fifo_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_fifo_ram();

wire [7:0] data_out;
wire full;
wire empty;
reg [7:0] data_in;
reg read;
reg write;
reg enable;
reg clock;
reg reset;

reg [13:0] read_address, write_address;

wire read_enable, write_enable;
    
always
#10 clock = ~clock;

fifo_ram f(
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .data_in(data_in),
    .read(read),
    .write(write),
    .enable(enable),
    .clock(clock),
    .reset(reset)
); 


initial
begin    
// -------- reset -------
data_in = 0;
read = 0;
write = 0;
enable = 0;
clock = 0;

reset = 1;
reset = 0;


// -------- reset ------ 
 
#100;                    // wait  to start

// -------- start ------
#20;
// -------- write ------
#50  enable = 1;
#100  write = 1;
#1000;                   // wait  to write
#100  write = 0;
#50  enable = 0;
// ------- read  -------
#50  enable = 1;
#100  read = 1;
#1000;                   // wait  to read
#100  read = 0;
#50  enable = 0;
 
#100;
$stop; 
    
end     
endmodule
