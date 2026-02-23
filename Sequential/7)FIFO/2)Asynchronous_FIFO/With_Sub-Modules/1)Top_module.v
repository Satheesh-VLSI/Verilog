//top module 

`include "Synchronizer.v"
`include "Write_handler.v"
`include "Read_Handler.v"
`include "Memory.v"

module async_fifo #(parameter W=8,D=32) (w_clk,r_clk,r_rst,w_rst,w_en,r_en,d_in,d_out,full,empty);

  input w_clk,r_clk,r_rst,w_rst,w_en,r_en;
  input [W-1:0] d_in;
  output reg full,empty;
  output reg [W-1:0] d_out;
  
  
  
    
  reg [$clog2(D):0] r_ptr_gray,w_ptr_gray;
  reg [$clog2(D):0] r_ptr_bin,w_ptr_bin,
                    r_ptr_syncgray,w_ptr_syncgray,
                    r_sync1,w_sync1;
  //write handler
  write_ptr_handler #(.W(W),.D(D)) write (.w_clk(w_clk),
                                          .w_rst(w_rst),
                                          .w_en(w_en),
                                          .full(full),
                                          .r_ptr_syncgray(r_ptr_syncgray),
                                          .w_ptr_bin(w_ptr_bin),
                                          .w_ptr_gray(w_ptr_gray));
  
  
  //read handler
  read_ptr_handler  #(.W(W),.D(D)) read (.r_clk(r_clk),
                                         .r_rst(r_rst),
                                         .r_en(r_en),
                                         .empty(empty),
                                         .w_ptr_syncgray(w_ptr_syncgray),
                                         .r_ptr_bin(r_ptr_bin),
                                         .r_ptr_gray(r_ptr_gray));
  
  //write ptr sync with read clock
  two_FF_synchronizer  #(.W(W),.D(D)) w_sync (.clk(r_clk),
                                              .rst(r_rst),
                                              .gray(w_ptr_gray),
                                              .sync_gray(w_ptr_syncgray));
  
  //read ptr sync with write clock
  two_FF_synchronizer  #(.W(W),.D(D)) r_sync (.clk(w_clk),
                                              .rst(w_rst),
                                              .gray(r_ptr_gray),
                                              .sync_gray(r_ptr_syncgray));
  
  //Memory circuit
  memory  #(.W(W),.D(D)) fifo_memory (.w_clk(w_clk),
                                      .r_clk(r_clk),
                                      .w_rst(w_rst),
                                      .r_rst(r_rst),
                                      .w_en(w_en),
                                      .r_en(r_en),
                                      .w_ptr_bin(w_ptr_bin),
                                      .r_ptr_bin(r_ptr_bin),
                                      .full(full),
                                      .empty(empty),
                                      .d_in(d_in),
                                      .d_out(d_out));
endmodule
