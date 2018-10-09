
`include "transmission/serial_transmitter.v"

module data_transmitter(input        clk,
						input 		 serial_clk,
						input 		 send,
						input [63:0] data,
						output 		 busy,
						output 		 transmission,
						output 		 out_data);

`define IDLE 0
`define SENDING 1

   reg [63:0] 						 data_buffer = 0;
   reg [7:0] 						 index = 0;

   reg 								 state = `IDLE;
   reg 								 new_byte = 0;

   wire [7:0] 						 current_byte = data_buffer[index];
   wire 							 serial_transmitter_busy;
   wire 							 last_index = index == 7;

   assign transmission = serial_transmitter_busy;
   assign busy = state == `SENDING;
   
   always @(posedge clk) begin
	  if (send && !serial_transmitter_busy) begin
		 state <= `SENDING;
		 data_buffer <= data;
		 new_byte <= 1;
	  end else if (!serial_transmitter_busy && state == `SENDING) begin
		 new_byte <= 1;
		 index <= index + 1;
	  end else if (last_index) begin
		 index <= 0;
		 state <= `IDLE;
	  end else begin
		 new_byte <= 0;
	  end
   end
   
   serial_transmitter serial_transmitter(.clk(serial_clk),
										 .send(new_byte),
										 .in_data(current_byte),
										 .transmission(serial_transmitter_busy),
										 .out_data(out_data));   

endmodule
