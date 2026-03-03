//Testbench
module seq_tb();
  reg clk,rst;
  wire out;
  
  seq_GEN sq1(.clk(clk),.rst(rst),.out(out));
  
 initial clk=1;
  
 always #5 clk=~clk;
  
  initial begin
    rst=1; 
    $monitor($time,"clk=%b   rst=%b   out=%b",clk,rst,out);
    #10 rst=0; 
  
    #250 $finish;
  end
  initial begin
    $dumpfile("sq.vcd");
    $dumpvars;
  end
  
endmodule

  
 
  
