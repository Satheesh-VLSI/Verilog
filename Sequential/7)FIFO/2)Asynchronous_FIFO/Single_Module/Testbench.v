module Async_fifo_TB#(parameter W=8,D=32);
  reg w_clk,r_clk,r_rst,w_rst,w_en,r_en;
  reg [W-1:0] d_in;
  wire [W-1:0] d_out;
  wire full,empty;
  integer i,j;
  
  wire [3:0]count;
  async_fifo #(.W(W),.D(D)) async (.w_clk(w_clk),.r_clk(r_clk),.w_rst(w_rst),.r_rst(r_rst),.w_en(w_en),.r_en(r_en),.d_in(d_in),.d_out(d_out),.full(full),.empty(empty));
  
  always #5 w_clk = ~w_clk;
  always #10 r_clk = ~r_clk;
  
  
  initial begin
    w_clk=0;w_rst=1; r_clk=0;r_rst=1;
    w_en=0; r_en=0;
    #15 w_rst=0; r_rst=0;

    
    write(1,0,40);
    read(0,1,5);
    write(1,0,14);
    read(0,1,40);
    

    #10 $finish;
  end
  
  //Task for FIFO Write
  task write(input w_task,input r_task,input [5:0]count);
    
    for(i=0;i<count;i+=1)begin
      @(negedge w_clk);
         w_en = w_task;
         r_en = r_task;
        
    
      if(!full)begin
                 d_in=2*i;
                $display("%t  POP IN:  data_in=%d  r_en=%b  w_en=%b ",$time,d_in,r_en,w_en);
      end
          else
                $display("%t  ***Cant write***FIFO Is FULL***",$time);       
    
    end
   
  endtask
  
    //Task for FIFO Read
  task read(input w_task,input r_task,input [5:0]count);
    
      for(j=0;j<count;j+=1)begin
        @(negedge r_clk);
        w_en = w_task;
        r_en = r_task;
      if(!empty)
        $display("%t  PUSH OUT:  data_out=%d  r_en=%b  w_en=%b ",$time,d_out,r_en,w_en);
      else
        $display("%t  ***Cant Read***FIFO Is EMPTY***",$time);
     end
   
  endtask

    

  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
