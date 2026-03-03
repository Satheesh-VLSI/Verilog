 //read handler
module read_ptr_handler  #(parameter W=8,D=32)(r_clk,r_rst,r_en,empty,w_ptr_syncgray,r_ptr_bin,r_ptr_gray);
  input r_clk,r_rst,r_en;
  input [$clog2(D):0] w_ptr_syncgray;
  output reg [$clog2(D):0] r_ptr_bin,r_ptr_gray;
  output reg empty;
  
    
  wire [$clog2(D):0] r_ptr_gray_next,r_ptr_bin_next;
  wire temp_empty;
  
    
    assign r_ptr_bin_next=r_ptr_bin + ((!empty && r_en));
    assign r_ptr_gray_next=(r_ptr_bin_next) ^ ((r_ptr_bin_next)>>1);
  
  
    always @(posedge r_clk or posedge r_rst)begin
      if(r_rst)begin
      r_ptr_gray<=0;
      r_ptr_bin<=0;
      empty<=1;
    end
      
      else begin
        r_ptr_bin<=r_ptr_bin_next;
        r_ptr_gray<=r_ptr_gray_next;
        empty<=temp_empty;
      end 
  end
    assign temp_empty = (r_ptr_gray_next == w_ptr_syncgray);
  endmodule
 
