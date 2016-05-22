module counter8(count8,increment,clk,resetCounter);
input increment,clk,resetCounter;
output count8;

reg[15:0] countNum;
counter c0(countNum,15'b0,1'b0,increment,clk,resetCounter);
assign count8 = (countNum == 8);

endmodule
