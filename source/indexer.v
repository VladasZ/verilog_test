module indexer #(
    parameter SIZE = 8
  ) (
    input increment,
    output [$clog2(SIZE) - 1:0] out
  );
  
    reg [$clog2(SIZE) - 1:0] counter_d, counter_q = SIZE - 1;
    
    assign out = counter_q;
    
  always @(*) begin
    counter_d <= counter_q + 1'b1;
  end
  
  always @(posedge increment) begin
    counter_q <= counter_d;
  end
  
endmodule
