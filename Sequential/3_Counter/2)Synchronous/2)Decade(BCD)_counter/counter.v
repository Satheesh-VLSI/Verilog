module Decade (input clk,rst,output reg [3:0]Q);
  
  always @(posedge clk) begin
    if (rst)
      Q<=4'b0000;
    else if (Q==4'b1001)
      Q<=4'b0000;
    else
      Q<=Q+1;
  end
endmodule

