
`include "signal_generator.v"


//`define MULTIPLIER 0.0001
`define MULTIPLIER 1

module generators(input clk,
				  output every_second,
				  output ten_per_second,
				  output every_us);

   wire 				 every_second_wire;
   wire 				 ten_per_second_wire;
   wire 				 every_us_wire;

   signal_generator #(.DELAY(100000000 * `MULTIPLIER)) every_second_generator  (clk, every_second_wire);
   signal_generator #(.DELAY(10000000 * `MULTIPLIER))  ten_per_second_generator(clk, ten_per_second_wire);
   signal_generator #(.DELAY(100 * `MULTIPLIER))       every_us_generator      (clk, every_us_wire);

   assign every_second   = every_second_wire;
   assign ten_per_second = ten_per_second_wire;
   assign every_us       = every_us_wire;

endmodule
