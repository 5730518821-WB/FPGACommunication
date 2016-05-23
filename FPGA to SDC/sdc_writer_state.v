module stateSdcWriter(count,byteEnable,reset,loadCmd,shiftCmd,nextAddr,dataSelect,tokenSelect,oe,startCountData,start,empty,endCRC,block,response,hasNext,bytes,clk,resetAll);
output count,byteEnable,reset,loadCmd,shiftCmd,nextAddr,dataSelect,tokenSelect,oe,startCountData;
input start,empty,endCRC,block,hasNext,bytes,clk,resetAll;
input[7:0] response;

wire[7:0] response;
reg[3:0] ps;
reg[3:0] ns;
reg oe;
reg count,byteEnable,reset,loadCmd,shiftCmd,nextAddr,dataSelect,tokenSelect,startCountData;

always @(posedge clk)
begin
	if(resetAll)ps=0;
	else ps = ns;
end

always @(response or start or empty or endCRC or block or bytes or hasNext or ps)
begin
	if(ps == 0)ns = start?1:0;
	if(ps == 1)ns = 2;
	if(ps == 2)
		begin
			if(hasNext)ns=(empty==0 && response == 8'b11111111)?3:2;
			else ns = 0;
		end
	if(ps == 3)ns = 4;
	if(ps == 4)
		begin
			if(response == 8'b0)ns = 10;
			else if(response[7] == 1)ns = 4;
			else ns = 3;
		end
	if(ps == 10)ns = (response == 8'b11111111)?5:10;
	if(ps == 5)ns = 6;
	if(ps == 6)ns = (bytes)?7:6;
	if(ps == 7)ns = (block)?8:7;
	if(ps == 8)ns = (endCRC)?9:8;
	if(ps == 9)ns = 2;
end

always @(ps)
begin
	if(ps == 1)reset = 1;
	else reset =0;
	if(ps == 3)loadCmd = 1;
	else loadCmd = 0;
	if(ps == 4)shiftCmd = 1;
	else shiftCmd = 0;
	if(ps == 5)tokenSelect = 1;
	else tokenSelect = 0;
	if(ps == 5)startCountData = 1;
	else startCountData = 0;
	if(ps == 6 || ps == 7|| ps == 8)count=1;
	else count = 0;
	if(ps == 6 || ps == 7|| ps == 8)dataSelect=1;
	else dataSelect = 0;
	if(ps == 6 || ps == 7)byteEnable=1;
	else byteEnable = 0;
	if(ps == 9) nextAddr = 1;
	else nextAddr = 0;
	if(ps == 3 || ps == 4 || ps == 5 || ps == 6 || ps == 7 || ps == 8)oe=1;
	else oe = 0;
end

endmodule 