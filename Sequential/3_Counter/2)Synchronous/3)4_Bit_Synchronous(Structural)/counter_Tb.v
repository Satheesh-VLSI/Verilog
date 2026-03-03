module Counter_Tb();
  reg clk,rst,t;
  wire [3:0] Q;
  
  Counter_gate r1(t,clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #10 clk=~clk;
 initial begin
   rst=1'b1;
   t=1'b1;
   #10 rst=1'b0;
  
    #10 rst=1'b0;
   #2500 $finish;
  end
  initial begin
    $monitor($time,"\t Q=%b or  %d",Q,Q);
    $dumpfile("count.vcd");
  $dumpvars;
  end
endmodule
  
 
  
