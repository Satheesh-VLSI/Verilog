module sync_fifo_TB#(parameter Width=8,Depth=16);
  reg clk, rst;
  reg w_en, r_en;
  reg [7:0] data_in;
  wire [7:0] data_out;
  wire full, empty;
  integer i,j;
  
Sync_FIFO #(.Width(Width),.Depth(Depth)) s_fifo (clk,rst,full,empty,data_in,data_out,w_en, r_en);
  
  always #2 clk = ~clk;
  initial begin
    clk = 0; rst = 1;
    w_en = 0; r_en = 0;
    #3 rst = 0;
    #1;
    //write 
    for(i=0;i<5;i+=1)begin
      w_en=1;r_en=0;
      data_in=2*i;
      write(data_in,w_en,r_en);
    end
    #1;
    for(j=0;j<2;j+=1)begin
         w_en=0;r_en=1;
         read(w_en,r_en);
      end
    #1;
    for(i=0;i<10;i+=1)begin
      w_en=1;r_en=0;
      data_in=2*i;
      write(data_in,w_en,r_en);
    end
    #1;
    for(j=0;j<13;j+=1)begin
         w_en=0;r_en=1;
         read(w_en,r_en);
      end
    #10 $finish;
  end
  
  
  task write(input [Width-1:0]data,
    input w_en,r_en);
    
    @(posedge clk);
    if(!full)
      $display("%t  POP IN:  data_in=%d  r_en=%b  w_en=%b ",$time,data,r_en,w_en);
    else
      $display("%t  ***Cant write***FIFO Is FULL***",$time);
    
  endtask
  
    task read(input w_en,r_en);
    
      @(posedge clk);
      if(!empty)
        $display("%t  PUSH OUT:  data_out=%d  r_en=%b  w_en=%b ",$time,data_out,r_en,w_en);
    else
      $display("%t  ***Cant Read***FIFO Is EMPTY***",$time);
    
  endtask

    

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule
