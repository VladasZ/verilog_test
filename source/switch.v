module switch (
    input toggle,
    output reg out
  );
  
  always @(posedge toggle) begin
    out <= ~out;
  end
  
endmodule
