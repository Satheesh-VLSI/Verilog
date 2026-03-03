//Design for 64 x 8 bits DUAL port RAM (Synchronous write and Asynchronous Read)
module dual_port_RAM(data_in_A,data_in_B,addr_A,addr_B,mode_A,mode_B,clk,data_out_A,data_out_B);
  input [7:0] data_in_A,data_in_B;
  input [5:0]addr_A,addr_B;
  input mode_A,mode_B,clk;
  output  reg [7:0]data_out_A,data_out_B;
  
  /*mode=1 => Write
    mode=0 => Read*/
  reg [7:0] memory [0:63];
  //Write
  always @(posedge clk )begin
    if(addr_A!=addr_B) begin      //this runs only the two addresses are different
        if (mode_A)
            memory[addr_A]<=data_in_A;
        if (mode_B)
            memory[addr_B]<=data_in_B;
    end
    else                      //IF Both address are same ,to avoid conflict i am giving priority Data_in_A
      if (mode_A)
            memory[addr_A]<=data_in_A;
   
  end
     
    //Read
  always @(*)begin
      if (!mode_A)
         data_out_A=memory[addr_A];
      else
         data_out_A=0;
      if (!mode_B)
         data_out_B=memory[addr_B];
      else
         data_out_B=0;
  end
endmodule
