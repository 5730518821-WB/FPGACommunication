module stateForUartRec(resetTimer,resetCounter,increment,shift,count8,timetick,dataIn,clk);
output resetTimer,resetCounter,increment,shift;
input count8,timetick,dataIn,clk;

reg resetTimer;
reg resetCounter;
reg increment;
reg shift;
reg[1:0] ps;
reg[1:0] ns;

always @(posedge clk)
begin
	if(reset)ps=0;
	else ps = ns;
end

always @(count8 or timetick or dataIn or ps)
begin
	if(ps == 0)
		begin
			if(dataIn == 1)ns = 0;
			else ns = 1;
		end
	else if(ps == 1)
		begin
			ns = 2;
		end
	else if(ps == 2)
		begin
			if(timetick == 0)ns = 2;
			else ns = 3;
		end
	else if(ps == 3)
		begin
			if(count8 == 1)ns = 0;
			else ns = 2;
		end 
end

always @(ps)
begin
	if(ps == 1)
		begin
			resetTimer = 1;
			resetCounter = 1;
		end
	else if(ps == 3)
		begin
			shift = 1;
			increment = 1;
			resetTimer = 1;
		end
	else
		begin
			resetTimer = 0;
			resetCounter = 0;
			shift = 0;
			increment = 0;
		end
	
end

endmodule