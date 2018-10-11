// `include "transmission/data_transmitter.v
`include "generators.v"
// `include "counter.v"

module top(input        clk,
		   input 		rst, //bottom
		   input 		btn1,//top
		   output [2:0] led);

   
   wire 				every_us;
   
   generators generators(.clk(clk), .rst(rst),
						 .every_us(every_us));

   assign led[0] = btn1;//bottom
   assign led[1] = 0;   //top
   assign led[2] = rst; //red
   
 endmodule
