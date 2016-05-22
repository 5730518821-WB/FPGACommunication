module register(sizeAddr,sizeRead,clk,resetCounter);
input[7:0] sizeRead;
input clk,resetCounter;
output[7:0] sizeAddr;

reg[7:0] sizeAddr;
always @(posedge clk)
begin
	sizeAddr = sizeRead;
end

endmodule