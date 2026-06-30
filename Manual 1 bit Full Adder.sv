design.sv:

`timescale 1ns/1ps

module fulladder (
  input wire a,
  input wire b,
  input wire cin,
  output wire y,
  output wire cout
);
  
  wire sum1;
  wire cout1;
  wire cout2;
  
  halfadder sub_one (
    .a(a),
    .b(b),
    .y(sum1),
    .cout(cout1)
  );
  
  halfadder sub_two (
    .a(sum1),
    .b(cin),
    .y(y),
    .cout(cout2)
  );
  
  or u_or0(cout, cout1, cout2);
  
endmodule
  

module halfadder (
  input wire a,
  input wire b,
  output wire y,
  output wire cout
);
  
  xor u_xor0(y, a, b);
  
  and u_and0(cout, a, b);
  
endmodule



testbench.sv:

`timescale 1ns/1ps

module tb_fulladder;
  
  reg test_a;
  reg test_b;
  reg test_cin;
  wire test_y;
  wire test_cout;
  
  fulladder uut (
    .a(test_a),
    .b(test_b),
    .cin(test_cin),
    .y(test_y),
    .cout(test_cout)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_fulladder);
    
    test_a = 0; test_b = 0; test_cin = 0; #10;
    test_a = 0; test_b = 0; test_cin = 1; #10;
    test_a = 0; test_b = 1; test_cin = 0; #10;
    test_a = 0; test_b = 1; test_cin = 1; #10;
    test_a = 1; test_b = 0; test_cin = 0; #10;
    test_a = 1; test_b = 0; test_cin = 1; #10;
    test_a = 1; test_b = 1; test_cin = 0; #10;
    test_a = 1; test_b = 1; test_cin = 1; #10;
    
    $finish;
    
  end
  
endmodule



EDA Playground file link - https://www.edaplayground.com/x/Nr_P
