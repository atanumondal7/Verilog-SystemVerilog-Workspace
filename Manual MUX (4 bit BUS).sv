design.sv:

`timescale 1ns/1ps

module mux4bitmanual (
  input wire [3:0] i0,
  input wire [3:0] i1,
  input wire [3:0] i2,
  input wire [3:0] i3,
  input wire [1:0] sel,
  output wire [3:0] y
);
  
  wire [3:0] w_top_to_final;
  wire [3:0] w_bot_to_final;
  
  mux2to1_4bits sub_mux_top (
    .a(i0),
    .b(i1),
    .sel(sel[0]),
    .y(w_top_to_final)
  );
  
  mux2to1_4bits sub_mux_bottom (
    .a(i2),
    .b(i3),
    .sel(sel[0]),
    .y(w_bot_to_final)
  );
  
  mux2to1_4bits sub_mux_final (
    .a(w_top_to_final),
    .b(w_bot_to_final),
    .sel(sel[1]),
    .y(y)
  );
  
endmodule

module mux2to1_4bits (
  input wire [3:0] a,
  input wire [3:0] b,
  input wire sel,
  output wire [3:0] y
);
  
  mux2to1 sub_zero (
    .a(a[0]),
    .b(b[0]),
    .sel(sel),
    .y(y[0])
  );
  
  mux2to1 sub_one (
    .a(a[1]),
    .b(b[1]),
    .sel(sel),
    .y(y[1])
  );
  
  mux2to1 sub_two (
    .a(a[2]),
    .b(b[2]),
    .sel(sel),
    .y(y[2])
  );
  
  mux2to1 sub_three (
    .a(a[3]),
    .b(b[3]),
    .sel(sel),
    .y(y[3])
  );
  
endmodule

module mux2to1 (
  input wire a,
  input wire b,
  input wire sel,
  output wire y
);
  
  wire sel_bar;
  wire and0_out;
  wire and1_out;
  
  not u_not0(sel_bar, sel);
  
  and u_and0(and0_out, a, sel_bar);
  
  and u_and1(and1_out, b, sel);
  
  or u_or0(y, and0_out, and1_out);
 
endmodule



testbench.sv:

`timescale 1ns/1ps

module tb_mux4bitmanual;
  
  reg [3:0] test_i0;
  reg [3:0] test_i1;
  reg [3:0] test_i2;
  reg [3:0] test_i3;
  reg [1:0] test_sel;
  wire [3:0] test_y;
  
  mux4bitmanual uut (
    .i0(test_i0),
    .i1(test_i1),
    .i2(test_i2),
    .i3(test_i3),
    .sel(test_sel),
    .y(test_y)
  );
  
  initial begin
  
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_mux4bitmanual);
    
    test_i0 = 4'b1011; test_i1 = 4'b0100; 
    test_i2 = 4'b1110; test_i3 = 4'b0001;
    test_sel = 2'b00; #10;

    test_i0 = 4'b0110; test_i1 = 4'b1001; 
    test_i2 = 4'b0011; test_i3 = 4'b1100;
    test_sel = 2'b00; #10;

    test_i0 = 4'b1101; test_i1 = 4'b0010; 
    test_i2 = 4'b1000; test_i3 = 4'b0111;
    test_sel = 2'b00; #10;

    test_i0 = 4'b0101; test_i1 = 4'b1010; 
    test_i2 = 4'b0001; test_i3 = 4'b1111;
    test_sel = 2'b00; #10;

    test_i0 = 4'b1001; test_i1 = 4'b0011; 
    test_i2 = 4'b1100; test_i3 = 4'b0110;
    test_sel = 2'b01; #10;

    test_i0 = 4'b0010; test_i1 = 4'b1110; 
    test_i2 = 4'b0101; test_i3 = 4'b1000;
    test_sel = 2'b01; #10;

    test_i0 = 4'b1111; test_i1 = 4'b0000; 
    test_i2 = 4'b1010; test_i3 = 4'b0100;
    test_sel = 2'b01; #10;

    test_i0 = 4'b0111; test_i1 = 4'b1101; 
    test_i2 = 4'b0010; test_i3 = 4'b1011;
    test_sel = 2'b01; #10;

    test_i0 = 4'b1100; test_i1 = 4'b0001; 
    test_i2 = 4'b1011; test_i3 = 4'b0010;
    test_sel = 2'b10; #10;

    test_i0 = 4'b0011; test_i1 = 4'b1111; 
    test_i2 = 4'b0100; test_i3 = 4'b1001;
    test_sel = 2'b10; #10;

    test_i0 = 4'b1000; test_i1 = 4'b0110; 
    test_i2 = 4'b1101; test_i3 = 4'b0000;
    test_sel = 2'b10; #10;

    test_i0 = 4'b0001; test_i1 = 4'b1010; 
    test_i2 = 4'b0111; test_i3 = 4'b1110;
    test_sel = 2'b10; #10;

    test_i0 = 4'b1110; test_i1 = 4'b0101; 
    test_i2 = 4'b1001; test_i3 = 4'b0011;
    test_sel = 2'b11; #10;

    test_i0 = 4'b0100; test_i1 = 4'b1000; 
    test_i2 = 4'b0110; test_i3 = 4'b1111;
    test_sel = 2'b11; #10;

    test_i0 = 4'b1010; test_i1 = 4'b0111; 
    test_i2 = 4'b1100; test_i3 = 4'b0001;
    test_sel = 2'b11; #10;

    test_i0 = 4'b0000; test_i1 = 4'b1011; 
    test_i2 = 4'b0010; test_i3 = 4'b1101;
    test_sel = 2'b11; #10;
    
    $finish;
    
  end
  
endmodule




EDA Playground link - https://www.edaplayground.com/x/eqMk
