//Design for 64 x 8 bits DUAL port RAM (Synchronous read/write)
module dual_port_RAM(data_in_A,data_in_B,addr_A,addr_B,mode_A,mode_B,clk,data_out_A,data_out_B);
  input [7:0] data_in_A,data_in_B;
  input [5:0]addr_A,addr_B;
  input mode_A,mode_B,clk;
  output  reg [7:0]data_out_A,data_out_B;
  
  /*mode=1 => Write
    mode=0 => Read*/
  reg [7:0] memory [0:63];
  
  always @(posedge clk)begin
    
    if (addr_A != addr_B) begin
      //port A 
      if (mode_A)
        memory[addr_A]<=data_in_A; //write A
      else
        data_out_A<=memory[addr_A];// read A
      //port B
      if (mode_B)
        memory[addr_B]<=data_in_B; //write B
      else
        data_out_B<=memory[addr_B];// read B

      end
    else begin //if both ports have same address , to avoid conflict I am giving priority to Port A
      //port A 
      if (mode_A)
        memory[addr_A]<=data_in_A; //write A
      else
        data_out_A<=memory[addr_A];// read A
    end
  end
 
endmodule
