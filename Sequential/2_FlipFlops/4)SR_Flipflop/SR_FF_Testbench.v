module SRff_TB;
  reg S, R, clk, rst;
  wire q;

  SR_ff dut (S, R, clk, rst, q);
  always 
    #5 clk = ~clk;

  initial begin
    S = 0; 
    R = 0; 
    rst = 0; 
    clk = 0;

    #10 rst = 1;   
    #10 S=0; R=0;   // HOLD
    #10 S=0; R=1;   // RESET
    #10 S=1; R=0;   // SET
    #10 S=1; R=1;   // INVALID
    #10 S=0; R=0;   // HOLD
    #10 S=0; R=1;   // RESET
    #10 S=1; R=0;   // SET
    #10 S=1; R=1;   // INVALID

    #20 $finish;
  end
  initial begin
    $monitor($time,
      "\tS=%b\tR=%b\tClock=%b\tReset=%b\tQ=%b",
       S, R, clk, rst, q);
  end
  initial begin
    $dumpfile("SR_ff.vcd");
    $dumpvars;
  end
endmodule

