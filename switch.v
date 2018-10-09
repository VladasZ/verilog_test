module switch(input trigger,
			  output reg out = 0);

   always @(posedge trigger)
	 out <= ~out;
   
endmodule
