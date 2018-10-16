
`include "vive/vive_constants.v"
`include "vive/pulse_recognizer.v"

module pulse_buffer(input                          clk,
					input 						   rst,
					input 						   next,
					input [`PULSE_DURATION_SIZE:0] pulse,
					output 						   completed,
					output reg [63:0] 			   out);

   reg [`PULSE_TYPE_SIZE_OF:0] 					   buffer [15:0];
						
   reg [7:0] 									   index;

   reg [63:0] 									   test_buffer;


   assign test_buffer[3  :  0] = buffer[0]; 
   assign test_buffer[7  :  4] = buffer[1]; 
   assign test_buffer[11 :  8] = buffer[2]; 
   assign test_buffer[15 : 12] = buffer[3]; 
   assign test_buffer[19 : 16] = buffer[4]; 
   assign test_buffer[23 : 20] = buffer[5]; 
   assign test_buffer[27 : 24] = buffer[6]; 
   assign test_buffer[31 : 28] = buffer[7];    
   assign test_buffer[35 : 32] = buffer[8];    
   assign test_buffer[39 : 36] = buffer[9];    
   assign test_buffer[43 : 40] = buffer[10];    
   assign test_buffer[47 : 44] = buffer[11];    
   assign test_buffer[51 : 48] = buffer[12];    
   assign test_buffer[55 : 52] = buffer[13];    
   assign test_buffer[59 : 56] = buffer[14];
   assign test_buffer[63 : 60] = buffer[15];

   
   wire 										   last_index = index == 15;

   wire [`PULSE_TYPE_SIZE_OF:0] 				   recognized_pulse;

   assign completed = last_index;
   
   integer 							 i = 0;
   
   pulse_recognizer pulse_recognizer(pulse, recognized_pulse);

   always @(posedge clk) begin
	  if (rst) begin
		 for (i = 0; i < 16; i++) begin
			buffer[i] <= 0;
		 end
		 index <= 0;
		 out <= 0;
	  end
   end

   always @(posedge clk) begin
	  if (next) begin
		 buffer[index] <= recognized_pulse;
		 index = index + 1;
	  end else if (last_index) begin
		 for (i = 0; i < 16; i++) begin
			out[4*i+:4] = buffer[i];
			
			// data_buffer[i] <= data[8*i+:8];
			// completed_buffer[i] <= buffer[i];
		 end
		 index = 0;
	  end
   end

endmodule

