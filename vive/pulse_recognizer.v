
`ifndef PULSE_RECOGNIZER_MODULE
`define PULSE_RECOGNIZER_MODULE

`include "vive/vive_constants.v"

module pulse_recognizer (input [63:0] in,
						 output reg [`PULSE_TYPE_SIZE_OF:0] out);

   always @(*) begin
	  if      (in < `PULSE_DURATION_PULSE)                                             out <= `PULSE_TYPE_LASER;
      else if (in > `PULSE_DURATION_X0_LOW       && in < `PULSE_DURATION_X0_HIGH)      out <= `PULSE_TYPE_X0;
      else if (in > `PULSE_DURATION_Y0_LOW       && in < `PULSE_DURATION_Y0_HIGH)      out <= `PULSE_TYPE_Y0;
      else if (in > `PULSE_DURATION_X1_LOW       && in < `PULSE_DURATION_X1_HIGH)      out <= `PULSE_TYPE_X1;
      else if (in > `PULSE_DURATION_Y1_LOW       && in < `PULSE_DURATION_Y1_HIGH)      out <= `PULSE_TYPE_Y1;
      else if (in > `PULSE_DURATION_X0_SKIP_LOW  && in < `PULSE_DURATION_X0_SKIP_HIGH) out <= `PULSE_TYPE_X0_SKIP;
      else if (in > `PULSE_DURATION_Y0_SKIP_LOW  && in < `PULSE_DURATION_Y0_SKIP_HIGH) out <= `PULSE_TYPE_Y0_SKIP;
      else if (in > `PULSE_DURATION_X1_SKIP_LOW  && in < `PULSE_DURATION_X1_SKIP_HIGH) out <= `PULSE_TYPE_X1_SKIP;
      else if (in > `PULSE_DURATION_Y1_SKIP_LOW  && in < `PULSE_DURATION_Y1_SKIP_HIGH) out <= `PULSE_TYPE_Y1_SKIP;
      else                                                                             out <= `PULSE_TYPE_INTERVAL;
   end

endmodule

`endif

