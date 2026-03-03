//left right shift

//BOTTOM MODULE
module d_ff(input d,clk,rst, preset,output reg q );
  always @(posedge clk) begin
    if (rst)
      q<=0;
   else if (preset)
      q<=1;
   else 
      q<=d;
   end
endmodule
//TOP MODULE
module SIPO(input Data_in, input clk,rst,preset,output [3:0] Q );
  d_ff df1(Data_in,clk,rst,preset,Q[0]);
  d_ff df2(Q[0],clk,rst,preset,Q[1]);
  d_ff df3(Q[1],clk,rst,preset,Q[2]);
  d_ff df4(Q[2],clk,rst,preset,Q[3]);
    // here LSB is  Q[0] and MSB is Q[3]

endmodule



//Testbench
module SHIFTREGISTER_Tb();
  reg Data,clk,rst,preset;
  wire [3:0] Q;
  
  SIPO r1(Data,clk,rst,preset,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
 initial begin
   rst=1'b1;preset=1'b0;
      
   
   #10 rst=1'b0;
   #10 Data=1'b0;
   #10 Data=1'b1;
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
    $monitor($time,"\t Datain=%b clk =%b RST=%B  Preset=%b  Q=%b",Data,clk,rst,preset,Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule
  
 
  
