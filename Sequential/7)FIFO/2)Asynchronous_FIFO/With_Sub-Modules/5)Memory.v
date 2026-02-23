//memory
  module memory  #(parameter W=8,D=32)(w_clk,r_clk,w_rst,r_rst,w_en,r_en,w_ptr_bin,r_ptr_bin,full,empty,d_in,d_out); 
        
        input w_clk,r_clk,w_rst,r_rst,w_en,r_en,full,empty;
        input [W-1:0] d_in;
        input [$clog2(D):0] w_ptr_bin,r_ptr_bin;
        output reg [W-1:0]  d_out;
    
        reg [W-1:0] memory [0:D-1]; 
        
        always @(posedge w_clk or posedge w_rst) begin
            if (w_rst)
                  ; 
            else if (!full & w_en)
              memory [ w_ptr_bin[$clog2(D)-1:0]]<=d_in; //write
        end  
           
        always @(posedge r_clk or posedge r_rst) begin
          if (r_rst)
            ;
          else if (!empty & r_en)
            d_out <=memory [ r_ptr_bin[$clog2(D)-1:0]]; //read
          end  
       
      endmodule
  
