module T_latch_tb;
  wire q, qb;
  reg  T, reset, clk;

  T_latch t1(T, clk, reset, q);
  
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    $monitor($time,"\tT=%b\treset=%b\tclk=%b\tQ=%b", T, reset, clk, q);

    
    reset = 1; T = 0;
    #10 reset = 1;
    #10 reset = 0;

    
    #10 T = 1;  
    #10 T = 0; 
    #10 T = 1;
    #10 T = 1;   
    #10 T = 0;  
    #10 T = 0;   
    #10 T = 1;  
    #10 T = 0;   
    #10 T = 1;   
    #10 T = 0;   
    #10 T = 1;  
    #10 T = 0;   
  end

  initial begin
    $dumpfile("D_latch.vcd");
    $dumpvars;
    #200 $finish;
  end
endmodule
