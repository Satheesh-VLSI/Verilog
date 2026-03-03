//Universal Shift Register
module Universal_Shift_Register(input [3:0] P_in,input [1:0]MODE,
                                input S_in,clk,rst,output serial_Q,
                                output [3:0] parallel_Q);

  wire [3:0]q,O;
  assign O[0]=(MODE==0)?q[0]:
    (MODE==1)?S_in:
    (MODE==2)?q[1]:
    (MODE==3)?P_in[0]:
    q[0];
  assign O[1]=(MODE==0)?q[1]:
    (MODE==1)?q[0]:
    (MODE==2)?q[2]:
    (MODE==3)?P_in[1]:
    q[1];
  assign O[2]=(MODE==0)?q[2]:
    (MODE==1)?q[1]:
    (MODE==2)?q[3]:
    (MODE==3)?P_in[2]:
    q[2];
  assign O[3]=(MODE==0)?q[3]:
    (MODE==1)?q[2]:
    (MODE==2)?S_in:
    (MODE==3)?P_in[3]:
    q[3];
          
    assign serial_Q = (MODE==1)? q[0] :
                    (MODE==2)? q[3] :
                               q[3];
  assign parallel_Q=q;
 
  
  d_ff df1(O[0],clk,rst,q[0]); 
  d_ff df2(O[1],clk,rst,q[1]);
  d_ff df3(O[2],clk,rst,q[2]);
  d_ff df4(O[3],clk,rst,q[3]);
 
endmodule
//d_flipflop
module d_ff(input d,clk,rst,output reg q );
  always @(posedge clk) begin
    if (rst)
      q<=0;
   else 
      q<=d;
   end
endmodule

//Testbench
module SHIFTREGISTER_Tb ;
  reg [3:0]P_in;
  reg [1:0] MODE;
  reg S_in,clk,rst;
  wire  serial_Q;
  wire [3:0] parallel_Q;
  
  Universal_Shift_Register r1(P_in,MODE,S_in,clk,rst,serial_Q,parallel_Q);
   
 initial clk=1'b1;
 always 
   #5 clk=~clk;
initial begin
  rst=1;#15 rst=0; P_in=4'b0000;MODE=2'd0;
  #30 MODE=2'd3;P_in=4'b0111;
  #30 MODE=2'd1;S_in=1'b0;
  #30 MODE=2'd3;P_in=4'b0010;
  #30 MODE=2'd2;S_in=1'b1;

  #100 $finish;
end

  initial begin
    $monitor($time,"\t Datain=%b clk =%b RST=%B   Serial out=%b  Parallel out=%b",P_in,clk,rst,serial_Q,parallel_Q);
    $dumpfile("count.vcd");
    $dumpvars;
  end
endmodule


  
 
  
