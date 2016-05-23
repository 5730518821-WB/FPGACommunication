module counterAddr(addr,mBytes,nextAddr,clk,resetCounter);
input nextAddr,clk,resetCounter;
output[31:0] addr;
output[7:0] mBytes;

wire[31:0] addr;
reg[7:0]mBytes;
wire increase;
counter c0(addr[31:16],16'b0,1'b0,increase,clk,resetCounter);
counter c1(addr[15:0],16'b0,1'b0,nextAddr,clk,resetCounter);
assign increase = (nextAddr && (addr[15:0]=={16{1'b1}}));

always @(posedge clk)
begin
	if(resetCounter)mBytes=0;
	else if(nextAddr)mBytes=mBytes+1;
end
	
endmodule
