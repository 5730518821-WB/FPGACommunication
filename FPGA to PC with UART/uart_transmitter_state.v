// The UART transmitter state machine
// by Chaiyapat Julsri
//
// This is the logic for UART transmitter

module uart_transmitter_state(
  // Busy signal for handshaking with the host
  output busy,

  // Shift and Load signal for shift register
  output shift,
  output load,

  // Increment and set zero signal for counter
  output increment,
  output set,

  // Sending start signal
  input send,

  // Hold signal for handshaking with receiver
  input rts,

  // All and Next signal from counter and timer
  input all,
  input next,

  // The system clock
  input clock,

  // System reset
  input reset
);

// State transition
// 00: Idle
// 01: Start
// 11: Wait
// 10: Shift
reg [1:0] state, next_state;
wire Idle, Start, Wait, Shift;
assign Idle = (state == 0);
assign Start = (state == 1);
assign Wait = (state == 3);
assign Shift = (state == 2);

always @(*) begin
  if (reset)
    next_state = 0;
  else if (Idle)
    if (rts&send)
      next_state = 1;
    else
      next_state = 0;
  else if (Start)
    next_state = 3;
  else if (Wait)
    if (all)
      next_state = 0;
    else if (next)
      next_state = 2;
    else
      next_state = 3;
  else if (Shift)
    next_state = 3;
  else
    next_state = 0;
end

// Output logic
assign busy = ~Idle;
assign load = Start;
assign set = Start;
assign shift = Shift;
assign increment = Shift;

// State transition
always @(posedge clock)
  state = next_state;

endmodule

