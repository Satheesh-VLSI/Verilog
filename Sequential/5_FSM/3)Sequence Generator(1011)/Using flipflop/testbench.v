module seq_gen_tb;
  reg clk,rst;
  wire seq;
  
  seq_gen sq1(clk,rst,seq);
  
  
  always #10 clk=~clk;
  
  initial begin
    $monitor($time," clk=%b  rst=%b  seq=%b ",clk,rst,seq);
    clk=0;
    rst=1;
    #30 rst=0;
    #500 $finish;
  end 
  initial begin 
    $dumpfile("seq_gen.vcd");
    $dumpvars;
  end
endmodule
