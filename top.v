
module top(input 		clk,
		   output [1:3] led);

   reg [25:0] counter;
   assign led = counter[23:25];

   always @(posedge clk)
	 counter <= counter + 1;

endmodule
