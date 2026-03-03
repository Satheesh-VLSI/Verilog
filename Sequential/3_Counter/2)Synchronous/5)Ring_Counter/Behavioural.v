module RING_gate(input clk,rst,output reg [3:0] Q);
  always @(posedge clk) begin
    if (rst) 
       Q<=4'b0001;
   
    else begin
    Q[0]<=Q[3];
    Q[1]<=Q[0];
    Q[2]<=Q[1];
    Q[3]<=Q[2];
    end
  end
  
endmodule

/*
N BIT RING COUNTER USING CONCANTENATION AND PARAMETER


module RING_gate #(parameter N=4) (input clk,rst, output reg [N-1:0] Q);

  always @(posedge clk) begin
    if (rst)
      Q<={{(N-1){1'b0}},1'b1};
    else
      Q<={Q[N-2:0],Q[N-1]};
  end
endmodule*/
