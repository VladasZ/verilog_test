`timescale 1ns/1ns
`include "top.v"


module test();

   reg clk = 0;
   reg rst = 0;
   reg btn1 = 0;
   wire transmission;
   wire clock;
   wire data;
   wire [2:0] led;
   
   top top(clk,
		   rst,
		   btn1,
		   led
		   );
   
   initial
	 begin
		$dumpfile("verilog_test.vcd");
		$dumpvars(0, test);
		clk = ~clk;	#1;
		rst <= 1; clk = ~clk; #1;
		rst <= 0; clk = ~clk; #1;
		for (int i = 0; i < 500000; i++) begin
		   clk = ~clk; #1;
		end
	 end

endmodule
