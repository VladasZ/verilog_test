module switch(input      rst,
			  input 	 trigger,
			  output reg out);

   always @(posedge trigger)
	 if (rst)
	   out <= 0;
	 else
	   out <= ~out;
   
endmodule
