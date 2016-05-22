module counterUartReceiver(count8,count10,increment,clk,resetCounter);
input increment,clk,resetCounter;
output count8,count10;

wire[15:0] countNum;
counter c0(countNum,15'b0,1'b0,increment,clk,resetCounter);
assign count8 = (countNum == 7);
assign count10 = (countNum == 9); 

endmodule
