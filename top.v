
`include "constants.v" 
`include "generators.v" 
`include "tools/edge_detector.v" 
`include "tools/counter.v" 
`include "tools/indexer.v"
`include "test/test_data_generator.v"
`include "vive/pulse_recognizer.v" 
`include "vive/pulse_buffer.v"
`include "transmission/data_transmitter.v" 

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
   
   wire 				test_pulse_signal;
   signal_generator #(.DELAY(100)) test_pulse_signal_generator(clk, rst, test_pulse_signal);
   
   wire [`PULSE_DURATION_SIZE:0] test_pulse_duration;
   test_data_generator test_data_generator(clk, rst, test_pulse_signal, test_pulse_duration);


   wire [7:0] 					 index;
   wire 						 last_index;
   
   indexer #(.SIZE(316)) indexer(clk, rst, test_pulse_signal, index, last_index);

   
   wire 						 buffer_ready_wire;
   wire [63:0] 					 pulse_buffer_wire;
   pulse_buffer pulse_buffer(.clk(clk), .rst(rst),
							 .next(test_pulse_signal),
							 .pulse(test_pulse_duration),
							 .completed(buffer_ready_wire),
							 .out(pulse_buffer_wire));

   
   data_transmitter data_transmitter(.clk(clk), .rst(rst),
									 .send(buffer_ready_wire),
									 .data(pulse_buffer_wire),
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

