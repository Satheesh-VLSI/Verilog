//write handler
module write_ptr_handler #(parameter W=8,D=32)(w_clk,w_rst,w_en,full,r_ptr_syncgray,w_ptr_bin,w_ptr_gray);
  input w_clk,w_rst,w_en;
    input [$clog2(D):0] r_ptr_syncgray;
  output reg [$clog2(D):0] w_ptr_bin,w_ptr_gray;
  output reg full;
  
    
  wire [$clog2(D):0] w_ptr_gray_next,w_ptr_bin_next;
  wire temp_full;
    
  
  assign w_ptr_bin_next=w_ptr_bin + ((!full && w_en));
  assign w_ptr_gray_next=(w_ptr_bin_next) ^ ((w_ptr_bin_next)>>1);
  
  
  always @(posedge w_clk or posedge w_rst)begin
    if(w_rst)begin
      w_ptr_gray<=0;
      w_ptr_bin<=0;
      full<=0;
    end
      
      else begin
        w_ptr_bin<=w_ptr_bin_next;
        w_ptr_gray<=w_ptr_gray_next;
        full<=temp_full;
      end 
  end
    
  assign temp_full=(w_ptr_gray_next=={~r_ptr_syncgray[$clog2(D):$clog2(D)-1],r_ptr_syncgray[$clog2(D)-2:0]});
      
  
endmodule
  
