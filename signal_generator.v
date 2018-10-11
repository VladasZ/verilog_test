module signal_generator #(parameter DELAY = 2,
						  parameter TIMER_SIZE = 63
						  )(input  clk,
							input  rst,
							output out);

   reg [TIMER_SIZE:0] counter_d, counter_q;

   wire trigger = counter_q == DELAY - 1 && clk;

   assign out = trigger;

   always @(counter_q)
	 counter_d <= counter_q + 1'b1;

   always @(posedge clk)
	 if (trigger || rst)
	   counter_q <= 0;
	 else
	   counter_q <= counter_d;

endmodule
   
