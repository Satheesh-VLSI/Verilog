
//Asynchronous BCD counter
module Decade(input clk,rst,output reg [3:0] Q);
  wire decade_rst;
  assign  decade_rst=rst |(Q[3]&~Q[2]&Q[1]&~Q[0]);
  
  always @(posedge clk or posedge decade_rst) begin
    if(decade_rst)
      Q[0]<=1'b0;
    else
      Q[0]<=~Q[0];
  end
  
  always @(posedge ~Q[0] or posedge decade_rst) begin
    if(decade_rst)
      Q[1]<=1'b0;
    else
      Q[1]<=~Q[1];
  end
  
  always @(posedge ~Q[1] or posedge decade_rst) begin
    if(decade_rst)
      Q[2]<=1'b0;
    else
      Q[2]<=~Q[2];
  end
  
  always @(posedge ~Q[2] or posedge decade_rst) begin
    if(decade_rst)
      Q[3]<=1'b0;
    else
      Q[3]<=~Q[3];
  end

endmodule



