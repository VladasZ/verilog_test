`timescale 1ms/1ms
`include "signal_generator.v"


module test();

   reg clk = 0;

   reg [7:0] timer;
   
   signal_generator instance_name(clk, timer);
   
   
   initial
	 begin
		$dumpfile("verilog_test.vcd");
		$dumpvars(0, test);


		for (int i = 0; i < 50; i++) begin
		   clk = ~clk; #1;
		end
		
	 end

endmodule
