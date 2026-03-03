
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
module PISO(input [3:0] Data_in,input clk,rst,output [3:0] Q );

  
  d_ff df1(Data_in[0],clk,rst,Q[0]); 
  d_ff df2(Data_in[1],clk,rst,Q[1]);
  d_ff df3(Data_in[2],clk,rst,Q[2]);
  d_ff df4(Data_in[3],clk,rst,Q[3]);
  
    // here LSB is  Q[0] and MSB is Q[3]

endmodule
