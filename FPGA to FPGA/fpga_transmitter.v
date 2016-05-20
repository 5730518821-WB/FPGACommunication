module fpgaTransmitter(sendToOther,finish,finishSent,dataOut,dataIn,acknowledge,sent,clk,reset);
output sendToOther,finish,finishSent,dataOut;
input acknowledge,sent,clk,reset;
input[7:0] dataIn;

stateForFpgaTran s0(finishSent,finish,sendToOther,resetCounter,increment,load,shift,sent,acknowledge,count8,clk,reset);
assign mode = (load,load or shift);
shift_register sreg0(dataOut,8'b0,dataIn,mode,clk,reset);
counter8 c0(count8,increment,clk,resetCounter);

endmodule