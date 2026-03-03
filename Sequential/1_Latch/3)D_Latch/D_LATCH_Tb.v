module D_latch_tb;
  wire q, qb;
  reg  d, reset, clk;

  D_latch d1(d, clk, reset, q);
  
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    $monitor($time,"\td=%b\treset=%b\tclk=%b\tQ=%b", d, reset, clk, q);

    
    reset = 1; d = 0;
    #10 reset = 0;

    
    #10 d = 1;  
    #10 d = 0; 
    #10 d = 1;
    #10 d = 1;   
    #10 d = 0;  
    #10 d = 0;   
    #10 d = 1;  
    #10 d = 0;   
    #10 d = 1;   
    #10 d = 0;   
    #10 d = 1;  
    #10 d = 0;   
  end

  initial begin
    $dumpfile("D_latch.vcd");
    $dumpvars;
    #200 $finish;
  end
endmodule
