module Counter_Tb();
  reg clk,rst;
  wire [3:0] Q;
  
  RING_gate r1(clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #10 clk=~clk;
 initial begin
   rst=1'b1;
  
   #10 rst=1'b0;

   #2500 $finish;
  end
  initial begin
    $monitor($time,"\t Q=%b or  %d RST=%B",Q,Q,rst);
    $dumpfile("count.vcd");
  $dumpvars;
  end
endmodule
  
 
  
