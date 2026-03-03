//Sequence Detector all machines for sequence 001

module seq_detect(input Data_in,clk,rst,MACHINE,OVERLAP,output reg out);
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
    out=0;
    next=state;
    case(state)
        S1: next=Data_in?S1:S2; 
        S2: next=Data_in?S1:S3; 
        S3:begin 
          if(Data_in)begin
            if (MACHINE) out=1;
             next=S4;
          end
           else
             next=(OVERLAP)?S3:S1;
           end
      S4:begin
        if(Data_in)
          next=S1;
        else
          next=(OVERLAP)?S2:S1;
        if (!MACHINE) out=1;
      end
        default:next=S1;
    endcase
  
  end
      

endmodule
  
  
  
