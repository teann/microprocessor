/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   wire [15:0] instr, readData, read, PC, PCBeforeHalt, ImmSExt5b, ImmSExt8b, ImmZExt5b, ImmSExt11b, ImmZExt8b, PCplus2, src2, aluout, immediate, ALUorMEMdata, jumpALUA;
   wire [15:0] jumpALUout, jumpALUmuxOut, branchOrNo, writeRegData, PCOut;
   wire [2:0] SESel;
   wire [1:0] RegDst;
   wire memwr, instrDump, memDump, cherr, memEnable, ALUSrc2, PCSrc, PCImm, MemToReg, MemDump, Jump, lt, gt, equalto, muxsel;
   wire dummyCout1, dummyCout2, writeEn, halt;  
   wire [15:0] readData1, readData2;
   wire [2:0]  writeRegSel;
   wire idexRegWrite, idexMemwr, idexMemEnable, idexALUSrc2, idexPCImm, idexMemToReg, idexJump, idexPCSrc;
   wire [15:0] idexPCPlus2, idexInstr, idexReadData1, idexReadData2;
   wire [2:0] idexSESel;
   wire [1:0] idexRegDst;
   wire [15:0] idexImmSExt5b, idexImmZExt5b, idexImmSExt8b, idexImmZExt8b, idexImmSExt11b;
   wire hazard_or_no1, hazard_or_no2, hazard_or_no3;
   wire [15:0] ifidInstr, ifidPCplus2, PCpostMux1, PCpostMux2, PCpostMux2Layer;
   wire [15:0] layer1, layer2, layer3;
   wire exmemRegWrite, exmemMemToReg, exmemPCSrc;
   wire [1:0] exmemRegDst;
   wire [15:0] exmemReadData2, exmemAluout, exmemPCPlus2, exmemInstr;
   wire exmemMemwr, exmemMemEnable;
   wire memwbRegWrite, memwbMemToReg, memwbPCSrc, hazard_flag1, hazard_flag2, hazard_or_no2_input, ifidInstMemStall;
   wire [1:0] memwbRegDst;
   wire [15:0] memwbInstr, memwbPCPlus2, memwbReadData, memwbAluout;
   wire [15:0] idexInstrInput, ifidInstrInput, ifidPCPlus2Input;
   wire exmemALUSrc2, exmemPCImm, exmemJump;
   wire [2:0] exmemSESel, memwbSESel;
   wire memwbMemwr, memwbMemEnable, memwbALUSrc2, memwbPCImm, memwbJump, feauxhalt, ifidFeauxhalt, idexFeauxhalt, exmemFeauxhalt, memwbFeauxhalt, finalFeauxhalt;
   wire [15:0] memwbReadData2;
   wire idexFeauxhaltOutput, ifidFeauxhaltInput, isHazard, PCImmFlushStall, JumpFlushStall;
   wire [15:0] feauxhaltLayer1, feauxhaltLayer2;
   wire [15:0] ifidInstrInputFlush, idexInstrInputFlush, ifidInstrLayer1;
   
   wire ifidFeauxhaltInputFlush, idexFeauxhaltInputFlush, exmemMuxsel, memwbMuxsel, dataMemErr, instMemErr, instMemCacheHit, instMemRd, instMemWrite, instMemStall, instMemDone, PCSrcFlushStall;
   wire [15:0] PCPlusImmOut, ifidPCPlus2InputFlushBeforeStall, jumpALUoutStall, PCBeforeHaltRegOut;
   wire dataMemRead, dataMemWrite, dataMemStall, dataMemCacheHit, dataMemDone, instMemStall1, dataMemStall1, stuForward, stuForwardReg, stuForwardmem, stuForwardmemReg;
   wire [1:0] forwardA, forwardB, forwardAreg, forwardBreg, forwardAmem, forwardBmem, forwardAmemreg, forwardBmemreg;
      //
   // IF/ID
   // 
   wire [15:0] ifidPCPlus2InputFlush, PCBeforeStall, PCOutReg, src1Input, src2Input; 

   //assign instMemStall = ~instMemDone;
  // assign dataMemStall = (exmemInstr[15:11] == 5'b10000 | exmemInstr[15:11] == 5'b10001 | exmemInstr[15:11] == 5'b10011) & ~dataMemCacheHit ? 1'b1 : dataMemStall1;
  /* assign err = instMemErr | dataMemErr;
   assign instMemStall = 1'b0;
   assign dataMemStall = 1'b0;
   assign dataMemDone = 1'b1;
   assign instMemDone = 1'b1;*/

   rca_16b jumpAdder(.A(jumpALUA), .B(idexPCPlus2), .C_in(1'b0), .S(PCPlusImmOut), .C_out(dummyCout2));

 
   register ifidInstrR(.q(ifidInstr), .d(ifidInstrInputFlush), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register ifidPCR(.q(ifidPCplus2), .d(ifidPCPlus2InputFlush), .clk(clk), .rst(rst), .enable(dataMemStall));
   register pcdff(.q(PCOut), .d(PCpostMux2), .clk(clk), .rst(rst), .enable(dataMemStall));
   register jumpALUoutStallR(.q(jumpALUoutStall), .d(jumpALUout), .clk(clk), .rst(rst), .enable(dataMemStall));
   register PCBeforeHaltRegOutR(.q(PCBeforeHaltRegOut), .d(PCBeforeHalt), .clk(clk), .rst(rst), .enable(dataMemStall));
   
   dff_stall ifidInstMemStallR(.q(ifidInstMemStall), .d(instMemStall), .clk(clk), .rst(rst), .enable(dataMemStall));


   assign ifidFeauxhaltInput = isHazard ? 1'b0 : finalFeauxhalt;

   dff_stall ifidFeauxhaltR(.q(ifidFeauxhalt), .d(ifidFeauxhaltInputFlush), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   
   assign ifidPCPlus2InputFlush = (instMemStall & ~muxsel) ? PCOut : ifidPCPlus2InputFlushBeforeStall;
   assign ifidPCPlus2InputFlushBeforeStall = ((idexInstr[15:11] == 5'b00111 /*jalr*/) | (idexInstr[15:11] == 5'b00101)  /*jr*/) ? PCOut : ifidPCPlus2Input; //jr and jalr checks
   assign ifidPCPlus2Input = (Jump | PCImm) ? ifidPCplus2 : ((isHazard) ? ifidPCplus2: PCplus2);
   rca_16b PCplus2adder(.A(PCOut), .B(16'h2), .C_in(1'b0), .S(PCplus2), .C_out(dummyCout1));  //increment PC
//J/JR AND JAL/JALR FLUSHES //added exmemjump // deleted i
  wire [15:0] ifidInstrInputFlushLayer, ifidInstrInputBranchFlush, ifidInstrInputFlushBeforeStall;

   assign ifidInstrInputFlush = (instMemStall & ~muxsel) ? ifidInstr : ifidInstrInputFlushBeforeStall;
   assign ifidInstrInputFlushBeforeStall = ((idexPCImm == PCImm)) ? ifidInstrInputFlushLayer : 16'h0800;
   assign ifidInstrInputFlushLayer = ((idexPCImm | idexJump)) ? 16'h0800 : ((PCImm | Jump) & (ImmSExt11b != 16'b0)) ? 16'h0800 : ifidInstrInputBranchFlush; 
   assign ifidInstrInputBranchFlush = muxsel ? 16'h0800 : ifidInstrInput; 

   assign ifidFeauxhaltInputFlush = ((PCImm | Jump)) ? 1'b0 : ifidFeauxhaltInput;

  
   assign ifidInstrInput = (finalFeauxhalt & ~isHazard) ? 16'h0800 : feauxhaltLayer1;
   assign feauxhaltLayer1 = (finalFeauxhalt & isHazard) ? ifidInstr : feauxhaltLayer2;
   assign feauxhaltLayer2 = (~finalFeauxhalt & isHazard) ? ifidInstr : instr;


  // memory2c_align instructMem(.data_out(instr), .data_in(read), .addr(PCOut), .enable(1'b1), .wr(1'b0), .createdump(instrDump), .clk(clk), .rst(rst), .err(instMemErr));
  // stallmem instructMemStall(.DataOut(instr), .Done(instMemDone), .Stall(instMemStall), .CacheHit(instMemCacheHit), .err(instMemErr), .Addr(PCOut), .DataIn(read), .Rd(1'b1), .Wr(1'b0), .createdump(instrDump), .clk(clk), .rst(rst));
   mem_system #(0) instructionCache(
                  // Outputs
                  .DataOut(instr),
                  .Done(instMemDone),
                  .Stall(instMemStall),    
                  .CacheHit(instMemCacheHit),    
                  .err(instMemErr),    
                  // Inputs
                  .Addr(PCOut),
                  .DataIn(read),    
                  .Rd(1'b1),    
                  .Wr(1'b0),   
                  .createdump(instrDump),   
                  .clk(clk),   
                  .rst(rst)  
                  );    
  //added exmem and memwb control signal checks
   

   assign PCBeforeHalt = ifidInstMemStall ? PCBeforeHaltRegOut : ((idexJump | idexPCImm | muxsel) ? (ifidInstMemStall ? jumpALUoutStall : jumpALUout) : ifidPCPlus2Input); // Only considers j and jal instructions, not jalr and jr //CHANGED IT TO PCIMM ON A WHIM
   assign finalFeauxhalt = instMemStall | ((PCImm | Jump) | (idexPCImm | idexJump) | (muxsel) | (instr[15:11] != 5'b0)) ? 1'b0 : ((instr[15:11] == 5'b0 & ~rst & instMemDone)  ? 1'b1 : 1'b0); 
   assign halt = (memwbFeauxhalt | err) ? 1'b1 : 1'b0;
   assign PCpostMux1 = idexPCSrc | (forwardA != 2'b0 & PCSrc) ? PC : PCplus2; 
   assign PCpostMux2 = (instMemStall)?  PCOut : (isHazard & ~(idexJump | idexPCImm)) ? ifidPCplus2 : PCpostMux1;

   assign PCBeforeStall = (finalFeauxhalt)  ? PCOut : PCBeforeHalt; //changed pc to pcou 
   assign PC = instMemStall ? ifidPCplus2 : PCBeforeStall;
    //
   // ID/EX 
   //

  wire [1:0] RegDstStall;
  control_hier control(/*AUTOARG*/
                     // Outputs
                     .err(cherr), //NOT IMPLEMENTED YET
                     .RegDst(RegDst),
                     .SESel(SESel),
                     .RegWrite(writeEn),
                     .DMemWrite(memwr),
                     .DMemEn(memEnable),
                     .ALUSrc2(ALUSrc2),
                     .PCSrc(PCSrc),
                     .PCImm(PCImm),
                     .MemToReg(MemToReg),
                     .DMemDump(memDump),
                     .Jump(Jump),
                     // Inputs
                     .OpCode(idexInstrInput[15:11]),
                     .Funct(idexInstrInput[1:0])
                     );
//FLUSH ALL CONTROL SIGNALS IN DECODE STAGE
   wire writeEnFlush, MemToRegFlush, PCSrcFlush, memwrFlush, memEnableFlush, ALUSrc2Flush, PCImmFlush, JumpFlush;
   assign writeEnFlush = (muxsel | instMemStall) ? 1'b0 : writeEn;
   assign MemToRegFlush = (muxsel) ? 1'b0 : MemToReg;
   assign PCSrcFlush = (muxsel) ? 1'b0 : PCSrc;
   assign memwrFlush = (muxsel) ? 1'b0 : memwr;
   assign memEnableFlush = (muxsel) ? 1'b0 : memEnable;
   assign ALUSrc2Flush = (muxsel) ? 1'b0 : ALUSrc2; 
   assign PCImmFlush = (muxsel) ? 1'b0 : PCImm;
   assign JumpFlush = (muxsel | instMemStall) ? 1'b0 : Jump;

   assign PCSrcFlushStall = (instMemStall) ? idexPCSrc : PCSrcFlush;
   assign PCImmFlushStall = (instMemStall) ? idexPCImm : PCImmFlush;
   assign JumpFlushStall = (instMemStall) ? idexJump : JumpFlush;
   
   
   
  // assign RegDstStall = (instMemStall) ? idexRegDst : RegDst;


   dff_stall idexRegWriteR(.q(idexRegWrite), .d(writeEnFlush), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register2b idexRegDstR(.q(idexRegDst), .d(RegDst), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER
   dff_stall idexMemToRegR(.q(idexMemToReg), .d(MemToRegFlush), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall idexPCSrcR(.q(idexPCSrc), .d(PCSrcFlushStall), .clk(clk), .rst(rst), .enable(dataMemStall)); 

   //MEM SIGNALS
   dff_stall idexMemwrR(.q(idexMemwr), .d(memwrFlush), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall idexMemEnableR(.q(idexMemEnable), .d(memEnableFlush), .clk(clk), .rst(rst), .enable(dataMemStall)); 


   //EX SIGNALS
   dff_stall idexALUSrc2R(.q(idexALUSrc2), .d(ALUSrc2Flush), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register3b idexSESelR(.q(idexSESel), .d(SESel), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 3 BIT REGISTER
   dff_stall idexPCImmR(.q(idexPCImm), .d(PCImmFlushStall), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall idexJumpR(.q(idexJump), .d(JumpFlushStall), .clk(clk), .rst(rst), .enable(dataMemStall));

   assign idexInstrInput = isHazard | instMemStall ? 16'h0800 : ifidInstr;

   assign idexInstrInputFlush = (muxsel) ? 16'h0800 : idexInstrInput; //idexImmSExt11b = 16'b0
   
   assign idexFeauxhaltInputFlush = ((idexJump | idexPCImm) | muxsel) ? 1'b0 : ifidFeauxhalt;
   //sign extensions  
   //check if we are loading a bgez instruction
   assign ImmSExt5b = ifidInstr[4] ? {{11{1'b1}},ifidInstr[4:0]} : {{11{1'b0}},ifidInstr[4:0]};
   assign ImmZExt5b = {{11{1'b0}},ifidInstr[4:0]};
   assign ImmSExt8b = ifidInstr[7] ? {{8{1'b1}},ifidInstr[7:0]} : {{8{1'b0}},ifidInstr[7:0]};
   assign ImmZExt8b = {{8{1'b0}},ifidInstr[7:0]};
   assign ImmSExt11b = ifidInstr[10] ? {{5{1'b1}},ifidInstr[10:0]} : {{5{1'b0}},ifidInstr[10:0]};


//FEAUXHALT

   dff_stall idexFeauxhaltR(.q(idexFeauxhalt), .d(idexFeauxhaltInputFlush), .clk(clk), .rst(rst), .enable(dataMemStall));
 
   //PCPLUS2 and the INSTRUCTION
   register idexPCPlus2R(.q(idexPCPlus2), .d(ifidPCplus2), .clk(clk), .rst(rst), .enable(dataMemStall));
   register idexInstrR(.q(idexInstr), .d(idexInstrInputFlush), .clk(clk), .rst(rst), .enable(dataMemStall));
   //5 DIFFERENT SIGN EXTENSIONS   
   register idexImmSExt5bR(.q(idexImmSExt5b), .d(ImmSExt5b), .clk(clk), .rst(rst), .enable(dataMemStall));
   register idexImmZExt5bR(.q(idexImmZExt5b), .d(ImmZExt5b), .clk(clk), .rst(rst), .enable(dataMemStall));
   register idexImmSExt8bR(.q(idexImmSExt8b), .d(ImmSExt8b), .clk(clk), .rst(rst), .enable(dataMemStall));
   register idexImmZExt8bR(.q(idexImmZExt8b), .d(ImmZExt8b), .clk(clk), .rst(rst), .enable(dataMemStall));
   register idexImmSExt11bR(.q(idexImmSExt11b), .d(ImmSExt11b), .clk(clk), .rst(rst), .enable(dataMemStall));
 
  
   assign src2 = idexALUSrc2 ? idexReadData2 : immediate; 

 // CONTROL
   wire readAndWrite;
   wire [15:0] readData1Input, idexReadData2Out;

   rf_hier regFile(
                // Outputs
                .readData1(readData1Input), .readData2(readData2), 
                // Inputs
                .readReg1Sel( idexInstrInput[10:8]), .readReg2Sel(idexInstrInput[7:5]),.writeRegSel(writeRegSel), .writeData(writeRegData), .writeEn(memwbRegWrite), .enable(dataMemStall)
                ); 
   
    
   
   register idexReadData1R(.q(idexReadData1), .d(readData1), .clk(clk), .rst(rst), .enable(dataMemStall));
   register idexReadData2R(.q(idexReadData2Out), .d(readData2), .clk(clk), .rst(rst), .enable(dataMemStall));

   assign readAndWrite = ((idexInstrInput[10:8] == writeRegSel) & ~(idexInstrInput[10:8] == 3'b0) & (memwbInstr[15:13] != 3'b011) & (memwbInstr[15:11] != 5'b10000) & (memwbInstr[15:11] != 5'b00101) & (memwbInstr[15:11] != 5'b00100)) ? 1'b1: 1'b0;
   assign readData1 = readAndWrite ? memwbPCPlus2 : readData1Input;
 
        // SESel LOGIC
   wire muxselOut, muxselAssign, muxselFlop;
   assign immediate = (idexSESel == 3'b000) ? idexImmZExt5b : layer1;
   assign layer1 = (idexSESel == 3'b001) ? idexImmZExt8b : layer2;
   assign layer2 = (idexSESel == 3'b010) ? idexImmSExt5b : layer3;
   assign layer3 = (idexSESel == 3'b100) ? idexImmSExt8b : idexImmSExt11b;	
   
   alu alu(.opcode(idexInstr[15:11]), .funct(idexInstr[1:0]), .src1(src1Input), .src2(src2Input), .lt(lt), .gt(gt), .equalto(equalto), .aluout(aluout));


   assign src1Input = (forwardAreg == 2'b10) ? exmemAluout : ((forwardAmemreg == 2'b10) ? ALUorMEMdata : idexReadData1);
   assign src2Input = (forwardBreg == 2'b10 & idexALUSrc2) ? exmemAluout : ((forwardBmemreg == 2'b10) ? ALUorMEMdata : src2); 
  // assign src1Input = (forwardAreg == 2'b10) ? exmemAluout : idexReadData1;
  // assign src2Input = (forwardBreg == 2'b10 & idexALUSrc2) ? exmemAluout : src2;
  // assign src1Input = (forwardAmemreg == 2'b10) ? ALUorMEMdata : idexReadData1;
  // assign src2Input = (forwardBmemreg == 2'b10 & exmemALUSrc2) ? ALUorMEMdata : src2; 

  branchLogic bL(.equalto(equalto), .lt(lt), .gt(gt), .opcode(idexInstr[15:11]), .muxsel(muxselOut));
   
   dff_stall muxselR(.q(muxselFlop), .d(muxselAssign), .clk(clk), .rst(rst), .enable(dataMemStall));
   
   assign muxsel = muxselFlop | muxselOut;
   assign muxselAssign = ((muxselOut & instMemStall) | (instMemStall & muxselFlop));
   
   assign jumpALUA = idexPCImm ? idexImmSExt11b : branchOrNo;
   assign jumpALUout = (idexJump) ? aluout : PCPlusImmOut;
   assign branchOrNo = muxsel ? idexImmSExt8b : 16'b0;

 
    assign idexReadData2 = stuForwardReg ? exmemAluout : ((stuForwardmemReg) ? ALUorMEMdata : idexReadData2Out);
   //assign idexReadData2 = stuForwardmemReg ? exmemAluout : idexReadData2Out;   
// EX/MEM
   //
   


   // WB SIGNALS

   
   dff_stall exmemRegWriteR(.q(exmemRegWrite), .d(idexRegWrite), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register2b exmemRegDstR(.q(exmemRegDst), .d(idexRegDst), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER
   dff_stall exmemMemToRegR(.q(exmemMemToReg), .d(idexMemToReg), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall exmemPCSrcR(.q(exmemPCSrc), .d(idexPCSrc), .clk(clk), .rst(rst), .enable(dataMemStall)); 

   // MEM SIGNALS

   dff_stall exmemMemwrR(.q(exmemMemwr), .d(idexMemwr), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall exmemMemEnableR(.q(exmemMemEnable), .d(idexMemEnable), .clk(clk), .rst(rst), .enable(dataMemStall)); 

   //EX SIGNALS
   dff_stall exmemALUSrc2R(.q(exmemALUSrc2), .d(idexALUSrc2), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register3b exmemSESelR(.q(exmemSESel), .d(idexSESel), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 3 BIT REGISTER
   dff_stall exmemPCImmR(.q(exmemPCImm), .d(idexPCImm), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall exmemJumpR(.q(exmemJump), .d(idexJump), .clk(clk), .rst(rst), .enable(dataMemStall));


   register exmemReadData2R(.q(exmemReadData2), .d(idexReadData2), .clk(clk), .rst(rst), .enable(dataMemStall));
   register exmemAluoutR(.q(exmemAluout), .d(aluout), .clk(clk), .rst(rst), .enable(dataMemStall));
   register exmemInstrR(.q(exmemInstr), .d(idexInstr), .clk(clk), .rst(rst), .enable(dataMemStall));
   register exmemPCPlus2R(.q(exmemPCPlus2), .d(idexPCPlus2), .clk(clk), .rst(rst), .enable(dataMemStall));

//FEAUXHALT
   
   dff_stall exmemFeauxhaltR(.q(exmemFeauxhalt), .d(idexFeauxhalt), .clk(clk), .rst(rst), .enable(dataMemStall));
   
   
   assign dataMemRead = ~exmemMemwr & exmemMemEnable;
   assign dataMemWrite = exmemMemwr & exmemMemEnable;
// memory2c_align dataMem(.data_out(readData), .data_in(exmemReadData2), .addr(exmemAluout), .enable(exmemMemEnable), .wr(exmemMemwr), .createdump(memDump), .clk(clk), .rst(rst), .err(dataMemErr));
 // stallmem dataMemoryStalling(.DataOut(readData), .Done(dataMemDone), .Stall(dataMemStall), .CacheHit(dataMemCacheHit), .err(dataMemErr), .Addr(exmemAluout), .DataIn(exmemReadData2), .Rd(dataMemRead), .Wr(dataMemWrite), .createdump(memDump), .clk(clk), .rst(rst));
  mem_system #(1) dataMemoryCache(
                  // Outputs
                  .DataOut(readData),
                  .Done(dataMemDone),
                  .Stall(dataMemStall),    
                  .CacheHit(dataMemCacheHit),    
                  .err(dataMemErr),    
                  // Inputs
                  .Addr(exmemAluout),
                  .DataIn(exmemReadData2),    
                  .Rd(dataMemRead),    
                  .Wr(dataMemWrite),   
                  .createdump(memDump),   
                  .clk(clk),   
                  .rst(rst)  
                  );
   
  
   
   wire ldStall;
//hazard detectors
   hazard hazard_memwb(.muxselA(muxsel), .muxselB(exmemMuxsel), .regWriteEn(memwbRegWrite), .regdst_dec(RegDst),  .regdst_hazard(memwbRegDst), .instr_hazard(memwbInstr), .instr_dec(ifidInstr), .checkInstr(idexInstrInputFlush), .checkInstr1(ifidInstrInputFlush), .hazard_or_no(hazard_or_no1), .rst(rst), .clk(clk));
   //hazard hazard_exmem(.muxselA(1'b0), .muxselB(muxsel), .regWriteEn(exmemRegWrite), .regdst_dec(RegDst), .regdst_hazard(exmemRegDst), .instr_hazard(exmemInstr), .instr_dec(ifidInstr), .checkInstr(idexInstrInputFlush), .checkInstr1(ifidInstrInputFlush), .hazard_or_no(hazard_or_no2), .rst(rst), .clk(clk));
//  hazard hazard_idex(.muxselA(1'b0), .muxselB(exmemMuxsel), .regWriteEn(idexRegWrite), .regdst_dec(RegDst),  .regdst_hazard(idexRegDst), .instr_hazard(idexInstr), .instr_dec(ifidInstr), .checkInstr(idexInstrInputFlush), .checkInstr1(ifidInstrInputFlush), .hazard_or_no(hazard_or_no3), .rst(rst), .clk(clk)); 
   register2b forwardAR(.q(forwardAreg), .d(forwardA), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER
   register2b forwardBR(.q(forwardBreg), .d(forwardB), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER
   register2b forwardAmemR(.q(forwardAmemreg), .d(forwardAmem), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER
   register2b forwardBmemR(.q(forwardBmemreg), .d(forwardBmem), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER

   dff_stall stuForwardR(.q(stuForwardReg), .d(stuForward), .clk(clk), .rst(rst), .enable(dataMemStall));
   dff_stall stuForwardmemR(.q(stuForwardmemReg), .d(stuForwardmem), .clk(clk), .rst(rst), .enable(dataMemStall));

   exforward exforwardR(.muxselB(exmemMuxsel), .regWriteEn(idexRegWrite), .regdst_hazard(idexRegDst), .instr_hazard(idexInstr), .instr_dec(ifidInstr), .checkInstr(idexInstrInputFlush), .forwardAlogic(forwardA), .forwardBlogic(forwardB), .stuForward(stuForward), .ldStall(ldStall), .clk(clk), .rst(rst));
  

   memforward memforwardR(.regWriteEn(exmemRegWrite), .regdst_hazard(exmemRegDst), .instr_hazard(exmemInstr), .instr_dec(ifidInstr), .forwardAlogic(forwardAmem), .forwardBlogic(forwardBmem), .stuForward(stuForwardmem), .clk(clk), .rst(rst));


 //  assign isHazard = (hazard_or_no1 | hazard_or_no2 | hazard_or_no3 | hazard_flag1) ? 1'b1 : 1'b0;
   assign isHazard = (hazard_or_no1 | ldStall) ? 1'b1 : 1'b0;
 //  assign isHazard = 1'b0;
//   assign hazard_or_no2_input = hazard_or_no2 ? 1'b1 : (hazard_flag2 ? 1'b1: 1'b0);
   
 //  dff_stall hazardflop1(.q(hazard_flag1), .d(hazard_or_no2_input), .clk(clk), .rst(rst), .enable(dataMemStall));
 //  dff_stall hazardflop2(.q(hazard_flag2), .d(hazard_or_no3), .clk(clk), .rst(rst), .enable(dataMemStall));
//  dff_stall hazardflop1(.q(hazard_flag1), .d(hazard_or_no2), .clk(clk), .rst(rst), .enable(dataMemStall));
   //MEM/WB
   //WB SIGNALS
   
   dff_stall memwbRegWriteR(.q(memwbRegWrite), .d(exmemRegWrite), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register2b memwbRegDstR(.q(memwbRegDst), .d(exmemRegDst), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 2 BIT REGISTER
   dff_stall memwbMemToRegR(.q(memwbMemToReg), .d(exmemMemToReg), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall memwbPCSrcR(.q(memwbPCSrc), .d(exmemPCSrc), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register memwbReadDataR(.q(memwbReadData), .d(readData), .clk(clk), .rst(rst), .enable(dataMemStall));
   register memwbAluoutR(.q(memwbAluout), .d(exmemAluout), .clk(clk), .rst(rst), .enable(dataMemStall));
   register memwbInstrR(.q(memwbInstr), .d(exmemInstr), .clk(clk), .rst(rst), .enable(dataMemStall));
   register memwbPCPlus2R(.q(memwbPCPlus2), .d(exmemPCPlus2), .clk(clk), .rst(rst), .enable(dataMemStall));
   register memwbReadData2R(.q(memwbReadData2), .d(exmemReadData2), .clk(clk), .rst(rst), .enable(dataMemStall));

 // MEM SIGNALS

   dff_stall memwbMemwrR(.q(memwbMemwr), .d(exmemMemwr), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall memwbMemEnableR(.q(memwbMemEnable), .d(exmemMemEnable), .clk(clk), .rst(rst), .enable(dataMemStall)); 

   //EX SIGNAL
   dff_stall memwbALUSrc2R(.q(memwbALUSrc2), .d(exmemALUSrc2), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   register3b memwbSESelR(.q(memwbSESel), .d(exmemSESel), .clk(clk), .rst(rst), .enable(dataMemStall)); //ISSUE, THIS NEEDS TO BE A 3 BIT REGISTER
   dff_stall memwbPCImmR(.q(memwbPCImm), .d(exmemPCImm), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall memwbJumpR(.q(memwbJump), .d(exmemJump), .clk(clk), .rst(rst), .enable(dataMemStall));



   dff_stall exmemMuxselR(.q(exmemMuxsel), .d(muxsel), .clk(clk), .rst(rst), .enable(dataMemStall)); 
   dff_stall memwbMuxselR(.q(memwbMuxsel), .d(exmemMuxsel), .clk(clk), .rst(rst), .enable(dataMemStall));
//FEAUXHALT
  
   dff_stall memwbFeauxhaltR(.q(memwbFeauxhalt), .d(exmemFeauxhalt), .clk(clk), .rst(rst), .enable(dataMemStall));
//FEAUXHALT
   dff_stall finalFeauxhaltR(.q(feauxhalt), .d(finalFeauxhalt), .clk(clk), .rst(rst), .enable(dataMemStall));
 
   assign ALUorMEMdata = memwbMemToReg ? memwbReadData : memwbAluout;
   assign writeRegData = (memwbRegDst == 2'b11) ? memwbPCPlus2 : ALUorMEMdata;
   assign writeRegSel = (memwbRegDst == 2'b00) ? memwbInstr[4:2] :
			((memwbRegDst == 2'b01) ? memwbInstr[7:5] :
		        ((memwbRegDst == 2'b10) ? memwbInstr[10:8] :
			  3'b111));



endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
