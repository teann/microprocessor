module memforward(regWriteEn, regdst_hazard, instr_hazard, instr_dec, forwardAlogic, forwardBlogic, stuForward, clk, rst);


input rst, clk; 
input [1:0] regdst_hazard;
input    regWriteEn;

//input idWriteEn;
input [15:0] instr_hazard, instr_dec;
wire [2:0] checkReg, checkRegInput;
output [1:0] forwardAlogic, forwardBlogic;
wire forwardAlogic1, forwardAlogic2, forwardAlogic3, checker, checker2, forwardBlogic1, forwardBlogic2, forwardBlogic3 , forwardBlogic4, doubleLoads;
wire [2:0] firstReg, secondReg, thirdReg;
wire stuForward2, stuForward3, forwardBlogic5;
output stuForward;


   assign firstReg = instr_dec[4:2];
   assign secondReg = instr_dec[7:5];
   assign thirdReg = instr_dec[10:8];
   assign checker = checkReg == instr_dec[10:8];
   assign checker2 = checkReg == instr_dec[7:5];
   assign wtflag = (instr_hazard[15:11] == 5'b00000 | instr_hazard[15:13] == 5'b00100 | instr_hazard[15:11] == 5'b00110);

   assign checkReg = ((instr_hazard[15:11] == 5'b11000 /* LBI */) | (instr_hazard[15:11] == 5'b10010 /* SLBI */)) ? instr_hazard[10:8] : checkRegInput;
   assign checkRegInput = (regdst_hazard == 2'b00) ? instr_hazard[4:2] :
			((regdst_hazard == 2'b01) ? instr_hazard[7:5] :
		        ((regdst_hazard == 2'b10) ? instr_hazard[10:8] :
			  3'b111)); 
			  
  assign forwardAlogic = forwardAlogic1 ? 2'b10 : 2'b00;
  
  assign forwardAlogic1 = (instr_dec[15:11] == 5'b11000) ? 1'b0 : forwardAlogic2;
  assign forwardAlogic2 = regWriteEn ? ((instr_hazard[15:11] == 5'b00000 | instr_hazard[15:11] == 5'b00100 | instr_hazard[15:11] == 5'b00110) ? 1'b0 : forwardAlogic3) : 1'b0;
  assign forwardAlogic3 = (instr_hazard[15:11] == 5'b00001) ? 1'b0 : (checkReg == instr_dec[10:8]) ? 1'b1 : 1'b0;
  
  assign forwardBlogic = forwardBlogic5 ? 2'b10 : 2'b00;
  
  assign forwardBlogic5 = (instr_dec[15:11] == 5'b10010) ? 1'b0 : forwardBlogic1; 
  assign forwardBlogic1 = (instr_dec[15:11] == 5'b11000) ? 1'b0 : forwardBlogic2;
  assign forwardBlogic2 = (instr_dec[15:11] == 5'b11001 | doubleLoads  ? 1'b0 : ~(instr_dec[15:13] == 3'b111 | instr_dec[15:13] == 3'b110)) ? 1'b0 : forwardBlogic3;
  assign forwardBlogic3 = regWriteEn ? ((instr_hazard[15:11] == 5'b00000 | instr_hazard[15:11] == 5'b00100 | instr_hazard[15:11] == 5'b00110) ? 1'b0 : forwardBlogic4) : 1'b0;
  assign forwardBlogic4 = (instr_hazard[15:11] == 5'b00001) ? 1'b0 : (checkReg == instr_dec[7:5]) ? 1'b1 : 1'b0;
  

  assign doubleLoads = ((instr_hazard[15:11] == 5'b11000 /* LBI */) | (instr_hazard[15:11] == 5'b10010 /* SLBI */)) & ((instr_dec[15:11] == 5'b11000 /* LBI */) | (instr_dec[15:11] == 5'b10010 /* SLBI */));

  assign stuForward = (((instr_dec[15:11] == 5'b10011) | (instr_dec[15:11] == 5'b10000)) & (checkReg == secondReg) & (instr_hazard[15:11] != 5'b10000 & instr_hazard[15:11] != 5'b00001)) ? 1'b1 : stuForward2;
  //assign stuForward2 = (((instr_hazard[15:11] == 5'b11000 /* LBI */) | (instr_hazard[15:11] == 5'b10010 /* SLBI */)) & (((instr_dec[15:11] == 5'b10011) | (instr_dec[15:11] == 5'b10000)) & (checkReg == thirdReg))) ? 1'b1: 1'b0;
  assign stuForward2 = (((instr_hazard[15:11] == 5'b11000 /* LBI */) | (instr_hazard[15:11] == 5'b10010 /* SLBI */)) & ((instr_dec[15:11] == 5'b10000)) & (checkReg == secondReg)) ? 1'b1: stuForward3;
  assign stuForward3 = (((instr_hazard[15:11] == 5'b11000 /* LBI */) | (instr_hazard[15:11] == 5'b10010 /* SLBI */)) & ((instr_dec[15:11] == 5'b10011)) & (checkReg == secondReg)) ? 1'b1 : 1'b0;
endmodule
