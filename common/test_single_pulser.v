`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2016 03:02:47 PM
// Design Name: 
// Module Name: test_single_pulser
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


module test_single_pulser();

wire pulse;
reg
 trigger;
reg
 clock;
reg
 reset;

always
#20 clock = ~clock;

single_pulser sp(
    .pulse(pulse),
    .trigger(trigger),
    .clock(clock),
    .reset(reset)    
    
);

initial
begin    
// ---------- initial -----------
trigger = 0;
clock = 0;
reset = 1;
reset = 0;
#100; 

//----------- start -------------
#40;
#100 trigger = 1;
#100; 
#100 trigger = 0;

#100 trigger = 1;
#100; 
#100 trigger = 0;

#80 reset = 1;
#80 reset = 0;
 
// ----------- 500 clk ---------
#2000 trigger = 1;
#100; 
#200 trigger = 0;

#2000 trigger = 1;
#100; 
#2000 trigger = 0;

#80 reset = 1;
#80 reset = 0;
// ----------- 2000 clk ------------
#8000 trigger = 1;
#100; 
#800 trigger = 0;

#8000 trigger = 1;
#100; 
#8000 trigger = 0;

#80 reset = 1;
#80 reset = 0;


#100;
$stop;
end
endmodule
