module t_ff(T,clk,rst,q);
  input T,clk,rst;
  output reg q;
  always @(posedge clk or negedge rst) begin
    if (!rst)
      q<=1'b0;
    else
      q<=T?~q:q;
  end
endmodule
