//left shift

//BOTTOM MODULE
module d_ff(input d,clk,rst,output reg q );
  always @(posedge clk) begin
    if (rst)
      q<=0;
   else 
      q<=d;
   end
endmodule
//TOP MODULE
module PISO(input [3:0] Data_in,input clk,rst,load,output Q );
  wire [3:0] q,O;
  assign Q=q[3];
  assign O[0]=load?Data_in[0]:1'b0;
  assign O[1]=load?Data_in[1]:q[0];
  assign O[2]=load?Data_in[2]:q[1];
  assign O[3]=load?Data_in[3]:q[2];
  
  d_ff df1(O[0],clk,rst,q[0]); 
  d_ff df2(O[1],clk,rst,q[1]);
  d_ff df3(O[2],clk,rst,q[2]);
  d_ff df4(O[3],clk,rst,q[3]);
  
    // here LSB is  Q[0] and MSB is Q[3]

endmodule

//Testbench
module SHIFTREGISTER_Tb #(parameter N=4);
  reg [N-1:0] Data;
  reg clk,rst,load;
  wire Q;
  
  PISO r1(Data,clk,rst,load,Q);
   
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
  
 
  
