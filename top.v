
`include "constants.v"
`include "transmission/data_transmitter.v"
`include "generators.v"
`include "counter.v"

module top(input        clk,
		   input 		rst, //bottom
		   input 		btn1,//top
		   output [2:0] led,
		   output 		transmission,
		   output 		clock,
		   output 		data);

   wire 				every_us;
   wire 				hundred_per_second;
   wire 				clk_thousand;
   wire 				every_second;
   wire 				transmitter_busy;
   wire 				transmitter_clk;
   wire 				transmitter_data;
   wire 				transmission_active; 				
   
   generators generators(.clk(clk), .rst(rst),
						 .every_us(every_us),
						 .hundred_per_second(hundred_per_second),
						 .clk_thousand(clk_thousand),
						 .every_second(every_second)
);



   
   wire 				test_timer_increment;
   signal_generator #(.DELAY(`EVERY_SECOND_DELAY / 100)) test_timer_increment_generator(clk, rst, test_timer_increment);

   reg [63:0] 			test_timer;

   always @(posedge clk) 
	 if (test_timer_increment)
	   test_timer <= test_timer + 1;
	 else if (rst)
	   test_timer <= 0;

   data_transmitter data_transmitter(.clk(clk),
   									 .rst(rst),
   								//	  .data(64'b1010101010101010101010101010101010101010101010101010101010101010),
                                  //.data(64'b0000000000000000000000000000000000000000000000000000000000000000),
                                   // .data(64'b1000000011000000111000001111000011111000111111001111111011111111),
									 .data(test_timer),
   									 .busy(transmitter_busy),
   									 .transmission(transmission_active),
   									 .out_data(transmitter_data),
   									 .clock(transmitter_clk));

   assign clock        = transmitter_clk;
   assign data         = transmitter_data;
   assign transmission = transmission_active; 				   
   
   wire 				every_second_switch;
   interval_switch #(.DELAY(`EVERY_SECOND_DELAY)) every_second_switch_generator(clk, rst, every_second_switch);
   
   assign led[0] = transmitter_busy;    //bottom
   assign led[1] = every_second_switch; //top
   assign led[2] = rst;                 //red

   
 endmodule

