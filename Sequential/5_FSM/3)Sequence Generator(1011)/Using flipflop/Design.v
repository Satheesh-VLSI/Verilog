//top module
module seq_gen(input clk,rst,output seq);
wire a,b,c;
  
  d_ff f1((~a | ~b | ~c),clk,rst,a);
  d_ff f2(a,clk,rst,b);
  d_ff f3(b,clk,rst,c);
  assign seq=c;
endmodule
  
//d_ff
module d_ff(d,clk,rst,q);
  input d,clk,rst;
  output reg q;
  always @(posedge clk) begin
    if (rst)
      q<=1'b0;
    else
      q<=d;
  end
endmodule
