module sdcWriter(dataToSdc,byte,start,empty,sizeRead,dataFromSdc,dataFromRam,token,clk,reset);
output dataToSDC,byte;
input start,empty,sizeRead,dataFromSDC,clk,reset;
input[7:0] dataFromRam;
input[7:0] token;

reg[7:0] dataSelect;

stateSdcWriter s0(count,byteEnable,resetCounter,loadCmd,shiftCmd,nextAddr,dataSelect,tokenSelect,oe,loadFromState,start,empty,endCRC,block,response,hasNext,byte,clk,reset);
reg[1:0] mode1 = (load or loadFromState,load or loadFromState or shift);
shift_register sreg0(dataToWrite,dataSelect,1'b0,mode1,clk,reset);
reg[1:0] mode2 = (1'b0,1'b1);
shift_register sreg1(response,8'b0,dataFromSdc,mode2,clk,reset);
register regCom0(sizeAddr,sizeRead,clk,resetCounter);
shiftReg48 sreg2(command,loadCmd,shiftCmd,fullCmd,clk,reset);
counterAddr c1(addr,mBytes,nextAddr,clk,resetCounter);
counterData c0(shift,load,endCRC,block,byte,count,byteEnable,clk,resetCounter);
commandGen cmdGen(fullCmd,addr);

assign dataSDC = (dataSelect)?dataToWrite[7]:command;
assign dataToDC = (oe)?dataSDC:1;
assign dataSelect = (tokenSelect)?dataFromRam:token;
assign hasNext = (sizeAddr < mBytes)?1:0;

endmodule
