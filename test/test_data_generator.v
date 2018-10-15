module test_data_generator(input         clk,
						   input 		 rst,
						   input 		 next,
						   output [63:0] out);

   reg [15:0] 								 data_buffer [20:0];
   reg [8:0] 								 index;

   wire 									 last_index = index == 16;
   
   assign out = data_buffer[index];

   always @(posedge clk) begin
	  if (rst) begin
		 index <= 0;
	  end else if (next) begin
		 index <= index + 1;
	  end else if (last_index) begin
		 index = 0;
	  end
   end

   always @(posedge clk) begin
	  data_buffer[0]  <= 65;
	  data_buffer[1]  <= 75;
	  data_buffer[2]  <= 85;
	  data_buffer[3]  <= 95;
	  data_buffer[4]  <= 105;
	  data_buffer[5]  <= 115;
	  data_buffer[6]  <= 4454;
	  data_buffer[7]  <= 125;
	  data_buffer[8]  <= 140;
	  data_buffer[9]  <= 140;
	  data_buffer[10] <= 140;
	  data_buffer[11] <= 140;
	  data_buffer[12] <= 10;
	  data_buffer[13] <= 10;
	  data_buffer[14] <= 10;
	  data_buffer[15] <= 10;
   end

endmodule
