module counter(input 			 increment,
			   input 			 trigger,
			   output reg [63:0] out = 0);

   reg [63:0] counter = 0;
   reg [63:0] prev_value = -1;

   always @(posedge increment)
	 counter <= counter + 1;

   always @(posedge trigger) begin
	  prev_value <= counter;
	  out <= counter - prev_value;
   end
  
endmodule
   
