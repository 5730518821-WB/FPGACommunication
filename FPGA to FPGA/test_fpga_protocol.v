module test_fpga_protocol();

reg [7:0] sent_data;
reg start;
wire busy;

wire send, acknowledge, data_bit, finish;

wire [7:0] data_out;
wire received;

reg clock;

// fpga_transmitter ft(send, data_bit, finish, busy, sent_data, start, acknowledge, clock);
// fpga_receiver fr(data_out, received, acknowledge, send, data_bit, finish, clock);

always
#10 clock = ~clock;

initial
begin
clock = 0;
sent_data = 0;
start = 0;


// ------------- start ------------
#100 sent_data = 8'b00000001;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 1 round---------

#100 sent_data = 8'b0000_0010;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 2 round---------



#100 sent_data = 8'b0000_0100;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 3 round---------



#100 sent_data = 8'b0000_1000;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 4 round---------



#100 sent_data = 8'b0001_0000;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 5 round---------



#100 sent_data = 8'b0010_0000;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 6 round---------



#100 sent_data = 8'b0100_0000;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 7 round---------



#100 sent_data = 8'b1000_0000;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 8 round---------
// ------- end test 1bits *8 shift ------------



#100 sent_data = 8'b0001_0001;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 9 round---------



#100 sent_data = 8'b0010_0010;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 10 round---------



#100 sent_data = 8'b0100_0100;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 11 round---------



#100 sent_data = 8'b1000_1000;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 12 round---------
// ------- end test 2bits *4 ------------



#100 sent_data = 8'b0101_0101;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 13 round---------



#100 sent_data = 8'b1010_1010;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 14 round---------
// -------- end 4 bit shift *2 -----------

#150 ;

#100 sent_data = 8'b1111_1111;
#100 start = 1;
#100 start = 0;
while (busy) #100;
#100 ;
// ------- end 15 round---------

#100 ;
$stop;

end

endmodule