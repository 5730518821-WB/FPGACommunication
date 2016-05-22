module fpga_transmitter(sendToOther,finish,busy,dataOut,dataIn,acknowledge,sent,clock,reset);
output sendToOther,finish,busy,dataOut;
input acknowledge,sent,clock,reset;
input[7:0] dataIn;

wire[7:0] out;

fpga_transmitter_state s0(busy,finish,sendToOther,resetCounter,increment,load,shift,sent,acknowledge,count8,clock,reset);
fpga_shift_register sreg0(out,dataIn,1'b1,shift,load,clock,reset);
fpga_transmitter_counter8bit c0(count8,increment,clock,resetCounter);

assign dataOut = out[0];

endmodule 

