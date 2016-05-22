module uartRec(dataOut,finish,dataIn,clk,reset);
	
output [7:0]dataOut;
output finish;
input dataIn,clk,reset;

reg finish;
reg[7:0] dataOut;

stateForUartRec s0(resetTimer,resetCounter,increment,shift,count8,timetick,dataIn,clk,reset);
timer t0(timetick,resetTimer,clk);
counter8 c0(count8,increment,clk,resetCounter);
reg[1:0] mode;
assign mode = (1'b0,shift);
shift_register sr0(dataOut,8'b0,dataIn,mode,clk,reset);
assign finish = count8;

endmodule