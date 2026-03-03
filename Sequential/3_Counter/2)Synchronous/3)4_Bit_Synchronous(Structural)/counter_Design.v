//synchronous counter structural

module Counter_gate(input t,clk,rst ,output [3:0] Q);
 
  t_ff t0(t,clk,rst,Q[0]);
  t_ff t1(Q[0],clk,rst,Q[1]);
  t_ff t2(Q[0]&Q[1],clk,rst,Q[2]);
  t_ff t3(Q[2]&Q[0]&Q[1],clk,rst,Q[3]);
endmodule
  
  
