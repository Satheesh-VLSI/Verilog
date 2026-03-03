module PIPO #(parameter N=4)(input [N-1:0]Data_in, clk,rst,output reg [N-1:0] Q );
  always @(posedge clk)begin
    if(rst)begin
      Q<={N{1'B0}};
    end                // here LSB is  Q[0] and MSB is Q[3]
    else begin
      Q<=Data_in;
    end
  end
endmodule
