module edge_detector #(parameter FALL = 1,
					   parameter RISE = 1
					   )(input clk,
						 input rst,
						 input signal,
						 output reg out);

   reg 								prev_signal;

   always @(posedge clk) begin
	  if (rst) begin
		 out <= 0;
	  end else if (RISE && signal && !prev_signal) begin
		 out <= 1;
	  end else if (FALL && !signal && prev_signal) begin
		 out <= 1;
	  end else begin
		 out <= 0;
	  end
	  prev_signal <= signal;
   end

endmodule
   
