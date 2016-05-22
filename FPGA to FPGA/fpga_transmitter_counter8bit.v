module fpga_transmitter_counter8bit(count8,increment,clk,resetCounter);
input increment,clk,resetCounter;
output count8;

wire[15:0] countNum;
counter c0(countNum,16'b0,1'b0,increment,clk,resetCounter);
assign count8 = (countNum == 7);

endmodule

