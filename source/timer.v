module timer (
    input clk,
    output[7:0] out
  );

  reg [7:0] counter_d, counter_q;
 
  assign out = counter_q;//[31:24];
 
  always @(*) begin
      counter_d <= counter_q + 1'b1;
  end
 
  always @(posedge clk) begin
      counter_q <= counter_d;
  end
  
endmodule
