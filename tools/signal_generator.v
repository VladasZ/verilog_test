
`ifndef SIGNAL_GENERATOR_MODULE
`define SIGNAL_GENERATOR_MODULE

module signal_generator #(parameter DELAY = 2,
						  parameter TIMER_SIZE = 63
						  )(input  clk,
							input  rst,
							output reg out);

   reg [TIMER_SIZE:0] counter;

   always @(posedge clk) begin
	  if (rst) begin
		 counter <= 0;
		 out <= 0;
	  end else begin
		 if (counter == DELAY - 1) begin
			out <= 1;
			counter <= 0;
		 end else begin
			out <= 0;
			counter = counter + 1;
		 end
	  end
   end
   
endmodule
   
`endif
