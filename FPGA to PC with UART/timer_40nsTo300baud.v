module timer(timetick,resetTimer,clk);
output timetick;
input resetTimer,clk;

reg timetick;
reg[20:0] count;

always @(posedge clk)
begin
	if(resetTimer)count=0;
	else if(timetick)
		begin 
			timetick=0;
			count = 0;
		end
	else if(count=83333)timetick=1;
	else count=count+1;
end

endmodule