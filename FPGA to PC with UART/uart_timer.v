module uart_timer(timetick,resetTimer,clk,reset);
output timetick;
input resetTimer,clk,reset;

reg timetick;
reg[20:0] count;

always @(posedge clk)
begin
	if(resetTimer or reset)begin count=0;timetick=0; end
	else if(timetick)
		begin 
			timetick=0;
			count = 0;
		end
	else if(count==83333)timetick=1;
	else count=count+1;
end

endmodule 