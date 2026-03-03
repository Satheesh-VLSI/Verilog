module RING_gate(input clk,rst,preset,output reg [3:0] Q);

 
  d_ff d0(Q[3],clk,preset,Q[0]);
  d_ff d1(Q[0],clk,rst,Q[1]);
  d_ff d2(Q[1],clk,rst,Q[2]);
  d_ff d3(Q[2],clk,rst,Q[3]);
 
endmodule


/*module RING_gate(input clk,rst,preset,output reg [3:0] Q);

 
  d_ff1 d0(Q[3],clk,rst,Q[0]);
  d_ff d1(Q[0],clk,rst,Q[1]);
  d_ff d2(Q[1],clk,rst,Q[2]);
  d_ff d3(Q[2],clk,rst,Q[3]);
 
endmodule

module d_ff1(input d,clk,rst, output reg q );
  always @(posedge clk) begin
    if (rst)
      q<=1;
  else
    q<=d;
  end
endmodule*/

module d_ff(input d,clk,preset,rst, output reg q );
  always @(posedge clk) begin
    if (rst)
      q<=0;
   else if (preset)
      q<=1;
   else 
      q<=d;
   end
endmodule
