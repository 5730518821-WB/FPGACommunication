// FPGA Receiver module
// by Chaiyapat Julsri
// Using for FPGA to FPGA transmission from an FPGA transmitter

module fpga_receiver(
  
  // Data received, to be sent out to other systems
  output [7:0] data_out,

  // received is telling other system that a new data is ready
  // acknowledge tells the transmitter that the data is received
  output received,
  output acknowledge,

  // the data line, received serially
  input data,

  // processed is from other system telling that the data is used
  input processed,

  // send and finish is for transmitter to tell that the data is sending
  input send,
  input finish,

  // the system clock
  input clock,

  // system reset
  input reset
);

wire shift;

// redirecting the wires as shown in block diagram
fpga_receiver_state rs(received, acknowledge, shift, processed, send, finish, clock, reset);
fpga_shift_register sr(data_out, data, shift, clock, reset);

endmodule

