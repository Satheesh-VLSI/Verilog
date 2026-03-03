module RippleCounter_Tb();
  reg clk,rst;
  wire [3:0] Q;
  
  ripple_counter r1(clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #10 clk=~clk;
 initial begin
    rst=1'b1;
   #1 rst=1'b0;
   #10 rst=1'b1;
    #1 rst=1'b0;
   #2500 $finish;
  end
  initial
    $monitor($time,"\t Clock=%b Q=%b or  %d",clk,Q,Q);
endmodule
  
 
  
