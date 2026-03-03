module T_latch(input T,clk,reset,output reg q);
  always @(clk or T or reset) begin
    if (reset)
      q<=0;
    else begin
    if(clk)
      q<=T?~q:q;
    else 
      q<=q;
    end
  end
endmodule
