module JK_latch_tb;
  wire q, qb;
  reg  J, K,reset,clk;

  JK_latch jk1(J, K, reset,clk,q, qb);
  
always #5 clk=~clk;
  initial begin
    clk=0;
    $monitor($time,"\tJ=%b\tK=%b\tQ=%b", J, K, q);
    reset=0;  
    J=0; K=0;   // hold
    #5 J=0; K=1;   // reset
    #5 J=1; K=1;   // set
    #5 J=1; K=0;   // toggle
    #5 J=0; K=0;   // hold
  end

  initial begin
    $dumpfile("JK_latch.vcd");
    $dumpvars;
    #200 $finish;
  end
endmodule


