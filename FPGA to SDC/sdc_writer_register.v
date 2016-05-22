module register(sizeAddr,sizeRead,clk,resetCounter);
input[7:0] sizeRead;
input clk,resetCounter;
output[7:0] sizeAddr;

always @(posedge clk)
begin
	if(resetCounter)sizeAddr = 0;
	else sizeAddr = sizeRead;
end

endmodule