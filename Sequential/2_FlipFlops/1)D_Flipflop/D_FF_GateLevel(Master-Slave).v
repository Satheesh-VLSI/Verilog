module d_ff(input D, clk, reset, output Q, Qb);
  wire Dn;
  wire Sm,Rm;
  wire Qm,Qmb;
  wire Ss,Rs;
//Asynchronous rest
  not  (Dn,D);

  // Master
  nand (Sm,D,clk);
  nand (Rm,Dn,clk);
  nand (Qm,Sm,Qmb);
  nand (Qmb,Rm,Qm);

  // Slave
  nand (Ss,Qm,~clk);
  nand (Rs,Qmb,~clk);

  //Output
  nand (Q,Ss,Qb);
  nand (Qb,Rs,Q,~reset);//active high reset reset=0 -normal operation
endmodule                // reset=1 resets Qb=1 and Q=0
