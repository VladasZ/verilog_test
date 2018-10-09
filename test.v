`timescale 1ns/1ns
`include "top.v"


module test();

   reg clk = 0;
   wire transmission;
   wire clock;
   wire data;
   wire [2:0] led;
   
   top top(clk,
		   transmission, 
		   clock,
		   data,
		   led
		   );
   
   initial
	 begin
		$dumpfile("verilog_test.vcd");
		$dumpvars(0, test);
		for (int i = 0; i < 100000; i++) begin
		   clk = ~clk; #1;
		end
	 end

endmodule
