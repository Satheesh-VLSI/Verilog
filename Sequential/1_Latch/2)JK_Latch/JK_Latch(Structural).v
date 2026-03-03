module JK_latch(input J, K,clk, reset, output Q, Qb);
  wire S, R;

  nand (S, J, Qb,clk);
  nand (R, K, Q,clk);
  nand (Q,  S, Qb, reset);
  nand (Qb, R, Q,  reset);
endmodule

