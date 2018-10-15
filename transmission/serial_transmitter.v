`include "constants.v"

module serial_transmitter(input       clk,
						  input 	  rst,
						  input 	  transmission_clock, 
						  input 	  send,
						  input [7:0] in_data,
						  output 	  transmission,
						  output 	  out_data);

   reg [7:0] 						  index = 0;
   reg [7:0]						  data_buffer = 0;

   reg 								  sending = 0;
   
   wire 							  current_bit = data_buffer[index];
   wire 							  last_index = index == 7;

   assign transmission = sending;
   assign out_data = current_bit;
   
   always @(posedge clk) begin
	  if (rst) begin
		 index <= 0;
		 data_buffer <= 0;
		 sending <= 0;
	  end if (send) begin
		 data_buffer <= in_data;
		 sending <= 1;
		 index <= 0;
	  end else if (last_index && transmission_clock) begin
		 index <= 0;
		 sending <= 0;
	  end else if (sending && transmission_clock) begin
		 index <= index + 1;
	  end
   end
   

endmodule
