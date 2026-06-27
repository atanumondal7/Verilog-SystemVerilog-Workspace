design.sv:

`timescale 1ns/1ps

module dff (
  input wire clk,
  input wire rst,
  input wire d,
  output reg q
);
  
  always @(posedge clk or posedge rst) begin
   
    if (rst == 1'b1) begin
      	q <= 1'b0;
    end
    
    else begin
    	q <= d;
    end
    
  end
  
endmodule



testbench.sv:

`timescale 1ns/1ps

module tb_dff;
  
  reg test_clk;
  reg test_rst;
  reg test_d;
  wire test_q;
  
  dff uut(
    .clk(test_clk),
    .rst(test_rst),
    .d(test_d),
    .q(test_q)
  );
  
  initial begin
    test_clk = 0;
    test_d = 0;
  end
  
  always begin
      #5 test_clk = ~test_clk;
    end
  
  initial begin 
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_dff);
    
    test_rst = 1; #5; test_rst = 0; #5    
    
    test_d = 0; #10;
    test_d = 1; #10; 
    test_d = 0; #10;
    test_d = 1; #10;
    
    $finish;
    
  end
  
endmodule



EDA Playground file link - https://www.edaplayground.com/x/8j_9
