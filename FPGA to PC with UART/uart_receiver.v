module uartRec(dataOut,finish,received,dataIn, clk,reset);
	
output [7:0]dataOut;
output finish,received;
input dataIn,clk,reset;


stateForUartRec s0(resetTimer,resetCounter,increment,shift,finish,received,count8,count9,timetick,dataIn, clk,reset);
uart_timer t0(timetick,resetTimer,clk,1'b0);
counterUartReceiver c0(count8,count9,increment,clk,resetCounter);


wire[1:0] mode;
assign mode = {shift,1'b0};
shift_register sr0(dataOut,8'b0,dataIn,mode,clk,reset);

endmodule