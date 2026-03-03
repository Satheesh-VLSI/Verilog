//Universal Shift Register
module Universal_Shift_Register(input [3:0] parallel_in,input [2:0]MODE,
                                input serial_in,clk,rst,output reg serial_Q ,
                                output reg [3:0] parallel_Q);
  reg [3:0] q_temp;
  always @(posedge clk)begin
    if(rst)begin
      q_temp<=4'b0000;
      serial_Q<=0;
    end                   // here LSB is  Q[0] and MSB is Q[3]
    else begin
      case(MODE)
        0:begin 
          q_temp<=q_temp;
          serial_Q<=q_temp[3];
          end
        1:begin 
          q_temp<={serial_in,q_temp[3:1]};
          serial_Q<=q_temp[0];
          end                            //MODE=0 =>NO change
        2:begin                          //MODE=1 =>SHIFT RIGHT
          q_temp<={q_temp[2:0],serial_in};    //MODE=2 =>Left shift
          serial_Q<=q_temp[3];           //MODE=3 =>PARALLEL LOAD
          end                            //Default => Parallel OUT
         3: begin
            q_temp<=parallel_in;
            serial_Q<=q_temp[3];
          end
        default:begin
          parallel_Q<=q_temp;
           end
          
      endcase
    end
    
  end
endmodule
