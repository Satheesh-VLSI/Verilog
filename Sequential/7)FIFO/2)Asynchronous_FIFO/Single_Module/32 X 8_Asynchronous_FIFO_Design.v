//DESIGN OF 32 X 8 BITS (32 Bytes) Asynchronous FIFO
module Async_FIFO #(parameter W=8,D=32)(w_clk,r_clk,r_rst,w_rst,w_en,r_en,d_in,d_out,full,empty);
  
  input w_clk,r_clk,r_rst,w_rst,w_en,r_en;
  input [W-1:0] d_in;
  output reg full,empty;
  output reg [W-1:0] d_out;
  
  wire temp_full,temp_empty;
  
  reg [W-1:0] FIFO [0:D-1];  //MEMORY
  
  
  wire [$clog2(D):0] r_ptr_gray,w_ptr_gray;
  reg [$clog2(D):0] r_ptr_bin,w_ptr_bin,
                    r_ptr_syncgray,w_ptr_syncgray,
                    r_sync1,w_sync1;
  
  
  wire [$clog2(D):0] w_ptr_gray_next,r_ptr_gray_next;
  wire [$clog2(D):0] w_ptr_bin_next,r_ptr_bin_next;
  
  assign w_ptr_bin_next=w_ptr_bin + ((!full && w_en));
  assign r_ptr_bin_next=r_ptr_bin + ((!empty && r_en));
  

  assign w_ptr_gray=(w_ptr_bin ) ^ ((w_ptr_bin)>>1);
  assign r_ptr_gray=(r_ptr_bin ) ^ ((r_ptr_bin)>>1);
  
  assign w_ptr_gray_next=(w_ptr_bin_next) ^ ((w_ptr_bin_next)>>1);
  assign r_ptr_gray_next=(r_ptr_bin_next) ^ ((r_ptr_bin_next)>>1);
  
  
  //synchronize write pointer with read clock
  always @(posedge r_clk or posedge r_rst)begin
    
    if(r_rst)begin
      w_sync1<=0;
      w_ptr_syncgray<=0;
      w_ptr_bin<=0;
    end
    else begin
      w_sync1<=w_ptr_gray;
      w_ptr_syncgray<=w_sync1;
    end
  end
  
  
    
  //synchronize read pointer with write clock
  always @(posedge w_clk or posedge w_rst)begin
    
    if(w_rst)begin
      r_sync1<=0;
      r_ptr_syncgray<=0;
      r_ptr_bin<=0;
    end
    else begin
      r_sync1<=r_ptr_gray;
      r_ptr_syncgray<=r_sync1;
    end
  end
   
  
  
  //core logic
  
  always @(posedge w_clk or posedge w_rst)begin
    if(w_rst)
      full<=0;
    else begin
      if(!full & w_en)
      FIFO[w_ptr_bin[$clog2(D)-1:0]]<=d_in;
      w_ptr_bin<=w_ptr_bin_next;
    end
    full<=temp_full;
  end
  
  always @(posedge r_clk or posedge r_rst)begin
    if(r_rst)
      empty<=1;
    else begin
      if(!empty & r_en)
        d_out<=FIFO[r_ptr_bin[$clog2(D)-1:0]];
        r_ptr_bin<=r_ptr_bin_next;
      
    end
    empty<=temp_empty;
  end
      
assign temp_full=(w_ptr_gray_next=={~r_ptr_syncgray[$clog2(D)],r_ptr_syncgray[$clog2(D)-1:0]});
assign temp_empty=(r_ptr_gray_next==w_ptr_syncgray);
  
endmodule
  
  
  
  
  
/*

                              ///****UNDER CONSTRUCTION****\\\

module Async_FIFO #(parameter W=8,D=32)(w_clk,r_clk,r_rst,w_rst,w_en,r_en,d_in,d_out,full,empty);
  
  input w_clk,r_clk,r_rst,w_rst,w_en,r_en;
  input [W-1:0] d_in;
  output reg full,empty;
  output reg [W-1:0] d_out;
  
  reg [$clog2(D):0] r_ptr_bin,w_ptr_bin,r_ptr_gray,w_ptr_gray,r_ptr_syncgray,w_ptr_syncgray,r_sync1,w_sync1;
  
  reg [W-1:0] FIFO [0:D-1];
 
  
  //synchronization of write pointer with read clock
  always @(posedge r_clk) begin
    w_sync1<=w_ptr_gray;
    w_ptr_syncgray<=w_sync1;
  end
  
  //synchronization of read pointer with write clock
  always @(posedge w_clk) begin
    r_sync1<=r_ptr_gray;
    r_ptr_syncgray<=r_sync1;
  end
  
  
  
 ///CORE LOGIC 
  always @(posedge w_clk)begin
    
    if(w_rst)begin   //resetting the fifo
      w_ptr_bin<=0;
      w_ptr_gray<=0;
      w_ptr_syncgray<=0;
      full<=0;
    end
    
    else begin    //FIFO write operation
    if(!full && w_en)begin
      FIFO[w_ptr_bin]<=d_in;
      w_ptr_bin<=w_ptr_bin+1;
    end
    end
    
    bin_to_gray((w_ptr_bin+1),w_ptr_gray);
    full<=(w_ptr_gray=={~r_ptr_syncgray[$clog2(D)],r_ptr_syncgray[$clog2(D)-1:0]});
  end
  
  always @(posedge r_clk)begin
    
    if(r_rst)begin   //resetting the fifo
      r_ptr_bin<=0;
      r_ptr_gray<=0;
      r_ptr_syncgray<=0;
      empty<=1;
      
    end
    
    else begin    //FIFO read operation
      if(!empty && r_en)begin
        d_out<=FIFO[r_ptr_bin];
        r_ptr_bin<=r_ptr_bin+1;
    end
    end
    bin_to_gray((r_ptr_bin+1),r_ptr_gray);
    
    empty<=(r_ptr_gray==w_ptr_syncgray);
  
  
  end
  
  
  
  task bin_to_gray(input [$clog2(D):0] binary,
    output [$clog2(D):0] gray);
    
    integer i;
    
    begin
      
    gray [$clog2(D)]=binary[$clog2(D)];
      
    for (i=1;i<=$clog2(D);i+=1)
      gray [$clog2(D)-i]=binary[$clog2(D)-i]^binary[$clog2(D)-i+1];
      
    end
  endtask
  
  
endmodule */
    
   
