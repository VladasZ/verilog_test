module signal_generator #(
    parameter DELAY = 1
  ) (
    input clk,
    output out
  );
  
    reg [63:0] counter_d, counter_q;
    reg out_d, out_q;
    
    assign out = out_q;
    
  always @* begin
    counter_d <= counter_q + 1;
    
    if (counter_q == DELAY - 1) begin
      out_d <= 1'b1;
      counter_d <= 64'b0;
    end else begin
      out_d <= 1'b0;
     end
  end
  

  always @(posedge clk) begin
    counter_q <= counter_d;
    out_q <= out_d;
  end
  
endmodule
