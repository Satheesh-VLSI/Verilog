module sync_counter(
  input clk, rst,
  output reg [3:0] Q
);
  
  always @(negedge clk or posedge rst) begin
    if(rst)
      Q[0]<=0;
    else
       Q[0] <= ~Q[0];                      // toggles every clock
     
    end
  always @(negedge clk or posedge rst) begin
    if(rst)
      Q[1]<=0;
    else
       Q[1] <= Q[1] ^ Q[0];                // toggles when Q0 = 1
  end
  
  always @(negedge clk or posedge rst) begin
    if(rst)
      Q[2]<=0;
    else
       Q[2] <= Q[2] ^ (Q[0] & Q[1]);       // toggles when Q0&Q1 = 1 
  end
  
  always @(negedge clk or posedge rst) begin
    if(rst)
      Q[3]<=0;
    else
      Q[3] <= Q[3] ^ (Q[0] & Q[1] & Q[2]);    // toggles when Q0&Q1&Q2 = 1 
  end
  
endmodule


/*module sync_counter_alt (input clk,input rst,output reg [3:0] Q);

  always @(posedge clk) begin
   if (rst)
      Q <= 4'b0000;
    else begin
      Q[0] <= ~Q[0];                      // toggles every clock
      Q[1] <= Q[1] ^ Q[0];                // toggles when Q0 = 1
      Q[2] <= Q[2] ^ (Q[0] & Q[1]);       // toggles when Q0&Q1 = 1
      Q[3] <= Q[3] ^ (Q[0] & Q[1] & Q[2]); 
    end
  end

endmodule*/
