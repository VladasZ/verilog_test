
`ifndef INDEXER_MODULE
`define INDEXER_MODULE

module indexer #(parameter SIZE = 8
				 )(input                       clk,
				   input 					   rst,
				   input 					   increment,
				   output reg [$clog2(SIZE):0] get,
				   output 					   last); 


   wire 									   last_wire = get == SIZE - 1;
   
   assign last = last_wire;

   always @(posedge clk) if (rst) get <= 0;

   always @(posedge clk)
	 if (increment)
	   if (last_wire)
		  get <= 0;
		else
		  get = get + 1;
  
endmodule	 

`endif

