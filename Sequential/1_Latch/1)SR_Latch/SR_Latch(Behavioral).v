module SR_latch(input S,R,reset, output reg Q,output Qb);
  always @(*) begin
    if (reset)
      Q=0;
    else if (S==1 && R==0)
      Q=1;
    else if (S==0 && R==1)
      Q=0;
    else if (S==0 && R==0)
      Q=Q;   // hold
    else
      Q=1'bx; // invalid
  end

  assign Qb = ~Q;
endmodule
