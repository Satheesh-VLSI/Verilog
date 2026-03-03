//serial right shift
module SISO(input Data_in, input clk,rst,output reg Q );
  reg [3:0] q_temp;
  
  always @(posedge clk)begin
    if(rst)begin
      q_temp<=0;
      Q<=0;
    end                // here LSB is  Q[0] and MSB is Q[3]
    else begin
      q_temp<=q_temp>>1;  //q_temp={Data_in,q_temp[2:0]};
      q_temp[3]<=Data_in;
      Q<=q_temp[0];
    end
    
  end
endmodule
