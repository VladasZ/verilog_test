module signal_generator(input increment,
						input trigger,
						output reg [7:0] out = 0);

   reg [7:0] counter = 0;

   always @(posedge trigger)
	 out = counter;
   
   always @(posedge increment)
	 counter = counter + 1;

endmodule
   
