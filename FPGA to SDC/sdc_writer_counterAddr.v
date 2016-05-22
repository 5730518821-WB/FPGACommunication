module counterAddr(addr,mBytes,nextAddr,clk,resetCounter);
input nextAddr,clk,resetCounter;
output[31:0] addr;
output[7:0] mBytes;

reg[31:0]addr;
reg[7:0]mBytes;
reg increase;
counter c0(addr[31:16],16'b0,1'b0,increase,clk,resetCounter);
counter c1(addr[15:0],16'b0,1'b0,nextAddr,clk,resetCounter);

always @(posedge clk)
begin
	if(resetCounter)mBytes=0;
	else if(nextAddr)
		begin
			mBytes=mBytes+1;
			if(addr[15:0]=={16{1'b1}})increase = 1;
			else increase = 0;
		end
end
	
endmodule
