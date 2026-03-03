//Testbench
module SHIFTREGISTER_Tb #(parameter N=4);
  reg Data,MODE,clk,rst;
  wire  Q;
  
  Bi_Shift_Register r1(Data,MODE,clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
initial begin
  rst=1; Data=0;
  #15 rst=0;MODE=1;
  #10 Data=1;
   #10 Data=0; 
   #10 Data=1; 
   #10 Data=0; // Data THEN load
                // Shift starts
  #50;                        // 4 shift cycles
  #10 MODE=0;
   #10 Data=1;  #10 Data=0;  #10 Data=0;  #10 Data=1; 
  
  #100 $finish;
end

  initial begin
    $monitor($time,"\t Datain=%b clk =%b RST=%B   Q=%b",Data,clk,rst,Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule
  
 
  
