`include "signal_generator.v"
`include "switch.v"

module top(input 		clk,
		   input 		button_in,
		   output [2:0] led);

   wire 				button = ~button_in;

   wire 				gen1_signal;
   wire 				gen2_signal;
   wire 				gen3_signal;

   wire 				switch1_signal;
   wire 				switch2_signal;
   wire 				switch3_signal;
   
   
   switch switch1(gen1_signal, switch1_signal);
   switch switch2(gen2_signal, switch2_signal);
   switch switch3(gen3_signal, switch3_signal);

   signal_generator #(.DELAY(100000000)) gen1(clk, gen1_signal);
   signal_generator #(.DELAY(10000000)) gen2(clk, gen2_signal);
   signal_generator #(.DELAY(1000000)) gen3(clk, gen3_signal);
 
   assign led[0] = switch1_signal;
   assign led[1] = switch2_signal;
   assign led[2] = switch3_signal;
   
 endmodule
