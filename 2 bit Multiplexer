design.sv:

`timescale 1ns/1ps

module data_mux (
  input wire a,
  input wire b,
  input wire sel,
  output wire y
);
  
  assign y = (a & ~sel) + (b & sel);
    
    endmodule




testbench.sv:

`timescale 1ns/1ps

module tb_data_mux;
  
  reg test_a;
  reg test_b;
  reg test_sel;
  wire test_y;
  
  data_mux uut (
    .a(test_a),
    .b(test_b),
    .sel(test_sel),
    .y(test_y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_data_mux);
    
    test_a = 1; test_b = 0; test_sel = 0; #10;
    test_a = 1; test_b = 0; test_sel = 1; #10;
    test_a = 0; test_b = 1; test_sel = 0; #10;
    test_a = 0; test_b = 1; test_sel = 1; #10;
    
    $finish;
    
  end
  
endmodule



EDA Playground file link - https://www.edaplayground.com/x/jRVg
