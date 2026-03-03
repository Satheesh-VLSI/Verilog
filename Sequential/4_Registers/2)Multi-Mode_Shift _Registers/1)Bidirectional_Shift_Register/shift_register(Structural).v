//left right shift

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
module  Bi_Shift_Register(input Data_in,MODE,clk,rst,output Q );
  wire [3:0]q,O;
  assign O[0]=MODE?Data_in:q[1];
  assign O[1]=MODE?q[0]:q[2];
  assign O[2]=MODE?q[1]:q[3];
  assign O[3]=MODE?q[2]:Data_in;
  
  assign Q=MODE?q[3]:q[0];
  
  d_ff df1(O[0],clk,rst,q[0]); 
  d_ff df2(O[1],clk,rst,q[1]);
  d_ff df3(O[2],clk,rst,q[2]);
  d_ff df4(O[3],clk,rst,q[3]);
  
    // here LSB is  Q[0] and MSB is Q[3]

endmodule
