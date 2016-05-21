module fpga_transmitter(sendToOther,finish,finishSent,dataOut,dataIn,acknowledge,sent,clock,reset);
output sendToOther,finish,finishSent,dataOut;
input acknowledge,sent,clock,reset;
input[7:0] dataIn;

wire[7:0] out;

fpga_transmitter_state s0(finishSent,finish,sendToOther,resetCounter,increment,load,shift,sent,acknowledge,count8,clock,reset);
wire[1:0] mode;
assign mode = {load | shift , load};
shift_register sreg0(out,dataIn,1'b1,mode,clock,reset);
counter8 c0(count8,increment,clock,resetCounter);

assign dataOut = out[0];

endmodule 