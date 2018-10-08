module signal_generator(input clk,
						output [7:0] out);

   reg [7:0] counter = 0;

   assign out = counter;

   always @(posedge clk)
	 counter = counter + 1;

endmodule
   
