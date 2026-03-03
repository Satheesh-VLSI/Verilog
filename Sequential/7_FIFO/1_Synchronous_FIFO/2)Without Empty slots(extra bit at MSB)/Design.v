//Design for 16 x 8 bits Synchronous FIFO with Full and Empty (without EMPTY Slots)
module Sync_FIFO #(parameter Width=8,Depth=16)(clk,rst,full,empty,data_in,data_out,w_en,r_en);
  
  input clk,rst,w_en,r_en;
  input [Width-1:0] data_in;
  output reg [Width-1:0] data_out;
  output full,empty;
  
  reg [$clog2(Depth):0] write_ptr,read_ptr; //extra bit in poingter MSB
  
  reg [Width-1:0] fifo [0:Depth-1];       //FIFO Memory
  
  
  assign full=((write_ptr[$clog2(Depth)-1:0]==read_ptr[$clog2(Depth)-1:0])&&(write_ptr[$clog2(Depth)]^read_ptr[$clog2(Depth)]));
  assign empty=(write_ptr==read_ptr);
  /* **Alter** 
   assign full=((write_ptr[$clog2(Depth)-1:0]==read_ptr[$clog2(Depth)-1:0])&&(write_ptr[$clog2(Depth)]!=read_ptr[$clog2(Depth)]));
  assign empty=(write_ptr==read_ptr);
  
  */
  
  
  always @(posedge clk or posedge rst) begin
    if(rst)begin
      write_ptr<=0;
      read_ptr<=0;
      data_out<=0;
    end
    else begin
            //FIFO Write
            if(!full &&  w_en)begin
              fifo[write_ptr[$clog2(Depth)-1:0]]<=data_in;
                write_ptr<=write_ptr+1;
            end
  
            //FIFO Read
            if(!empty &&  r_en)begin
              data_out<=fifo[read_ptr[$clog2(Depth)-1:0]];
                 read_ptr<=read_ptr+1;
             end
       end
    
  end
endmodule
