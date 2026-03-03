module d_ff(d,clk,rst,q);
  input d,clk,rst;
  output reg q;
  //always @(posedge clk)
  
  always @(posedge clk or posedge rst)begin 
    if (rst)
      q<=1'b0;
    else
      q<=d;
  end
endmodule
