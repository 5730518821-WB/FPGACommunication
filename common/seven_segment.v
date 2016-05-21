module seven_segment(
    output reg [7:0] result,  // output is result
    input [3:0] number       //  input is number
    );

always @(*) begin          // show number from case
    case (number)
    4'h0: result = 8'b11111100;
    4'h1: result = 8'b01100000;
    4'h2: result = 8'b11011010;
    4'h3: result = 8'b11110010;
    4'h4: result = 8'b01100110;
    4'h5: result = 8'b10110110;
    4'h6: result = 8'b10111110;
    4'h7: result = 8'b11100000;
    4'h8: result = 8'b11111110;
    4'h9: result = 8'b11110110;
    4'hA: result = 8'b11101110;
    4'hB: result = 8'b00111110;
    4'hC: result = 8'b10011100;
    4'hD: result = 8'b01111010;
    4'hE: result = 8'b10011110;
    4'hF: result = 8'b10001110;
    endcase
end

endmodule
