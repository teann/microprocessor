
/*
    CS/ECE 552 Spring '19
    Homework #4, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the Op() value that is passed in (2 bit number).  It uses these
    shifts to shift the value any number of bits between 0 and 15 bits.
 */
module barrelShifter (In, Cnt, Op, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 16;
   parameter   C = 4;
   parameter   O = 2;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   input [O-1:0]   Op;
   output [N-1:0]  Out;
  
   wire [15:0] rleft;
   wire [15:0] sleft;
   wire [15:0] sra;
   wire [15:0] srl;
   reg [15:0] intermediate;

   rotateLeft rotateLeft(.In(In), .Cnt(Cnt), .Out(rleft));
   shiftLeft shiftLeft(.In(In), .Cnt(Cnt), .Out(sleft));
   shiftRightL shiftRightL(.In(In), .Cnt(Cnt), .Out(srl));
   shiftRightA shiftRightA(.In(In), .Cnt(Cnt), .Out(sra));

   /* YOUR CODE HERE */

   always @* case(Op)
	2'b00: intermediate = rleft;
        2'b01: intermediate = sleft;
	2'b10: intermediate = sra;
	2'b11: intermediate = srl;
	default: intermediate = In;
   endcase

   assign Out = intermediate;
endmodule
