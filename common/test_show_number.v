`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2016 10:42:08 PM
// Design Name: 
// Module Name: test_show_number
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


module test_show_number(
    input [3:0] number0,
    input [3:0] number1,
    input [3:0] number2,
    input [3:0] number3,
    input clock,
    output [7:0] ss_out,
    output [3:0] ss_digit
    );
// input
reg [3:0] number0;
reg [3:0] number1;
reg [3:0] number2;
reg [3:0] number3;
//output
wire [7:0] ss_out;
wire [3:0] ss_digit;   

reg clock;

always
#10 clock = ~clock;

show_number sn( 
    .ss_out(ss_out),
    .ss_digit(ss_digit),
    .clock(clock),
    .number0(number0),
    .number1(number1),
    .number2(number2),
    .number3(number3)   
);


initial
begin
// ---------- reset ----------
clock = 0;
number0 = 0; 
number1 = 0;
number2 = 0;
number3 = 0;
ss_digit = 0;
// ----------  reset ---------

#100; 

// ---------- start ---------

#50 number0 = 2;    //  set number        
#50 number1 = 4;    //  set number   
#50 number2 = 8;    //  set number   
#50 number3 = 10;   //  set number   


//-----------------------
#20;
#100 ss_digit = 4'b0111;  // show number  = number 3

#200;                    // wait
#100 ss_digit = 4'b1011; // show number  = number 2

#200;
#100 ss_digit =  4'b1101; // show number = number 1

#200
#100 ss_digit = 4'b1110; // show number = number 0

#200
#100 ss_digit = 0; // show default case

#500;
$stop;

end
    
endmodule
