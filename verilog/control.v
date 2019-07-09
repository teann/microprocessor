/*
   CS/ECE 552, Spring '19
   Homework #6, Problem #1
  
   This module determines all of the control logic for the processor.
*/
module control (/*AUTOARG*/
                // Outputs
                err, 
                RegDst,
                SESel,
                RegWrite,
                DMemWrite,
                DMemEn,
                ALUSrc2,
                PCSrc,
                PCImm,
                MemToReg,
                DMemDump,
                Jump,
                // Inputs
                OpCode,
                Funct
                );

   // inputs
   input [4:0]  OpCode;
   input [1:0]  Funct;
   
   // outputs
   output       err;
   output       RegWrite, DMemWrite, DMemEn, ALUSrc2, PCSrc, 
                PCImm, MemToReg, DMemDump, Jump;
   output [1:0] RegDst;
   output [2:0] SESel;

   assign err = (|Funct === 1'bx) ? 1'b1 : (|OpCode === 1'bx ? 1'b1 : 1'b0);
   controlCase controlCase(
		.RegDst(RegDst),
                .SESel(SESel),
                .RegWrite(RegWrite),
                .DMemWrite(DMemWrite),
                .DMemEn(DMemEn),
                .ALUSrc2(ALUSrc2),
                .PCSrc(PCSrc),
                .PCImm(PCImm),
                .MemToReg(MemToReg),
                .DMemDump(DMemDump),
                .Jump(Jump),
                .OpCode(OpCode),
                .Funct(Funct)
                );
endmodule
