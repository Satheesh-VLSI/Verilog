module JK_ff(input J,K,clk,reset, output Q,Qb);
  //Asynchronous reset
  wire Sm,Rm;
  wire Qm,Qmb;

  // Master latch
  nand (Sm,J,Qb,clk);
  nand (Rm,K,Q,clk);
  nand (Qm,Sm,Qmb);
  nand (Qmb,Rm,Qm);

  // Slave latch with reset
  nand (Ss,Qm,~clk);
  nand (Rs,Qmb,~clk);
  nand (Q,Ss,Qb);
  nand (Qb,Rs,Q,~reset);//active high reset reset=0 -normal operation
endmodule                // reset=1 resets Qb=1 and Q=0
