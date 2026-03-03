//Testbench
module SHIFTREGISTER_Tb ;
  reg [3:0]P_in;
  reg [2:0] MODE;
  reg S_in,clk,rst;
  wire  serial_Q;
  wire [3:0] parallel_Q;
  
  Universal_Shift_Register r1(Data,MODE,clk,rst,serial_Q,parallel_Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
initial begin
  rst=1;#15 rst=0; P_in=4'b0000;MODE=3'd0;
  #30 MODE=3'd3;P_in=4'b0111;
  #30 MODE=3'd1;S_in=1'b1;
  #30 MODE=3'd3;P_in=4'b0111; 
  #10 MODE=3'D4;
  #30 MODE=3'd2;S_in=1'b0;

  #100 $finish;
end

  initial begin
    $monitor($time,"\t Datain=%b clk =%b RST=%B   Serial out=%b  Parallel out=%b",Data,clk,rst,serial_Q,parallel_Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule


  
 
  
