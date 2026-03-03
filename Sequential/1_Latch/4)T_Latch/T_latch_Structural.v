module T_latch(input T,clk, reset, output Q);
  wire S, R,T,Qb;

  nand (S, T, Qb,clk);
  nand (R, T, Q,clk);
  nand (Q,  S, Qb);
  nand (Qb, R, Q,  reset);
endmodule
