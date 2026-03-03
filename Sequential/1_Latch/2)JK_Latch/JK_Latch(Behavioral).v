module JK_latch(input J,K,reset,clk, output reg Q,output Qb);
  
  always @(*) begin
    if (reset)
      Q <= 0;
    else if(clk) begin
      case ({J,K})
        2'b00: Q<=Q;     // hold
        2'b01: Q<=0;     // reset
        2'b10: Q<=1;     // set
        2'b11: Q<=~Q;    // toggle
      endcase
      end
  end
  assign Qb = ~Q;
endmodule

