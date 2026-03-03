//left right shift
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
module SISO(input Data_in, input clk,rst,preset,output Q );
  reg [3:0] q_temp;
  d_ff df1(Data_in,clk,rst,preset,q_temp[0]);
  d_ff df2(q_temp[0],clk,rst,preset,q_temp[1]);
  d_ff df3(q_temp[1],clk,rst,preset,q_temp[2]);
  d_ff df4(q_temp[2],clk,rst,preset,q_temp[3]);
    // here LSB is  Q[0] and MSB is Q[3]
  assign Q=q_temp[3];
endmodule

//Testbench
module SHIFTREGISTER_Tb();
  reg Data,clk,rst,preset;
  wire Q;
  
  SISO r1(Data,clk,rst,preset,Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
 initial begin
   rst=1'b1;preset=1'b0;
      
   
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
    $monitor($time,"\t Datain=%b clk =%b RST=%B  Preset=%b  Q=%b",Data,clk,rst,preset,Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule
  
 
  
