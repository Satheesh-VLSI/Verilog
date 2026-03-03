module RippleCounter_Tb();
  reg clk,rst,UD;
  wire [3:0] Q;
  
 Ripple_UPDOWN_4bit #0 r1(clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #20 clk=~clk;
 initial begin
    rst=1'b1;
 
   #1 rst=1'b0;
   #10 rst=1'b1;
    #1 rst=1'b0;
   #2500 $finish;
  end
  initial begin
    $monitor($time,"\t Q=%b or  %d",Q,Q);
    $dumpfile("count.vcd");
  $dumpvars;
  end
endmodule
  
 
  
