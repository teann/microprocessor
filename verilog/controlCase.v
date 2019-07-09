
/*
   CS/ECE 552, Spring '19
   Homework #6, Problem #1
  
   This module determines all of the control logic for the processor.
*/
module controlCase(/*AUTOARG*/
                // Outputs
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
  
   output reg       RegWrite, DMemWrite, DMemEn, ALUSrc2, PCSrc, 
                PCImm, MemToReg, DMemDump, Jump;
   output reg [1:0] RegDst;
   output reg [2:0] SESel;

  always @* 
	//default outputs
     /*   RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;  */
    casex(OpCode) 
    5'b00000: begin
	RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b1;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b00001: begin
	RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b01000: begin
	RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b010;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b01001: begin
	RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b010;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b01010: begin
	RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b01011: begin
        RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10100: begin
        RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10101: begin
        RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10110: begin
        RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10111: begin
        RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10000: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b010;
	RegWrite = 1'b0;
	DMemWrite = 1'b1;
	DMemEn = 1'b1;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10001: begin
        RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b010;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b1;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b1;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10011: begin
        RegDst = 2'b10; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b010;
	RegWrite = 1'b1;
	DMemWrite = 1'b1;
	DMemEn = 1'b1;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11001: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b010;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11011: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b1;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11010: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b1;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11100: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b1;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11101: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b1;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11110: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b1;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11111: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b1;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b011xx: begin
        RegDst = 2'b00; 
	PCSrc = 1'b1;  //default behavior is PC = PC + 2
	SESel = 3'b100;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b11000: begin
        RegDst = 2'b10; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b100;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b10010: begin
        RegDst = 2'b10; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b100;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    5'b00100: begin
        RegDst = 2'b00; 
	PCSrc = 1'b1;  //default behavior is PC = PC + 2
	SESel = 3'b110;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b1;
	Jump = 1'b0;	
    end
    5'b00101: begin
        RegDst = 2'b00; 
	PCSrc = 1'b1;  //default behavior is PC = PC + 2
	SESel = 3'b100;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b1;
    end
    5'b00110: begin
        RegDst = 2'b11; 
	PCSrc = 1'b1;  //default behavior is PC = PC + 2
	SESel = 3'b110;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b1;
	Jump = 1'b0;
    end
    5'b00111: begin
        RegDst = 2'b11; 
	PCSrc = 1'b1;  //default behavior is PC = PC + 2
	SESel = 3'b100;
	RegWrite = 1'b1;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b1;
    end
    5'b00011: begin
        RegDst = 2'b00; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
    default: begin
	RegDst = 2'b01; 
	PCSrc = 1'b0;  //default behavior is PC = PC + 2
	SESel = 3'b000;
	RegWrite = 1'b0;
	DMemWrite = 1'b0;
	DMemEn = 1'b0;
	ALUSrc2 = 1'b0;
	MemToReg = 1'b0;
	DMemDump = 1'b0;
	PCImm = 1'b0;
	Jump = 1'b0;
    end
  endcase   

 
endmodule 