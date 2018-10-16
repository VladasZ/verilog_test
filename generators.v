`include "constants.v"
`include "tools/interval_switch.v"

`define MULTIPLIER 1

module generators(input  clk,
				  input  rst,
				  output clk_ten,
				  output clk_hundred,
				  output clk_thousand,
				  output every_us,
				  output every_second,
				  output ten_per_second,
				  output hundred_per_second,
				  output transmitter_output_clock);

   wire 				 clk_ten_wire;
   wire 				 clk_hundred_wire;
   wire 				 clk_thousand_wire;
   wire 				 every_us_wire;
   wire 				 every_second_wire;
   wire 				 ten_per_second_wire;
   wire 				 hundred_per_second_wire;

   
   signal_generator #(.DELAY(10                 )) clk_ten_generator            (clk, rst, clk_ten_wire);
   signal_generator #(.DELAY(100                )) clk_hundred_generator        (clk, rst, clk_hundred_wire);
   signal_generator #(.DELAY(1000               )) clk_thousand_generator       (clk, rst, clk_thousand_wire);
   signal_generator #(.DELAY(100                )) every_us_generator           (clk, rst, every_us_wire);
   signal_generator #(.DELAY(`EVERY_SECOND_DELAY)) every_second_generator       (clk, rst, every_second_wire);
   signal_generator #(.DELAY(1000000            )) ten_per_second_generator     (clk, rst, ten_per_second_wire);
   signal_generator #(.DELAY(100000             )) hundred_per_second_generator (clk, rst, hundred_per_second_wire);
   
   
   assign clk_ten                   = clk_ten_wire;
   assign clk_hundred               = clk_hundred_wire;
   assign clk_thousand              = clk_thousand_wire;
   assign every_us                  = every_us_wire;
   assign every_second              = every_second_wire;
   assign ten_per_second            = ten_per_second_wire;
   assign hundred_per_second        = hundred_per_second_wire;
   
endmodule
