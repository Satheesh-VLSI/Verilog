module D_latch(input d,clk,reset,output reg q);
  always @(clk or d or reset) begin
    if (reset)
      q<=0;
    if(clk)
      q<=d;
    else 
      q<=q;
  end
endmodule
