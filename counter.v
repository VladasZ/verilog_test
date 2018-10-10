module counter(input             clk,
			   input 			 increment,
			   input 			 trigger,
			   output reg [63:0] out = 0);

   reg [63:0] counter_d = 1, counter_q = 0;

   always @(counter_q)
 	  counter_d <= counter_q + 1'b1;

   always @(posedge clk) begin
	  if (trigger) begin
		 counter_q <= 0;
		 out <= counter_q;
	  end else if (increment) begin
		 counter_q <= counter_d;
	  end
   end
  
endmodule
   
// module signal_generator #(parameter DELAY = 2,
// 						  parameter TIMER_SIZE = 63
// 						)(input clk,
// 						  output out);

//    reg [TIMER_SIZE:0] counter_d = 0, counter_q = -1;

//    wire trigger = counter_q == DELAY - 1 && clk;

//    assign out = trigger;

//    always @(counter_q)
// 	 counter_d <= counter_q + 1'b1;

//    always @(posedge clk)
// 	 if (trigger)
// 	   counter_q <= 0;
// 	 else
// 	   counter_q <= counter_d;

// endmodule
