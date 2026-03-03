module single_port_RAM_Tb;
  reg [7:0] data_in;
  reg [5:0]addr;
  reg mode,clk;
  wire [7:0] data_out;
  
  integer i;
  reg [7:0] golden [0:63];
  
  single_port_RAM ram1(data_in,addr,mode,clk,data_out);
  
  always #5 clk=~clk;
  
  initial begin
 
    clk=0;
    data_in=0;
    addr=0;
    mode=0;
    
    for(i=0;i<64;i+=1) begin
      #1;
      addr=i;
      data_in=i+5;
      mode=1;
      golden[i]=i+5;
    end
    
    for(i=0;i<64;i+=1) begin
    
      addr=i;
      mode=0;
   
     #1;
      if(data_out==golden[i])
        $display("**RAM IS WORKING FINE**\t\tOut is same as GOLDEN\t\tTime=%0t,clock=%b   Address=%b  Data_in=%B  mode=%b  data_out=%D",$time,clk,addr,data_in,mode,data_out);
    else
      $display("**RAM IS NOT WORKING PROPERLY**\t\tOut is NOT same as GOLDEN\t\tTime=%0t,clock=%b   Address=%b  Data_in=%b  mode=%b  data_out=%b",$time,clk,addr,data_in,mode,data_out);
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
    
    
    
    
    
    
    
    
    
    
