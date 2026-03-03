//Testbench
module seq_tb();
  reg Data_in,clk,rst;
  wire out;
  
  seq_detect sq1(.Data_in(Data_in),.clk(clk),.rst(rst),.out(out));
  
 initial clk=1;
  
 always #5 clk=~clk;
  
  initial begin
    rst=1; Data_in=0;
    $monitor($time,"Data_in=%b   clk=%b   rst=%b   out=%b",Data_in,clk,rst,out);
    #5 rst=0; 
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=0;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=0;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=0;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=0;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=1;
    @(negedge clk) Data_in=0;
    @(negedge clk) Data_in=1;
    #20 $finish;
  end
  initial begin
    $dumpfile("sq.vcd");
    $dumpvars;
  end
  
endmodule

  
 
  
