
`include "signal_generator.v"
`include "switch.v"


//`define MULTIPLIER 0.01
`define MULTIPLIER 1

module generators(input clk,
				  output every_us,
				  output every_second,
				  output every_second2,
				  output every_second_switch,
				  output ten_per_second,
				  output hundred_per_second,
				  output transmitter_clock,
				  output transmitter_output_clock);

   wire 				 every_us_wire;
   wire 				 every_second_wire;
   wire 				 every_second_wire2;
   wire 				 every_second_switch_wire;
   wire 				 ten_per_second_wire;
   wire 				 hundred_per_second_wire;
   
   wire 				 transmitter_clock_wire;
   wire 				 transmitter_output_clock_wire;

   signal_generator #(.DELAY(100       * `MULTIPLIER)) every_us_generator           (clk, every_us_wire);
   signal_generator #(.DELAY(100000000 * `MULTIPLIER)) every_second_generator       (clk, every_second_wire);
   signal_generator #(.DELAY(100000000 * `MULTIPLIER)) every_second_generator2       (clk, every_second_wire2);
   signal_generator #(.DELAY(1000000   * `MULTIPLIER)) ten_per_second_generator     (clk, ten_per_second_wire);
   signal_generator #(.DELAY(100000    * `MULTIPLIER)) hundred_per_second_generator (clk, hundred_per_second_wire);
   signal_generator #(.DELAY(1000      * `MULTIPLIER)) transmitter_clock_generator  (clk, transmitter_clock_wire);

   switch every_second_sww(every_second_wire, every_second_switch_wire);
   switch transmitter_cloc_sww(transmitter_clock_wire, transmitter_output_clock_wire);
   
   assign every_us                  = every_us_wire;
   assign every_second              = every_second_wire;
   assign every_second2              = every_second_wire2;
   assign every_second_switch       = every_second_switch_wire;
   assign ten_per_second            = ten_per_second_wire;
   assign hundred_per_second        = hundred_per_second_wire;
   assign transmitter_clock         = transmitter_clock_wire;
   assign transmitter_output_clock  = transmitter_output_clock_wire;
   

endmodule
