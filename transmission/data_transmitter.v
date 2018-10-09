
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

   reg [7:0] 						 data_buffer [7:0];
   reg [7:0] 						 index = 0;

   reg 								 state = `IDLE;
   reg 								 new_byte = 0;

   wire [7:0] 						 current_byte = data_buffer[index];
   wire 							 serial_transmitter_busy;
   wire 							 last_index = index == 7;

   assign transmission = serial_transmitter_busy;
   assign busy = state == `SENDING || serial_transmitter_busy;

   integer 							 i = 0;
   
   always @(posedge clk) begin
	  
	  if (state == `IDLE && !busy && serial_clk) begin
		 if (send) begin
		 state <= `SENDING;
		 for (i = 0; i < 8; i++) begin
		 	data_buffer[i] <= data[8*i+:8];
		 end	
		 new_byte <= 1;
		 end
	  end 

	  else if (state == `SENDING) begin
		 if (!last_index && serial_clk && !serial_transmitter_busy) begin
			new_byte <= 1;
			index <= index + 1;
		 end else if (last_index) begin
			state <= `IDLE;
			index <= 0;
			new_byte <=0;
		 end else begin
			new_byte <= 0;
		 end
	  end
   end
   
   serial_transmitter serial_transmitter(.clk(clk),
										 .transmission_clock(serial_clk),
										 .send(new_byte),
										 .in_data(current_byte),
										 .transmission(serial_transmitter_busy),
										 .out_data(out_data));   

endmodule
