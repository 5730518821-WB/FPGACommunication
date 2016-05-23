module counterData(shift,load,endCRC,block,bytes,count,startCount,byteEnable,clk,resetCounter);
output shift,load,endCRC,block,bytes;
input count,startCount,byteEnable,clk,resetCounter;
	
wire[15:0] countNum;
counter c0(countNum,16'b0,1'b0,count,clk,resetCounter);

assign shift = count;
assign load = startCount | (countNum[2:0] == 3'b1) && (countNum != 1);
assign bytes = (countNum[2:0]==3'b0) & (countNum!=0);
assign block = (countNum[15:0]==(16'b0001_0000_0000_1000));
assign endCRC = (countNum[15:0]==(16'b0001_0000_0001_1000));

endmodule
 

