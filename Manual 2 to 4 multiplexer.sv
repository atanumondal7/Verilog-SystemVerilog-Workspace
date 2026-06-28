design.sv:

`timescale 1ns/1ps

module mux2to1 (
    input wire a,    // Data Input 0
    input wire b,    // Data Input 1
    input wire s,    // Select Line
    output wire y    // Output
);

    // Internal wires to connect our gates together
    wire s_bar;
    wire and0_out;
    wire and1_out;

    // 1. Invert the select line: s_bar = ~s
    not u_not0 (s_bar, s);

    // 2. First AND path: and0_out = a & s_bar
    and u_and0 (and0_out, a, s_bar);

    // 3. Second AND path: and1_out = b & s
    and u_and1 (and1_out, b, s);

    // 4. Final OR stage: y = and0_out | and1_out
    or  u_or0  (y, and0_out, and1_out);

endmodule



testbench.sv:

`timescale 1ns/1ps

module tb_mux2to1;
  
  reg test_a;
  reg test_b;
  reg test_s;
  wire test_y;
  
  mux2to1 uut (
    .a(test_a),
    .b(test_b),
    .s(test_s),
    .y(test_y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_mux2to1);
    
    test_a = 1'b0; test_b = 1'b1; test_s = 1'b1; #10;
    test_a = 1'b0; test_b = 1'b1; test_s = 1'b0; #10;
    test_a = 1'b1; test_b = 1'b0; test_s = 1'b1; #10;
    test_a = 1'b1; test_b = 1'b0; test_s = 1'b0; #10;
    
    $finish;
    
  end
  
endmodule



EDA Playground file link - https://www.edaplayground.com/x/MfUz
