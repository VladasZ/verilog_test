`include "serial_transmitter.v"
`include "generators.v"

module top(input  clk,
		   output transmission,
		   output clock,
		   output data,
		   output [2:0] led);

   wire 				every_second;
   wire 				ten_per_second;				
   wire 				every_second_switch;

   reg [7:0] 			test_data = 0;

   generators generators(.clk(clk),
						 .every_second(every_second),
						 .ten_per_second(ten_per_second));

   switch every_second_switch_m(.trigger(every_second), 
								.out(every_second_switch));
   
   serial_transmitter serial_transmitter(.clk(ten_per_second),
   										 .send(every_second),
   										 .in_data(test_data),
   										 .transmission(transmission),
   										 .transmission_clock(clock),
   										 .out_data(data));
   
   assign led[0] = 1;
   assign led[1] = every_second_switch;
   assign led[2] = 1;

   always @(posedge every_second)
	 test_data = test_data + 1;
   
 endmodule
