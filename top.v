
`include "constants.v"
`include "tools/edge_detector.v"
`include "tools/counter.v"
`include "transmission/data_transmitter.v"
`include "generators.v"
`include "vive/pulse_recognizer.v"
`include "test/test_data_generator.v"


module top(input        clk,
		   input 		rst, //bottom
		   input 		btn1,//top
		   input 		vive_sensor,
		   output [2:0] led,
		   output 		transmission,
		   output 		clock,
		   output 		data);
   

   wire 				edge_detected;
   

   wire 				transmitter_busy;
   wire 				transmitter_clk;
   wire 				transmitter_data;
   wire 				transmission_active; 				   

   wire [63:0] 			counter_wire;

   wire 				every_us;
   signal_generator #(.DELAY(`EVERY_SECOND_DELAY)) every_us_generator(clk, rst, every_us);
   
   counter counter(clk, rst, every_us, edge_detected, counter_wire);


   wire [4:0] pulse_wire;

   pulse_recognizer pulse_recognizer(counter_wire, pulse_wire);

   wire [63:0] test_data;
   test_data_generator test_data_generator(clk, rst, every_us, test_data);
   
   data_transmitter data_transmitter(.clk(clk),
   									 .rst(rst),
									 .data(test_data),
   									 .busy(transmitter_busy),
   									 .transmission(transmission_active),
   									 .out_data(transmitter_data),
   									 .clock(transmitter_clk));

   assign clock        = transmitter_clk;
   assign data         = transmitter_data;
   assign transmission = transmission_active; 				   
   
   wire 				every_second_switch;
   interval_switch #(.DELAY(`EVERY_SECOND_DELAY)) every_second_switch_generator(clk, rst, every_second_switch);

   edge_detector edge_detector(clk, rst, vive_sensor, edge_detected);

   assign led[0] = transmitter_busy; //bottom
   assign led[1] = every_second_switch; //top
   assign led[2] = rst;  //red

   
 endmodule

