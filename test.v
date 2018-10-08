`timescale 1ms/1ms
`include "signal_generator.v"


module test();

   reg clk = 0;
   wire trigger;

  // reg [7:0] timer;
   
   signal_generator #(.DELAY(10)) instance_name(clk, trigger);
   
   initial
	 begin
		$dumpfile("verilog_test.vcd");
		$dumpvars(0, test);

		for (int i = 0; i < 500; i++) begin
		  // trigger = 0;
		   clk = ~clk;
		  // if (i % 10 == 0)
		//	 trigger = 1;
		   #1;
		end
		
	 end

endmodule
