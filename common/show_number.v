// The Show Number module
// by Chaiyapat Julsri
//
// This module is to make it easier to show numbers on
// FPGA's seven-segment display, and make the code cleaner

module show_number(

  // ss_out is the seven-segment led output
  // ss_digit shows which digit is shown in the display
  output [7:0] ss_out,
  output [3:0] ss_digit,

  // The numbers to be shown
  // For the board used in lab,
  // looking from the side with pushbuttons,
  // number3 is the leftmost digit, and number0 is the rightmost one
  input [3:0] number3,
  input [3:0] number2,
  input [3:0] number1,
  input [3:0] number0,

  // The system clock
  input clock

);

// This reg will indicate what number is actually shown,
// as seen that it is the one connected
// to the seven-segment circuit
reg [3:0] shown_number;
seven_segment s(ss_out, shown_number);

// The TDM will automatically change ss_digit after some time
// so all digits will be shown one-at-a-time
//
// The digits are shown so quickly that our eyes see
// all of them showing constantly
time_division_multiplexer t(ss_digit, clock);

// The logic for shown_number reg
// When the digit changes, the shown_number will change
// Also true when the input numbers do change
//
// If the digit is invalid, the number line will float
// and no digits will be shown
always @(*) begin
  case (ss_digit)
    4'b0111: shown_number = number3;
    4'b1011: shown_number = number2;
    4'b1101: shown_number = number1;
    4'b1110: shown_number = number0;
    default: shown_number = 4'hZ;
  endcase
end

endmodule

