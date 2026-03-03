`include "t_ff.v"
//DOWN COUNTER with Posedge TRiggered clock
module counter(T,clk,rst,Q);
  input T,clk,rst;
  output reg [3:0] Q;
  
  t_ff T0(T,clk,rst,Q[0]);
  t_ff T1(T,Q[0],rst,Q[1]);
  t_ff T2(T,Q[1],rst,Q[2]);
  t_ff T3(T,Q[2],rst,Q[3]);
  
endmodule
