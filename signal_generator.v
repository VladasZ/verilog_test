module signal_generator #(parameter DELAY = 2,
						  parameter TIMER_SIZE = 63
						)(input clk,
						  output out);

   reg [TIMER_SIZE:0] counter_d, counter_q;

   wire trigger = counter_q == DELAY - 1 && clk;

   assign out = trigger;

   always @(counter_q)
	 counter_d <= counter_q + 1'b1;

   always @(posedge clk)
	 if (trigger)
	   counter_q <= 0;
	 else
	   counter_q <= counter_d;

   reg 	ready = 0;
   always @(posedge clk) begin
	 if (!ready) begin
		counter_d <=  0;
		counter_q <= -1;
		ready <= 1;
	 end
   end

endmodule
   
