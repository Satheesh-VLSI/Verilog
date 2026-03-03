//Sequence Generator 11001- Moore NON-Overlapping

module seq_GEN(input clk,rst,output reg out);
  reg [2:0] state,next;
  
  localparam S0=3'b000,
              S1=3'b001,
              S2=3'b010,
              S3=3'b011,
              S4=3'b100;
  
  
  always @(posedge clk or posedge rst)begin
    if (rst)
      state<=S0;
    else
      state<=next;
  end
  
  always @(*) begin
    next=state;
    case(state)
        S0: next=S1; 
        S1: next=S2; 
        S2: next=S3;  
        S3: next=S4;
        S4: next=S0;
        default:next=S1;
    endcase
  end
      
  always@(posedge clk or posedge rst)begin
    if(rst)
      out<=0;
    else begin
      out=(state==S0)?1:
      (state==S1)?1:
      (state==S2)?0:
      (state==S3)?0:
      (state==S4)?1:out;
         
    end
  end
endmodule
  
  
  
