module SR_latch(input Sb,Rb,clk,reset,output Q,Qb );
  nand (Q,Sb,Qb,clk,reset);
  nand (Qb,Rb,Q,clk,reset);
endmodule

