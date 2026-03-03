//Design for 16 x 8 bits Synchronous FIFO with Full and Empty
module Sync_FIFO #(parameter Width=8,Depth=16)(clk,rst,full,empty,data_in,data_out,w_en,r_en);
  input clk,rst,w_en,r_en;
  input [Width-1:0] data_in;
  output reg [Width-1:0] data_out;
  output full,empty;
  
  reg [$clog2(Depth)-1:0] write_ptr,read_ptr;
  reg [Width-1:0] fifo [0:Depth-1];
  
  assign full=((write_ptr+1)==read_ptr);
  assign empty=(write_ptr==read_ptr);
  
  
  always @(posedge clk or posedge rst) begin
    if(rst)begin
      write_ptr<=0;
      read_ptr<=0;
      data_out<=0;
    end
    else begin
     
            if(!full &&  w_en)begin
                fifo[write_ptr]<=data_in;
                write_ptr<=write_ptr+1;
            end
  
    
            if(!empty &&  r_en)begin
              data_out<=fifo[read_ptr];
                 read_ptr<=read_ptr+1;
             end
       end
    
  end
endmodule
