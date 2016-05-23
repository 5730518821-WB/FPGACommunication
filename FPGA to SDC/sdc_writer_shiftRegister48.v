module shiftReg48(command,loadCmd,shiftCmd,fullCmd,clk,reset);
output command;
input loadCmd,shiftCmd,clk,reset;
input[47:0] fullCmd;

wire[7:0] data0;
wire[7:0] data1;
wire[7:0]data2;
wire[7:0]data3;
wire[7:0]data4;
wire[7:0]data5;
wire[1:0] mode;
assign mode = {loadCmd , loadCmd | shiftCmd};
shift_register sreg0(data0,fullCmd[47:40],data1[7],mode,clk,reset);
shift_register sreg1(data1,fullCmd[39:32],data2[7],mode,clk,reset);
shift_register sreg2(data2,fullCmd[31:24],data3[7],mode,clk,reset);
shift_register sreg3(data3,fullCmd[23:16],data4[7],mode,clk,reset);
shift_register sreg4(data4,fullCmd[15:8],data5[7],mode,clk,reset);
shift_register sreg5(data5,fullCmd[7:0],1'b1,mode,clk,reset);
assign command = data0[7];

endmodule