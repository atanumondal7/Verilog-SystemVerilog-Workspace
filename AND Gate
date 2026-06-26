design.sv:

`timescale 1ns/1ps

module my_first_and_gate (
  input wire a,
  input wire b,
  output wire y
);
  
  assign y = a & b;
  
endmodule



testbench.sv:

`timescale 1ns/1ps

module tb_my_first_and_gate;
  
  reg test_a;
  reg test_b;
  wire test_y;
  
  my_first_and_gate uut (
    .a(test_a),
    .b(test_b),
    .y(test_y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_my_first_and_gate);
    
    test_a = 0; test_b = 0;
    #10;
    
    test_a = 0; test_b = 1;
    #10;
    
    test_a = 1; test_b = 0;
    #10;
    
    test_a = 1; test_b = 1;
    #10;
    
    $finish;
  end
  
endmodule


EDA Playground file link - https://www.edaplayground.com/x/WxWN
