`include "signal_generator.v"

module top(input 		clk,
		   output [2:0] led);

   wire 				gen1_signal;
   wire 				gen2_signal;
   wire 				gen3_signal;
   

   
   signal_generator #(.DELAY(50000000)) gen1(clk, gen1_signal);
   signal_generator #(.DELAY(50000000)) gen2(clk, gen2_signal);
   signal_generator #(.DELAY(50000000)) gen3(clk, gen3_signal);
 
   assign led[0] = gen1_signal;
   assign led[1] = gen2_signal;
   assign led[2] = gen3_signal;


endmodule
