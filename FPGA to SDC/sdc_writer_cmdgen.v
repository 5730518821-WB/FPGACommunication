module commandGen(fullCmd,addr);
input[31:0] addr;
output[47:0] fullCmd;

wire[47:0] fullCmd;
wire[31:0] addr;
assign fullCmd = {8'b01011000,{addr},8'b1111_1111};

endmodule