
//Testbench
module SHIFTREGISTER_Tb #(parameter N=4);
  reg [N-1:0] Data;
  reg clk,rst;
  wire [N-1:0] Q;
  
  PIPO r1(Data,clk,rst,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
initial begin
  rst=1; Data=0;
  #15 rst=0;
  #10 Data=4'b0110;   // Data THEN load
                // Shift starts
  #50;                        // 4 shift cycles
  #10 Data=4'b0111;
  ;
  #50 $finish;
end

  initial begin
    $monitor($time,"\t Datain=%b clk =%b RST=%B   Q=%b",Data,clk,rst,Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule
  
 
  
