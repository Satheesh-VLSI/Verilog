module dual_port_RAM_Tb;
  reg [7:0] data_in_A,data_in_B;
  reg [5:0]addr_A,addr_B;
  reg mode_A,mode_B,clk;
  wire [7:0] data_out_A,data_out_B;
  
  integer i;
  reg [7:0] golden [0:63];
  
  dual_port_RAM ram1(data_in_A,data_in_B,addr_A,addr_B,mode_A,mode_B,clk,data_out_A,data_out_B);
  
  always #5 clk=~clk;
  
  initial begin
 
    clk=0;

    data_in_B=0; data_in_A=0;
    addr_B=0; addr_A=0;
    mode_B=0;mode_A=0;
    
    for(i=0;i<32;i+=1) begin
      @(negedge clk);
      addr_A=2*i;
      addr_B=(2*i)+1;
      mode_A=1;
      mode_B=1;
      data_in_A=i+5;
      data_in_B=i+10;
     
      golden[2*i]=i+5;
      golden[(2*i)+1]=i+10;
    end
    
    for(i=0;i<32;i+=1) begin
      @(negedge clk);
      addr_A=2*i;
      addr_B=(2*i)+1;
      mode_A=0;
      mode_B=0;
      
      @(posedge clk);
      @(posedge clk);
      
      //TO CHECK THE FIRST OUTPUT 
      if(data_out_A==golden[2*i])
        $display("**RAM IS WORKING FINE**\t\tOut is same as GOLDEN\t\tTime=%0t,clock=%b   Address_A=%b  Address_B=%b   mode_A=%b  mode_B=%b data_out_A=%d data_out_B=%d",$time,clk,addr_A,addr_B,mode_A,mode_B,data_out_A,data_out_B);
      else
      $display("**RAM IS NOT WORKING PROPERLY**\t\tOut is NOT same as GOLDEN\t\tTime=%0t,clock=%b   Address_A=%b  Address_B=%b    mode_A=%b  mode_B=%b data_out_A=%d data_out_B=%d",$time,clk,addr_A,addr_B,mode_A,mode_B,data_out_A,data_out_B);
      //TO CHECK THE SECOND OUTPUT
      if(data_out_B==golden[(2*i)+1])
        $display("**RAM IS WORKING FINE**\t\tOut is same as GOLDEN\t\tTime=%0t,clock=%b   Address_A=%b  Address_B=%b   mode_A=%b  mode_B=%b data_out_A=%d data_out_B=%d",$time,clk,addr_A,addr_B,mode_A,mode_B,data_out_A,data_out_B);
      else
      $display("**RAM IS NOT WORKING PROPERLY**\t\tOut is NOT same as GOLDEN\t\tTime=%0t,clock=%b   Address_A=%b  Address_B=%b   mode_A=%b  mode_B=%b data_out_A=%d data_out_B=%d",$time,clk,addr_A,addr_B,mode_A,mode_B,data_out_A,data_out_B);
    end
/*negedge:   addr = 3
posedge 1: register loads memory[3]   (output still old)
posedge 2: output becomes memory[3]   (correct)*/
                 
    
    #10 $finish;
  end
    initial begin
    $dumpfile("sq.vcd");
    $dumpvars;
  end
endmodule
    
    
    
    
    
    
    
    
    
    
