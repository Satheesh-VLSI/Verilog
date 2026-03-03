module JKff_TB();
  reg J, K, clk, rst;
  wire q;

  JK_ff dut1(J, K, clk, rst, q);
  
  always #10 clk = ~clk;
  initial begin
    J = 0; 
    K = 0; 
    rst = 0; 
    clk = 0;
    
    #10 rst=1;
    #10 rst = 0;   
    #10 J = 0; K = 0;   // HOLD
    #10 J = 0; K = 1;   // RESET
    #10 J = 1; K = 0;   // SET
    #10 J = 1; K = 1;   // TOGGLE

    #10 J = 0; K = 0;   // HOLD
    #10 J = 0; K = 1;   // RESET
    #10 J = 1; K = 0;   // SET
    #10 J = 1; K = 1;   // TOGGLE

    #20 $finish;
  end

  initial begin
    $monitor($time,
      "\tJ=%b\tK=%b\tClock=%b\tReset=%b\tQ=%b",J, K, clk, rst, q);
  end

  initial begin
    $dumpfile("JK_ff.vcd");
    $dumpvars;
  end

endmodule

