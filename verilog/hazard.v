module hazard(muxselA, muxselB, regWriteEn, regdst_dec, regdst_hazard, instr_hazard, instr_dec, checkInstr, checkInstr1, hazard_or_no, rst, clk);
 
input rst, clk; 
input [1:0] regdst_hazard, regdst_dec;
input    regWriteEn, muxselB, muxselA;
input [15:0] checkInstr, checkInstr1;
//input idWriteEn;
input [15:0] instr_hazard, instr_dec;
wire [2:0] checkReg, checkRegInput;
output hazard_or_no;
wire hazardLayer, hazardLayer2, checker, checker2, hazardLayer3;
wire [2:0] firstReg, secondReg, thirdReg;



   assign firstReg = instr_dec[4:2];
   assign secondReg = instr_dec[7:5];
   assign thirdReg = instr_dec[10:8];
   assign checker = checkReg == instr_dec[10:8];
   assign checker2 = checkReg == instr_dec[7:5];
   
   assign checkReg = ((instr_hazard[15:11] == 5'b11000 /* LBI */) | (instr_hazard[15:11] == 5'b10010 /* SLBI */)) ? instr_hazard[10:8] : checkRegInput;

   assign checkRegInput = (regdst_hazard == 2'b00) ? instr_hazard[4:2] :
			((regdst_hazard == 2'b01) ? instr_hazard[7:5] :
		        ((regdst_hazard == 2'b10) ? instr_hazard[10:8] :
			  3'b111));

  
    
   assign hazard_or_no = (instr_hazard[15:11] == 5'b00110 & instr_dec[15:11] == 5'b10000) & instr_dec[7:5] == 3'b111 ? 1'b1 : hazardLayer3;
   assign hazardLayer3 = (instr_dec[15:11] == 5'b00001) ? 1'b0 : (muxselB & (checkInstr[15:11] == 15'b00001)) | (muxselA & (checkInstr1[15:11] == 15'b00001)) ? 1'b0 : hazardLayer2; 
   assign hazardLayer2 = regWriteEn ? ((instr_hazard[15:11] == 5'b00000 | instr_hazard[15:11] == 5'b00100 | instr_hazard[15:11] == 5'b00110) ? 1'b0 : hazardLayer) : 1'b0;
   assign hazardLayer = (instr_hazard[15:11] == 5'b00001) ? 1'b0 : ((checkReg == instr_dec[10:8])) ? 1'b1 : (checkReg == instr_dec[7:5]) ? 1'b1 : 1'b0; 


endmodule
