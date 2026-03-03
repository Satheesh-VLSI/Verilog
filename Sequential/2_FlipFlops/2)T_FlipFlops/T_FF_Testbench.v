module Tff_TB();
  reg T, clk, rst;
  wire q;

  t_ff dut (T, clk, rst, q);
  
  always #10 clk = ~clk;
  initial begin
    clk = 0;
    T = 0;
    rst=1;
   
    #5  T= 0;rst = 0;
    #45 rst=1;
    #80  T= 1;rst=0;
    #80  T= 0;rst=1;
    #5 rst=0;
     forever #20 T = ~T;
     
  end

  initial begin
    $monitor($time,
      "\tT=%b\tClock=%b\tReset=%b\tQ=%b", T, clk, rst, q);
  
  end
  initial begin
    $dumpfile("D_ff.vcd");
    $dumpvars;
    #1000
    $finish;
  end

endmodule
