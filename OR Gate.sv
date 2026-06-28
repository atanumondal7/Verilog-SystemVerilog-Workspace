design.sv:

module or_gate (
    input wire a,
    input wire b,
    output wire y
);
    assign y = a | b;
endmodule



testbench.sv:

module tb;
    reg a, b;
    wire y;

    // Connect to our gate
    or_gate uut (.a(a), .b(b), .y(y));

    initial begin
        // Required for EDA Playground to show waves
        $dumpfile("dump.vcd");
        $dumpvars(0);

        // Test cases
        a = 0; b = 0; #10; // Wait 10 time units
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $finish; // End simulation
    end
endmodule



EDA Playground file link - https://www.edaplayground.com/x/Cyfa
