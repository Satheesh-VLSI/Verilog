
//Testbench
module parity_gen_FSM_Tb;
  reg clk,rst;
  reg [2:0] x;
  wire odd,even;
  
  parity_gen_FSM p1(clk,rst,x,odd,even);
  
 initial clk=1;
  
 always #5 clk=~clk;
  
  initial begin
    rst=1; x=0;
    $monitor($time,"Data_in=%b   clk=%b   rst=%b   even_parity=%b  odd_parity=%b",x,clk,rst,even,odd);
    #5 rst=0; 

    @(negedge clk) x=3'd0;
    @(negedge clk) x=3'd1;
    @(negedge clk) x=3'd2;
    @(negedge clk) x=3'd3;
    @(negedge clk) x=3'd4;
    @(negedge clk) x=3'd5;
    @(negedge clk) x=3'd6;
    @(negedge clk) x=3'd7;

    #20 $finish;
  end
  initial begin
    $dumpfile("p.vcd");
    $dumpvars;
  end
  
endmodule

  
 
  
