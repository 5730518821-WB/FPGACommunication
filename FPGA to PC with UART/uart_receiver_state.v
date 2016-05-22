module stateForUartRec(resetTimer,resetCounter,increment,shift,finish,count8,count10,timetick,dataIn,clk,reset);
output resetTimer,resetCounter,increment,shift,finish;
input count8,count10,timetick,dataIn,clk,reset;

reg resetTimer;
reg resetCounter;
reg increment;
reg shift;
reg[2:0] ps;
reg[2:0] ns;
reg finish;

always @(posedge clk)
begin
	if(reset)ps=0;
	else ps = ns;
end

always @(count8 or count10 or timetick or dataIn or ps)
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
			if(count8 == 1)ns = 4;
			else ns = 2;
		end
	else if(ps == 4)
		begin
			if(timetick == 0)ns = 4;
			else ns = 5;
		end
	else if(ps == 5)
		begin
			if(count10 == 1)ns = 6;
			else ns = 4;
		end
	else if(ps == 6)ns = 0;
end

always @(ps)
begin
	if(ps == 1 || ps == 3 || ps == 5) resetTimer = 1;
	else resetTimer = 0;
	if(ps == 1)resetCounter = 1;
	else resetCounter = 0;
	if(ps == 3)shift = 1;
	else shift = 0;
	if(ps == 3 || ps == 5)increment = 1;
	else increment = 0;
	if(ps == 6 || ps == 0)finish = 1;
	else finish = 0;
	
end

endmodule 