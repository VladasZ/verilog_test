module counter(input             clk,
			   input 			 rst,
			   input 			 increment,
			   input 			 trigger,
			   output reg [63:0] out);

   reg [63:0] 					 counter;

   always @(posedge clk) begin
	  if (rst) begin
		 out <= 0;
		 counter <= 0;
	  end else if (trigger) begin
		 out <= counter;
		 counter <= 0;
	  end else if (increment) begin
		 counter = counter + 1;
	  end
   end
  
endmodule
