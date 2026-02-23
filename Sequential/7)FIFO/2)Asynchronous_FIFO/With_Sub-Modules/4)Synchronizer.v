  //synchronizer
    
  module two_FF_synchronizer #(parameter W=8,D=32)(clk,rst,gray,sync_gray);
      input clk,rst;
      input [$clog2(D):0] gray;
      output reg [$clog2(D):0] sync_gray;
      
    reg [$clog2(D):0] sync; 
      
    always @(posedge clk or posedge rst)begin
    
    if(rst)begin
      sync<=0;
      sync_gray<=0;
    end
    else begin
      sync<=gray;
      sync_gray<=sync;
    end
  end
    endmodule
  
