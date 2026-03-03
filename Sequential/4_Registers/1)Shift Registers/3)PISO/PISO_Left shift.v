
//left  shift
module PISO #(parameter N=4)(input [N-1:0]Data_in,input load, clk,rst,output reg Q );
  reg [N-1:0]Q_temp;
  always @(posedge clk)begin
    if(rst)begin
      Q_temp<={N{1'B0}};
      Q<=0;
    end                // here LSB is  Q[0] and MSB is Q[3]
    else if (load)
     Q_temp<=Data_in;
    else begin
      Q_temp<={Q_temp[N-2:1],1'B0};
      Q<=Q_temp[N-1];
    end
  end
endmodule
