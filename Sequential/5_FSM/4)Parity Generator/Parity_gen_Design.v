//moore
module parity_gen_FSM(input clk,rst,input [2:0]x,output reg odd,even);
  reg [1:0] state,next;
  localparam s0=0, //even number of ones here
             s1=1; //odd number of ones here
  wire exor;
  
  assign exor=(x[2]^x[1]^x[0]);
  
  always @(posedge clk or posedge rst)begin
    if(rst)
      state<=s0;
    else
      state<=next;
  end
  
  always @(*)begin
    next=state;
    odd=0;
    even=0;
    case(state)
      s0:begin 
        next=(exor)?s1:s0;
        odd=1;
        even=0;
      end
      s1:begin 
        next=(exor)?s1:s0;
        odd=0;
        even=1;
      end
      default:next=s0;
    endcase
    
  end
endmodule
      
