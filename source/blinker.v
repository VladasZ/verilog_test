module blinker(
    input clk,
    output blink
  );
 
  reg [24:0] counter_d, counter_q;
 
  assign blink = counter_q[24];
 
  always @(counter_q) begin
    counter_d = counter_q + 1'b1;
  end
 
  always @(posedge clk) begin
    counter_q <= counter_d;
  end
 
endmodule