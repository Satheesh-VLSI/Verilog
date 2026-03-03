
module SR_ff(S, R, clk, rst, q);
  input S, R, clk, rst;
  output reg q;

  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= 1'b0;
    else
      case ({S,R})
        2'b00: q <= q;      
        2'b01: q <= 1'b0; 
        2'b10: q <= 1'b1;  
        2'b11: q <= 1'bx;  
        default: q <= 1'bx;
      endcase
  end
endmodule
