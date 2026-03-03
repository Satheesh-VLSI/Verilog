//Sequence Detector 1011- Moore Overlapping

module seq_detect(input Data_in,clk,rst,output reg out);
  reg [2:0] state,next;
  
  localparam S1=3'b000,
              S2=3'b001,
              S3=3'b010,
              S4=3'b011,
              S5=3'b100;
  
  always @(posedge clk or posedge rst)begin
    if (rst)
      state<=S1;
    else
      state<=next;
  end
  
  always @(*) begin
    out=0;
    next=S1;
    case(state)
        S1:begin next=Data_in?S2:S1; end
        S2:begin next=Data_in?S2:S3; end
        S3:begin next=Data_in?S4:S1; end
        S4:begin next=Data_in?S5:S3; end
        S5:begin next=Data_in?S2:S3; out=1; end
      default:next=S1;
    endcase
  end
endmodule
  
  
  
