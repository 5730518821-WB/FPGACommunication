module sdcWriter(dataToSdc,bytes,start,empty,sizeRead,dataFromSdc,dataFromRam,clk,reset);
output dataToSdc,bytes;
input start,empty,dataFromSdc,clk,reset;
input[7:0] dataFromRam;
input[7:0] sizeRead;

wire[7:0] dataSelect;
wire[7:0] dataToWrite;
wire[47:0] fullCmd;
wire[31:0] addr;
wire[7:0] response;
wire[7:0] sizeAddr;
wire[7:0] mBytes;

/*state Machine for SDCWriter
output : 
count 			for increment counterData
byteEnable 		for enable bytes sent to RAM
resetCounter 	for reset all counter in this module
loadCmd 			for load cmd from cmdgen to Shift Register
shiftCmd 		for shift cmd in Shift Register to SDC
nextAddr 		for increment address
dataSelect 		for select data package or command to write
tokenSelect 	for select token or data to write data package
oe 				for output enable which will be 1 if there's not in the time to write data
startCount 		for signal to active data counter to load token
input :
start 			for active from idle state
empty				for tell the system to wait data from RAM
endCRC			from data counter tell that it's already run CRC

*/
stateSdcWriter s0(count,byteEnable,resetCounter,loadCmd,shiftCmd,nextAddr,dataSelect,tokenSelect,oe,startCount,start,empty,endCRC,block,response,hasNext,bytes,clk,reset);

wire[1:0] mode1;
assign mode1 = {load | startCount,load | startCount | shift};
shift_register sreg0(dataToWrite,dataSelect,1'b0,mode1,clk,reset);
wire[1:0] mode2;
assign mode2 = {1'b0,1'b1};
shift_register sreg1(response,8'b0,dataFromSdc,mode2,clk,reset);
register regCom0(sizeAddr,sizeRead,clk,resetCounter);
shiftReg48 sreg2(command,loadCmd,shiftCmd,fullCmd,clk,reset);
counterAddr c1(addr,mBytes,nextAddr,clk,resetCounter);
counterData c0(shift,load,endCRC,block,bytes,count,startCount,byteEnable,clk,resetCounter);
commandGen cmdGen(fullCmd,addr);

assign dataSDC = (dataSelect)?dataToWrite[7]:command;
assign dataToSdc = (oe)?dataSDC:1;
assign dataSelect = (tokenSelect)?8'b1111_1110:dataFromRam;
assign hasNext = (sizeAddr > mBytes)?1:0;

endmodule
