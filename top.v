`include "transmission/data_transmitter.v"
`include "generators.v"
`include "counter.v"

module top(input  clk,
		   output transmission,
		   output clock,
		   output data,
		   output [2:0] led);

   wire 				every_us;
   wire 				every_second;
   wire 				every_second2;
   wire 				ten_per_second;				
   wire 				hundred_per_second;			

   wire 				transmitter_clock;
   wire 				transmitter_output_clock;				

   wire 				every_second_switch;

   wire [63:0] 			us_in_second;

   reg [7:0] 			test_data = 0;

   generators generators(.clk(clk),
						 .every_us(every_us),
						 .every_second(every_second),
						 .every_second2(every_second2),
						 .every_second_switch(every_second_switch),
						 .ten_per_second(ten_per_second),
						 .hundred_per_second(hundred_per_second),
						 .transmitter_clock(transmitter_clock),
						 .transmitter_output_clock(transmitter_output_clock));

   counter seconds_counter(.clk(clk),
						   .increment(every_us),
   						   .trigger(transmitter_clock),
   						   .out(us_in_second));

   data_transmitter data_transmitter(.clk(clk),
   									 .serial_clk(transmitter_clock),
   									 .send(every_second2),
   									 //.busy(X),
   									 .data(us_in_second),
   									 .transmission(transmission),
   									 .out_data(data));

   // serial_transmitter serial_transmitter(.clk(clk),
   // 										 .transmission_clock(transmitter_clock),
   // 										 .send(hundred_per_second),
   // 										 .in_data(test_data),
   // 										 .transmission(transmission),
   // 										 .out_data(data));
   
   assign led[0] = 1;
   assign led[1] = every_second_switch;
   assign led[2] = 1;

   assign clock = transmitter_output_clock;
   
   always @(posedge every_second)
	 test_data = test_data + 1;
   
 endmodule
