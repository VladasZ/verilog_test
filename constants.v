//`define SIMULATION

`ifdef SIMULATION
  `define TRANSMITTER_CLOCK_DELAY 10
  `define EVERY_SECOND_DELAY 10000
  `define SEND_DATA_DELAY 10000
`else
  `define TRANSMITTER_CLOCK_DELAY 1000
  `define EVERY_SECOND_DELAY 100000000
  `define SEND_DATA_DELAY `EVERY_SECOND_DELAY
`endif
