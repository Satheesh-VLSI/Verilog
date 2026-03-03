//Sequence Detector 1011- Mealy NON-Overlapping

module seq_detect(input Data_in,clk,rst,output reg out);
  reg [1:0] state,next;
  
  localparam S1=2'b00,
              S2=2'b01,
              S3=2'b10,
              S4=2'b11;
  
  always @(posedge clk or posedge rst)begin
    if (rst)
      state<=S1;
    else
      state<=next;
  end
  
  always @(*) begin
    next=state;
    case(state)
        S1: next=Data_in?S2:S1; 
        S2: next=Data_in?S2:S3; 
        S3: next=Data_in?S4:S1;  
        S4: next=Data_in?S1:S3;
        default:next=S1;
    endcase
  end
      
  always@(posedge clk or posedge rst)begin
    if(rst)
      out=0;
    else
      out=(state==S4 && Data_in==1);
  end
endmodule
  
  
  
