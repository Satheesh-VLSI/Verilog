module D_latch(input D,clk, reset, output Q);
  wire S, R,Dn,Qb;
  not(Dn,D);
  nand (S, D, Qb,clk);
  nand (R, Dn, Q,clk);
  nand (Q,  S, Qb);
  nand (Qb, R, Q,  reset);
endmodule
