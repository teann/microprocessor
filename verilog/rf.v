/*
   CS/ECE 552, Spring '19
   Homework #5, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module rf (
           // Outputs
           readData1, readData2, err,
           // Inputs
           clk, rst, readReg1Sel, readReg2Sel, writeRegSel, writeData, writeEn, enable
           );
   
   input        clk, rst;
   input [2:0]  readReg1Sel;
   input [2:0]  readReg2Sel;
   input [2:0]  writeRegSel;
   input [15:0] writeData;
   input        writeEn;
   input        enable;

   output [15:0] readData1;
   output [15:0] readData2;
   output        err;
 
   wire [15:0] d0, d1, d2, d3, d4, d5, d6, d7; 
   reg [15:0] readData1i, readData2i;
   wire [15:0] qr0, qr1, qr2, qr3, qr4, qr5, qr6, qr7;
  

   assign err = (writeEn == 1'bz) ? 1'b1 : (writeData == 16'bz ? 1'b1 : 1'b0);

   //instantiate our 8 registers
   register r0(.q(qr0), .d(d0), .clk(clk), .rst(rst), .enable(enable));
   register r1(.q(qr1), .d(d1), .clk(clk), .rst(rst), .enable(enable));
   register r2(.q(qr2), .d(d2), .clk(clk), .rst(rst), .enable(enable));
   register r3(.q(qr3), .d(d3), .clk(clk), .rst(rst), .enable(enable));
   register r4(.q(qr4), .d(d4), .clk(clk), .rst(rst), .enable(enable));
   register r5(.q(qr5), .d(d5), .clk(clk), .rst(rst), .enable(enable));
   register r6(.q(qr6), .d(d6), .clk(clk), .rst(rst), .enable(enable));
   register r7(.q(qr7), .d(d7), .clk(clk), .rst(rst), .enable(enable));

   //decides if we write to the register or recirculate old value
   assign d0 = writeEn ? (writeRegSel == 3'b000 ? writeData : qr0) : qr0;
   assign d1 = writeEn ? (writeRegSel == 3'b001 ? writeData : qr1) : qr1;
   assign d2 = writeEn ? (writeRegSel == 3'b010 ? writeData : qr2) : qr2;
   assign d3 = writeEn ? (writeRegSel == 3'b011 ? writeData : qr3) : qr3;
   assign d4 = writeEn ? (writeRegSel == 3'b100 ? writeData : qr4) : qr4;
   assign d5 = writeEn ? (writeRegSel == 3'b101 ? writeData : qr5) : qr5;
   assign d6 = writeEn ? (writeRegSel == 3'b110 ? writeData : qr6) : qr6;
   assign d7 = writeEn ? (writeRegSel == 3'b111 ? writeData : qr7) : qr7;

   //pick our read register 1
   always @* case(readReg1Sel)
	3'b000: readData1i = qr0;
        3'b001: readData1i = qr1;
	3'b010: readData1i = qr2;
	3'b011: readData1i = qr3;
	3'b100: readData1i = qr4;
	3'b101: readData1i = qr5;
	3'b110: readData1i = qr6;
	3'b111: readData1i = qr7;
	default: readData1i = readData1i;
   endcase
   assign readData1 = readData1i;

   //pick our read register 2
   always @* case(readReg2Sel)
	3'b000: readData2i = qr0;
        3'b001: readData2i = qr1;
	3'b010: readData2i = qr2;
	3'b011: readData2i = qr3;
	3'b100: readData2i = qr4;
	3'b101: readData2i = qr5;
	3'b110: readData2i = qr6;
	3'b111: readData2i = qr7;
	default: readData2i = readData2i;
   endcase
   assign readData2 = readData2i;

endmodule
