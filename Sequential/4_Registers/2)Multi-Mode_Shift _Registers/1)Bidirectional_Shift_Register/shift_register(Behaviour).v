//Bi-Directional Shift Register
module Bi_Shift_Register(input Data_in,MODE,clk,rst,output reg Q );
  reg [3:0] q_temp;
  always @(posedge clk)begin
    if(rst)begin
      q_temp<=4'b0000;
      Q<=0;
    end                // here LSB is  Q[0] and MSB is Q[3]
    else begin
      if (MODE)begin
      q_temp<={q_temp[2:0],Data_in};  //MODE=1 =>Left shift
      Q<=q_temp[3];                  //MODE=0 =>Right shift
      end
      else begin
        q_temp<={Data_in,q_temp[3:1]};
        Q<=q_temp[0]; 
      end
    end
    
  end
endmodule
