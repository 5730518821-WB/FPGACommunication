module fpga_receiver_state(
  // The wires here are redirected from fpga_receiver module
  output received,
  output acknowledge,
  output shift,
  input processed,
  input send,
  input finish,
  input clock,
  input reset
);

// The states, using one hot encoding
reg [5:0] state, next_state;
wire Idle, Start, Wait, Process, End, Receive, Next, Valid;
assign Idle = (state == 0);
assign Start = state[0];
assign Wait = state[1];
assign Process = state[2];
assign End = state[3];
assign Received = state[4];
assign Next = state[5];
assign Valid = (Idle+Start+Wait+Process+End+Received+Next == 1);

// State transitions as shown in ASM chart
always @(*) begin
  if (reset) begin
    next_state = 0;
  end
  else if (~Valid) begin
    next_state = 0;
  end
  else if (Idle) begin
    if (send) next_state = 1;
    else next_state = 0;
  end
  else if (Start) begin
    next_state = 2;
  end
  else if (Wait) begin
    if (send) next_state = 16;
    else if (finish) next_state = 4;
    else next_state = 2;
  end
  else if (Process) begin
    if (processed) next_state = 8;
    else next_state = 4;
  end
  else if (End) begin
    next_state = 0;
  end
  else if (Received) begin
    next_state = 32;
  end
  else if (Next) begin
    next_state = 2;
  end
  else begin
    next_state = 0;
  end
end

always @(posedge clock)
  state = next_state;

// The logic for output signals as shown in ASM chart
assign received = Process;
assign acknowledge = Start | End | Next;
assign shift = Received;

endmodule

