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
    
always
#20 clock = ~clock;

fifo_ram f(
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .data_in(data_in),
    .pop(read),
    .push(write),
    .enable(enable),
    .clock(clock),
    .reset(reset)
); 

task writeData;
input [7:0] wd ;
begin 
#40 data_in = wd;
#40 write = 1;
#40 write = 0;
#100;
end
endtask

task readData;
begin
#40 read = 1;
#40 read = 0;
#100;
end
endtask

initial
begin    
// -------- initial -------
data_in = 0;
read = 0;
write = 0;
enable = 0;
clock = 0;

#100 reset = 1;
#100 reset = 0;


 
#100;                    // wait  to start

// -------- start ------
#20;
// -------- write ------
#40  enable = 1;
writeData(1);
writeData(2);
writeData(4);
writeData(8);
writeData(16);
writeData(32);
writeData(64);
writeData(128);
writeData(255);
writeData(112);
writeData(44);
#40  enable = 0;
// ------- read  -------
#50  enable = 1;
readData();
readData();
readData();
readData();
readData();
readData();
readData();
readData();
readData();
readData();
readData();
#50  enable = 0;
//-------  reset ---------
#40 reset = 1;
#40 reset = 0;

//------- pre-write ------
#50 enable = 1;
writeData(11);
writeData(15);
writeData(19);
writeData(23);
#50 enable = 0;
//
// --------  write + unenable-------

writeData(2);
writeData(3);
writeData(5);
writeData(7);

// ---------- read + unenable  -----------

readData();
readData();
readData();
readData();

// ----------- post-read --------

#50 enable = 1;
readData();
readData();
readData();
readData();
readData();
readData();
readData();
readData();
#50 enable = 0;

// ----------- reset ------------
#40 reset = 1;
#40 reset = 0;

// ---------- write full -----------
#40  enable = 1;
while(!full) begin
writeData(8);
end
#40  enable = 0;
// ---------- try to write more !! --------
#40  enable = 1;
writeData(9);
writeData(9);
writeData(9);
#40  enable = 0;
// ---------- read full -------------
#40  enable = 1;
while(!empty) begin
readData();
end
readData();
readData();
readData();
#40  enable = 0;
#100;
// ----------- reset ------------
#40 reset = 1;
#40 reset = 0;

#100;
$stop; 
    
end     
endmodule
