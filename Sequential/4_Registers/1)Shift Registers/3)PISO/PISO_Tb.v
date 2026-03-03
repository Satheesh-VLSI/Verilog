//Testbench
module SHIFTREGISTER_Tb #(parameter N=4);
  reg [N-1:0] Data;
  reg clk,rst,load;
  wire Q;
  
  PISO r1(Data,load,clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
   initial begin
  rst=1; load=0; Data=0;
  #15 rst=0;
  #10 Data=4'b0110; load=1;   // Data THEN load
  #25 load=0;                 // Shift starts
  #50;                        // 4 shift cycles
  #10 Data=4'b0111; load=1;
  #10 load=0;
  #50 $finish;
end

  initial begin
    $monitor($time,"\t Datain=%b clk =%b RST=%B   Q=%b",Data,clk,rst,Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule


  
 
  
