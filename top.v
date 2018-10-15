
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

   wire 				transmitter_busy;
   wire 				transmitter_clk;
   wire 				transmitter_data;
   wire 				transmission_active; 				   

   wire [63:0] 			counter_wire;

   wire 				every_us;
   signal_generator #(.DELAY(`EVERY_US_DELAY)) every_us_generator(clk, rst, every_us);

   wire 				every_second;
   signal_generator #(.DELAY(`EVERY_SECOND_DELAY)) every_second_generator(clk, rst, every_second);
   
   
   counter counter(clk, rst, every_us, every_second, counter_wire);
    
   data_transmitter data_transmitter(.clk(clk),
   									 .rst(rst),
									 .data(counter_wire),
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

