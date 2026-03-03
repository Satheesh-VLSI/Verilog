 //downcounter with negedge triggered clk
module ripple_counter(
  input clk, rst,
  output reg [3:0] Q
);
 
  always @(negedge clk or posedge rst) begin
    if(rst)
      Q[0]<=0;
    else
      Q[0]<=~Q[0];
  end
  
  always @(negedge ~Q[0] or posedge rst) begin
    if(rst)
      Q[1]<=0;
    else
      Q[1]<=~Q[1];
  end
  
  always @(negedge ~Q[1] or posedge rst) begin
    if(rst)
      Q[2]<=0;
    else
      Q[2]<=~Q[2];
  end
  
  always @(negedge ~Q[2] or posedge rst) begin
    if(rst)
      Q[3]<=0;
    else
      Q[3]<=~Q[3];
  end


 //downcounter with negedge triggered clk
  module ripple_counter(
  input clk, rst,
  output reg [3:0] Q
);
 
    always @(posedge clk or posedge rst) begin
    if(rst)
      Q[0]<=0;
    else
      Q[0]<=~Q[0];
  end
  
  always @(posedge Q[0] or posedge rst) begin
    if(rst)
      Q[1]<=0;
    else
      Q[1]<=~Q[1];
  end
  
  always @(posedge Q[1] or posedge rst) begin
    if(rst)
      Q[2]<=0;
    else
      Q[2]<=~Q[2];
  end
  
  always @(posedge Q[2] or posedge rst) begin
    if(rst)
      Q[3]<=0;
    else
      Q[3]<=~Q[3];
  end
  
endmodule
