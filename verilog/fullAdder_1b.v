/*
    CS/ECE 552 Spring '19
    Homework #3, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(A, B, C_in, S, C_out);
    input  A, B;
    input  C_in;
    output S;
    output C_out;

    // YOUR CODE HERE
    wire AnB, AxB, CnAxB;

    //find Sum
    xor3 sum(.in1(A), .in2(B), .in3(C_in), .out(S));

    //find Cout
    nand2 part1(.in1(A), .in2(B), .out(AnB));
    xor2 subpart2(.in1(A), .in2(B), .out(AxB));
    nand2 part2(.in1(C_in), .in2(AxB), .out(CnAxB));
    nand2 carry(.in1(AnB), .in2(CnAxB), .out(C_out));

endmodule
