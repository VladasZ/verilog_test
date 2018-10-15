
`ifndef INTERVAL_SWITCH_MODULE
`define INTERVAL_SWITCH_MODULE

`include "tools/switch.v"
`include "tools/signal_generator.v"

module interval_switch #(parameter DELAY = 2,
						 parameter TIMER_SIZE = 63
						  )(input  clk,
							input  rst,
							output out);

   wire 						   trigger;
   
   switch switch(clk, rst, trigger, out);
   signal_generator #(.DELAY(DELAY)) signal_generator(clk, rst, trigger);

endmodule

`endif
