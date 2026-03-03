module d_ff(input d,clk,rst,output reg q);
  
  always @(posedge clk)begin
  if(rst)
    q<=0;
  else
    q<=d;
  end
endmodule

module JOHNSON_gate(input t,clk,rst ,output [3:0] Q);
 
  d_ff t0(~Q[3],clk,rst,Q[0]);
  d_ff t1(Q[0],clk,rst,Q[1]);
  d_ff t2(Q[1],clk,rst,Q[2]);
  d_ff t3(Q[2],clk,rst,Q[3]);
endmodule
  
  
