module signal_generator #(parameter DELAY = 2,
						  parameter TIMER_SIZE = 31
						)(input increment,
						  output out);

   reg [TIMER_SIZE:0] counter = 0;

   wire trigger = counter == DELAY - 1;

   assign out = trigger;

   always @(posedge increment)
	 if (trigger)
	   counter <= 0;
	 else
	  counter <= counter + 1;

endmodule
   
