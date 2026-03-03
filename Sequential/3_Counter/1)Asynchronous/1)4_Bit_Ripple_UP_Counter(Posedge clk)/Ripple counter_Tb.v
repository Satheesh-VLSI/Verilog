module RippleCounter_Tb();
  reg clk,rst;
  wire [3:0] Q;
  
  Ripplecounter_4bit r1(clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
 initial begin
    rst=1'b1;
   #1 rst=1'b0;
    #2500 $finish;
  end
  initial
    $monitor($time,"\t Q=%b",Q);
endmodule
  
 
  
