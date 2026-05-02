`timescale 1ns / 1ps

module Sync_FIFO_tb;

  parameter Width=8;
  parameter Depth=32;

  reg w_clk,w_rst;
  reg r_clk,r_rst;
  reg [Width-1:0] data_in;
  reg w_en;
  reg r_en;

  wire [Width-1:0] data_out;
  wire full;
  wire empty;

  // -------------------Reference Model Variables--------------------------
  reg [Width-1:0] ref_fifo [0:64]; 
  integer ref_wr_ptr;
  integer ref_rd_ptr;
  reg [Width-1:0] expected_data;
  
  //DUT
  Async_FIFO #(Width,Depth) uut (.w_clk(w_clk),
                                 .w_rst(w_rst),
                                 .r_clk(r_clk),
                                 .r_rst(r_rst),
                                 .full(full),
                                 .empty(empty),
                                 .d_in(data_in),
                                 .d_out(data_out),
                                 .w_en(w_en),
                                 .r_en(r_en));

  always #5 w_clk=~w_clk;
  
  always #10 r_clk=~r_clk;
  initial begin
    w_clk=0;
    r_clk=0;
  end

  integer i;
  integer j;
  integer error_count;

  initial begin
    w_rst=1;
    r_rst=1;
    data_in=0;
    w_en=0;
    r_en=0;
    error_count=0;
    
    ref_wr_ptr=0;
    ref_rd_ptr=0;

    #40; 
      @(negedge w_clk);
      @(negedge r_clk);
    w_rst=0;
    r_rst=0;
    
    $display("=========================================================");
    $display("         SELF-CHECKING TB: Synchronous FIFO ");
    $display("=========================================================");

    if (empty!=1'b1 || full!=1'b0) begin
      $display("ERROR at Time %0t : FIFO should be empty and not full after reset.", $time);
      error_count=error_count+1;
    end

     // -------------------------Phase 1----------------------------
    $display("\nPHASE 1 => Writing %0d RANDOM values to fill the FIFO...", Depth);
    for (i=0; i<(Depth); i=i+1) begin
      @(negedge w_clk);
      w_en=1;
      data_in=$random; 
      
      ref_fifo[ref_wr_ptr]=data_in;
      ref_wr_ptr=ref_wr_ptr+1;
    end
    @(negedge w_clk);
    w_en=0;

    if (full!=1'b1 || empty!=1'b0) begin
      $display("ERROR at Time %0t: FIFO should be FULL and not empty now.", $time);
      error_count=error_count+1;
    end

    
    // -------------------------Phase 2----------------------------
    $display("\nPHASE 2 => Reading half the FIFO to verify data...");
    for (i=0; i<(Depth/2); i=i+1) begin
      @(negedge r_clk);
      r_en=1;
      
      @(posedge r_clk);
      #5; 
      
      expected_data=ref_fifo[ref_rd_ptr];
      ref_rd_ptr=ref_rd_ptr+1;
      
      if (data_out!==expected_data) begin
        $display("ERROR at Time %0t : Data mismatch! Expected: %0d, Got: %0d", $time, expected_data, data_out);
        error_count=error_count+1;
      end
    end
    @(negedge r_clk);
    r_en=0;

    // -----------------------Phase 3---------------------------
    $display("\nPHASE 3 => Testing Concurrent Read and Write...");
    
    // fork...join runs the two blocks simultaneously
    fork
      //WRITE operation (Driven only by w_clk)
      begin
        for (i=0;i<5;i=i+1) begin
          @(negedge w_clk);
          w_en=1; 
          data_in=$random;
          
          ref_fifo[ref_wr_ptr]=data_in;
          ref_wr_ptr=ref_wr_ptr+1;
        end
        @(negedge w_clk);
        w_en=0;
      end
      
      //READ operation (Driven only by r_clk)
      begin
        for (j=0; j<5; j=j+1) begin
          @(negedge r_clk);
          r_en=1;
          
          @(posedge r_clk); 
          #5;
          expected_data=ref_fifo[ref_rd_ptr];
          ref_rd_ptr=ref_rd_ptr+1;
          
          if (data_out!==expected_data) begin
            $display("ERROR @ Time %0t: Concurrent mismatch! Expected: %0d, Got: %0d", $time, expected_data, data_out);
            error_count=error_count+1;
          end
        end
        @(negedge r_clk);
        r_en=0;
      end
    join
    
    
    // --------------------Phase 4-------------------------------
    $display("\nPHASE 4 => Emptying remaining items from the FIFO...");
    while (empty==0) begin 
      @(negedge r_clk);
      r_en=1;
      
      @(posedge r_clk);
      
      #5;
      expected_data=ref_fifo[ref_rd_ptr];
      ref_rd_ptr=ref_rd_ptr+1;
      
      if (data_out!==expected_data) begin
        $display("ERROR at Time %0t: Data mismatch! Expected: %0d, Got: %0d", $time, expected_data, data_out);
        error_count=error_count+1;
      end
    end
    
    
    @(negedge r_clk);
    r_en=0;

     //check empty
    if (empty!=1'b1 || full!=1'b0) begin
      $display("ERROR at Time %0t: FIFO should be EMPTY after reading all elements.", $time);
      error_count=error_count+1;
    end

    
    
    $display("\n=========================================================");
    if (error_count==0) begin
      $display("      SUCCESS: All checks passed with 0 Errors.");
    end else begin
      $display("  FAILURE: DUT Failed with %0d errors.", error_count);
    end
    $display("=========================================================\n");

    $finish;
  end

endmodule
