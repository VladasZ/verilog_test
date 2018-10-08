module signal_generator #(parameter DELAY = 2,
						  parameter TIMER_SIZE = 31
						)(input increment,
						  output reg out = 0);

   reg [TIMER_SIZE:0] counter = 0;

   wire trigger = counter == DELAY - 1;

   always @(negedge increment)
	 out <= 0;

   always @(posedge trigger)
	 out <= 1;

   always @(posedge increment)
	 if (trigger)
	   counter <= 0;
	 else
	  counter <= counter + 1;

endmodule
   
