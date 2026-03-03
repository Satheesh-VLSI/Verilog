
module SHIFTREGISTER_Tb();
  reg Data,clk,rst;
  wire Q;
  
  SIPO r1(Data,clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
 initial begin
   rst=1'b1;
      
   
   #10 rst=1'b0;
   #10 Data=1'b0;
   #5 Data=1'b1;
   #10 Data=1'b1;
   #10 Data=1'b1;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b0;
   #100 $finish;
  end
  initial begin
    $monitor($time,"\t Datain=%b clk =%b RST=%B   Q=%b",Data,clk,rst,Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule
  
 
  
