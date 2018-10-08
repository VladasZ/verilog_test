`timescale 1ms/1ms
`include "top.v"


module test();

   reg clk = 0;
   wire [2:0] led;
   
   top top(clk, led);
   
   initial
	 begin
		$dumpfile("verilog_test.vcd");
		$dumpvars(0, test);
		for (int i = 0; i < 500; i++) begin
		   clk = ~clk; #1;
		end
	 end

endmodule
