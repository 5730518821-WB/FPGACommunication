module commandGen(fullCmd,addr);
input[31:0] addr;
output[47:0] fullCmd;

assign fullCmd = (2'b0101100,addr,11111111);

endmodule