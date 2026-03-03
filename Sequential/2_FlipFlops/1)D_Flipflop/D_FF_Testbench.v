module Dff_TB();
  reg d, clk, rst;
  wire q;

  d_ff uut (d, clk, rst, q);
  
  always #5 clk = ~clk;
  initial begin
    clk = 0;
    d   = 0;
    rst = 1;
   
    #5  d   = 1;rst = 0;
    #45 rst=1;
    #5  d   = 1;rst=0;
    #5 rst=0;
     forever #50 d = ~d;
     
  end

  initial begin
    $monitor($time,
      "\tD=%b\tClock=%b\tReset=%b\tQ=%b", d, clk, rst, q);
  
  end
  initial begin
    $dumpfile("D_ff.vcd");
    $dumpvars;
    #1000
    $finish;
  end

endmodule

