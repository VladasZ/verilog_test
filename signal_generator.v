module signal_generator #(parameter DELAY = 2
						)(input increment,
						  output reg out = 0);

   reg [7:0] counter = 0;

   wire trigger = counter == DELAY - 1;

  // assign out = trigger;

   always @(negedge increment)
	 out <= 0;

   always @(posedge trigger)
	 out <= 1;

   always @(posedge increment) begin
	 if (trigger) begin
	  // out <= 1;
	   counter <= 0;
	 end else begin
	  counter <= counter + 1;
	 end
   end

endmodule
   
