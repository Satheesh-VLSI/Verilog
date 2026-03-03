module SR_latch_tb;
  wire q, qb;
  reg  S, R, reset, clk;

  SR_latch sr1(S, R, reset, clk, q, qb);
  
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    $monitor($time,"\tS=%b\tR=%b\tQ=%b", S, R, q);

    reset = 0;  
    S = 0; R = 0;   // hold
    #5 S = 0; R = 1;   // reset
    #5 S = 1; R = 0;   // set
    #5 S = 0; R = 0;   // hold
  end

  initial begin
    $dumpfile("SR_latch.vcd");
    $dumpvars;
    #200 $finish;
  end
endmodule
