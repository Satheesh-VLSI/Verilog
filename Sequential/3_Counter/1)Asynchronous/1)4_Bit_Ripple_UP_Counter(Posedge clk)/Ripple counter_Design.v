
//UP counter with posedge triggered clock
module Ripplecounter_4bit(clk,rst,Q);
  input clk,rst;
  output [3:0] Q;
  TFF t1(Q[0],1'b1,clk,rst);
  TFF t2(Q[1],1'b1,~Q[0],rst);
  TFF t3(Q[2],1'b1,~Q[1],rst);
  TFF t4(Q[3],1'b1,~Q[2],rst);
  
endmodule  
  
module TFF(q,t,clk,rst);
output reg q;
input t, clk, rst;
 always @(posedge clk or posedge rst) begin
      
    if (rst)
      q<=0;   
    else if (t)
      q<=~q;
    else
      q<=q;
    end
  endmodule
   
    
    
  
