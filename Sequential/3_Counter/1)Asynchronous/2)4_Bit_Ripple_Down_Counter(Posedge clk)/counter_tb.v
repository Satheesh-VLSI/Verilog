module RippleCounter_Tb();
  reg clk,rst,t=1'b1;
  wire [3:0] Q;
  
  counter r1(t,clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
 initial begin
    rst=1'b1;;
   #1 rst=1'b0;
    #2500 $finish;
  end
  initial
    $monitor($time,"\t Q=%b",Q);
endmodule
  
 
  
