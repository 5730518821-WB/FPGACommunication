module counterData(shift,load,endCRC,block,byte,count,startCount,byteEnable,clk,resetCounter);
output shift,load,endCRC,block,byte;
input count,startCount,byteEnable,clk,resetCounter;
	
reg[15:0] countNum;
counter c0(countNum,16'b0,1'b0,count,clk,resetCounter);

assign shift = count;
assign byte = (countNum[2:0]==3'b0);
assign block = (countNum[15:0]==(16'b0001_0000_0001_0000));
assign endCRC = (countNum[15:0]==(16'b0001_0000_0011_0000));

endmodule


