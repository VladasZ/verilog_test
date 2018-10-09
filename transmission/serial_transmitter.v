
`include "switch.v"

module serial_transmitter(input       clk,
						  input 	  send,
						  input [7:0] in_data,
						  output 	  transmission,
						  output 	  transmission_clock, 
						  output 	  out_data);

   reg 		 is_sending = 0;
   reg [7:0] index = 0;
   reg [7:0] data_buffer = 0;
   
   wire 	 current_bit = data_buffer[index];
   wire 	 last_index  = index == 7;
   wire 	 switch_trigger;
   
   assign transmission   = is_sending;
   assign out_data       = current_bit;
   assign switch_trigger = clk;

   switch clock_switch(.trigger(switch_trigger), .out(transmission_clock));

   always @(posedge send)
	  data_buffer <= in_data;

   always @(posedge clk) begin
	  if (last_index) begin
		 index <= 0;
		 is_sending <= 0;
	  end else if (is_sending) begin
		 index <= index + 1;
	  end else if (send) begin
		 is_sending <=1;
	  end
   end

endmodule
