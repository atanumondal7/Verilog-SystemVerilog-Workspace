design.sv:

`timescale 1ns/1ps

module counter4bit (
  input wire clk,
  input wire rst,
  input wire en,
  output reg [3:0] count
);
  
  always @(posedge clk or posedge rst) begin
    
    if(rst == 1'b1) begin
      	count <= 4'b0000;
    end
    
    else begin
      count <= count + 4'b0001;
    end
   
  end
  
endmodule



testbench.sv:

`timescale 1ns/1ps

module tb_counter4bit;
  
  reg test_clk;
  reg test_rst;
  reg test_en;
  wire [3:0]test_count;
  
  integer error_count = 0;
  
  counter4bit uut (
    .clk(test_clk),
    .rst(test_rst),
    .en(test_en),
    .count(test_count)
  );
  
  initial begin 
    test_clk = 0;
  end
  
  always begin
    #5 test_clk = ~test_clk;
  end
  
  task reset_sequence ();
    begin
      test_rst = 1;
      test_en = 0;
      #5;
      test_rst = 0;
      #5;
    end
  endtask
  
  task check_count(input [3:0] expected_value);
    begin
      
      @(posedge test_clk);
      #1;
      
      if(test_count !== expected_value) begin
        $display("[ERROR] Time = %0t | Expected: %d, Got: %d", $time, expected_value, test_count);
        error_count = error_count + 1;
      end
      
      else begin
        $display("[SUCCESS] Time = %0t | Matches expected: %d", $time, test_count);
      end
      
    end
    
  endtask
  
  initial begin
    
    test_clk = 0;
    
    reset_sequence();
    
    if(test_count !== 4'b0000) begin
      $display("[ERROR] Reset failed!");
    end
    
    $display("\n-------Starting Count Test-------");
    test_en = 1;
    
    check_count(4'd1);
    check_count(4'd2);
    check_count(4'd3);
    check_count(4'd4);
    check_count(4'd5);
    
    $display("\n-------Testing Enable Disable------");
    test_en = 0;
    #10;
    if(test_count !== 4'd5) begin
      $display("[ERROR] Counter advanced while disabled!");
    end
    else begin
      $display("[ERROR] Counter held value while disabled.");
    end
    
    $display("\n-------Test Report---------");
    if(error_count == 0) begin
      $display(">>>> PASSED: All tests passed cleanly! <<<<");
    end
    else begin
      $display(">>>> FAILED: Found %d errors in simulation.", error_count);
    end
    
    $finish;
    
  end
  
endmodule



EDA Playground link - https://www.edaplayground.com/x/EBLn
