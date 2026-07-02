design.sv:

`timescale 1ns/1ps

module fullsubtractor (
  input wire a,
  input wire b,
  input wire bin,
  output wire y,
  output wire bout
);
  
  wire diff1;
  wire bout1;
  wire bout2;
  
  halfsubtractor diff_one (
    .a(a),
    .b(b),
    .y(diff1),
    .bout(bout1)
  );
  
  halfsubtractor diff_two (
    .a(diff1),
    .b(bin),
    .y(y),
    .bout(bout2)
  );
  
  or u_or0(bout, bout1, bout2);
  
endmodule
  

module halfsubtractor (
  input wire a,
  input wire b,
  output wire y,
  output wire bout
);
  
  wire not0_out;
  
  xor u_xor0(y, a, b);
  
  not u_not0(not0_out, a);
  
  and u_and0(bout, not0_out, b);
  
endmodule




testbench.sv:

`timescale 1ns/1ps

module tb_fullsubtractor;
  
  reg test_a;
  reg test_b;
  reg test_bin;
  wire test_y;
  wire test_bout;
  
  fullsubtractor uut (
    .a(test_a),
    .b(test_b),
    .bin(test_bin),
    .y(test_y),
    .bout(test_bout)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_fullsubtractor);
    
    test_a = 0; test_b = 0; test_bin = 0; #10;
    test_a = 0; test_b = 0; test_bin = 1; #10;
    test_a = 0; test_b = 1; test_bin = 0; #10;
    test_a = 0; test_b = 1; test_bin = 1; #10;
    test_a = 1; test_b = 0; test_bin = 0; #10;
    test_a = 1; test_b = 0; test_bin = 1; #10;
    test_a = 1; test_b = 1; test_bin = 0; #10;
    test_a = 1; test_b = 1; test_bin = 1; #10;
    
    $finish;
    
  end
  
endmodule



EDA Playground link - https://www.edaplayground.com/x/nwM6
