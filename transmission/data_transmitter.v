`include "constants.v"
`include "transmission/serial_transmitter.v"
`include "tools/interval_switch.v"

module data_transmitter(input        clk,
						input 		 rst,
						input [63:0] data,
						output 		 busy,
						output 		 transmission,
						output 		 clock,
						output 		 out_data);

`define IDLE 0
`define SENDING 1

   reg [7:0] 						 data_buffer [7:0];
   reg [7:0] 						 index = -1;

   reg 								 state = `IDLE;
   reg 								 new_byte = 0;

   wire [7:0] 						 current_byte = data_buffer[index];
   wire 							 serial_transmitter_busy;
   wire 							 last_index = index == 7;
   wire 							 serial_clk;
   wire 							 send;
   
   interval_switch #(.DELAY(`TRANSMITTER_CLOCK_DELAY)) transmitter_out_clock_generator(clk, rst, clock);
   signal_generator #(.DELAY(`TRANSMITTER_CLOCK_DELAY)) serial_generator(clk, rst, serial_clk);
   signal_generator #(.DELAY(`SEND_DATA_DELAY)) send_generator(clk, rst, send);
   
   assign transmission = serial_transmitter_busy;
   assign busy = state == `SENDING || serial_transmitter_busy;

   integer 							 i = 0;
   
   always @(posedge clk) begin
	 if (rst) begin
		 index <= -1;
		 new_byte <= 0;
		 state <= `IDLE;
	 end else if (state == `IDLE && !busy) begin
		 if (send) begin
			state <= `SENDING;
			for (i = 0; i < 8; i++) begin
		 	   data_buffer[i] <= data[8*i+:8];
			end	
		 end
	 end 

	 else if (state == `SENDING) begin
		if (!new_byte && !last_index && serial_clk && !serial_transmitter_busy) begin
		   new_byte <= 1;
		   index <= index + 1;
		end else if (last_index) begin
		   state <= `IDLE;
		   index <= -1;
		   new_byte <=0;
		end else begin
		   new_byte <= 0;
		end
	 end
   end
   
   serial_transmitter serial_transmitter(.clk(clk),
										 .rst(rst),
										 .transmission_clock(serial_clk),
										 .send(new_byte),
										 .in_data(current_byte),
										 .transmission(serial_transmitter_busy),
										 .out_data(out_data));   

endmodule
