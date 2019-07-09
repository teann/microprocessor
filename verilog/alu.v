module alu(opcode, funct, src1, src2, lt, gt, equalto, aluout);
input [15:0] src1, src2;
input [4:0] opcode;
input [1:0] funct;

output reg equalto, lt, gt;
output reg [15:0] aluout;

reg [15:0] bsIn, adderA, adderB, bsCntRight;
wire [15:0] bsOut, adderOut;
wire [6:0] aluCntrl;
reg [3:0] bsCnt;
reg [1:0] bsOp;
reg adderCin, flag;
wire adderCout;
barrelShifter_hier barrelShifter(.In(bsIn), .Cnt(bsCnt), .Op(bsOp), .Out(bsOut));
rca_16b adder(.A(adderA), .B(adderB), .C_in(adderCin), .S(adderOut), .C_out(adderCout));

//concatinate opcode and funct into one value
assign aluCntrl = {opcode, funct};

always @* 
    casex(aluCntrl) 

    7'b00000xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = 16'b0; 
    end
    7'b00001xx: begin 
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = 16'b0; 
    end		 
    7'b01000xx: begin
		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src2;
		adderB = ~src1;
		adderCin = 1'b1;
		aluout = adderOut;
    end 
    7'b01001xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end
    7'b01010xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = src1 & ~src2;
    end
    7'b01011xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = src1 ^ src2;
    end
    7'b10100xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b00;
		bsIn = src1;
		bsCnt = src2[3:0];
		aluout = bsOut;
    end
    7'b10101xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b01;
		bsIn = src1;
		bsCnt = src2[3:0];
		aluout = bsOut;
    end
    7'b10110xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b00;
		adderA = 16'h10;
		adderB = ~{{12{1'b0}}, src2[3:0]};
		adderCin = 1'b1;
	        bsCntRight = adderOut;
		bsIn = src1;
		bsCnt = bsCntRight[3:0];
		aluout = bsOut;	
    end
    7'b10111xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsIn = src1;
		bsOp = 2'b11;
		bsCnt = src2[3:0];
		aluout = bsOut;
    end
    7'b10000xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end
    7'b10001xx:  begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end
    7'b10011xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end
    7'b11001xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = {src1[0], src1[1], src1[2], src1[3], 
			  src1[4], src1[5], src1[6], src1[7], 
			  src1[8], src1[9], src1[10], src1[11],
			  src1[12], src1[13], src1[14], src1[15]};
    end
    7'b1101100: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end
    7'b1101101: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = ~src1;
		adderB = src2;
		adderCin = 1'b1;
		aluout = adderOut;
    end
    7'b1101110: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = src1 ^ src2;
    end
    7'b1101111: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = src1 & (~src2);
    end
    7'b1101000: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b00;
		bsCnt = src2[3:0];
		bsIn = src1;
		aluout = bsOut;
    end 
    7'b1101001: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b01;
		bsCnt = src2[3:0];
		bsIn = src1;
		aluout = bsOut;
    end 
    7'b1101010: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b00;
		adderA = 16'h10;
		adderB = ~{{12{1'b0}}, src2[3:0]};
		adderCin = 1'b1;
	        bsCntRight = adderOut;
		bsIn = src1;
		bsCnt = bsCntRight[3:0];
		aluout = bsOut;	
    end 
    7'b1101011: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b11;
		bsCnt = src2[3:0];
		bsIn = src1;
		aluout = bsOut;
    end 
    7'b11100xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = (src1 == src2) ? 16'b1 : 16'b0; 
    end
    7'b11101xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = ~src2;
	 	flag = (src1[15] & src2[15]) | (~src1[15] & ~src2[15]);
		adderCin = 1'b1;
		aluout = flag ? {{15{1'b0}}, adderOut[15]} : ((src1[15] & ~src2[15]) ? 16'b1 : 16'b0);
		
    end
    7'b11110xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = ~src2;
		adderCin = 1'b0; // Shift subtraction by 1 by not adding 1 when taking 2s complement
	 	flag = (src1[15] & src2[15]) | (~src1[15] & ~src2[15]);
		aluout = flag ? {{15{1'b0}}, adderOut[15]} : ((src1[15] & ~src2[15]) ? 16'b1 : 16'b0);

    end
    7'b11111xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0; 
		aluout = adderCout ? 16'b1 : 16'b0;
    end
    7'b011xxxx: begin
		equalto = (src1 == 16'b0) ? 1'b1 : 1'b0;
		lt = src1[15];
		gt = ~src1[15];
		aluout = 16'b0;
    end


    7'b11000xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		aluout = src2;
    end
    7'b10010xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		bsOp = 2'b01;
		bsIn = src1;
		bsCnt = 4'd8;
		aluout = {bsOut[15:8], src2[7:0]};
    end

    7'b00100xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
    end 
    7'b00101xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end 
    7'b00110xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
    end
    7'b00111xx: begin
    		equalto = 1'b0;
		lt = 1'b0;
		gt = 1'b0;
		adderA = src1;
		adderB = src2;
		adderCin = 1'b0;
		aluout = adderOut;
    end
    default: begin
	   adderA = 16'b0;
           adderB = 16'b0;
    	   adderCin = 1'b0;
    	   bsCnt = 4'b0;
    	   bsOp = 2'b0;
	   bsIn = 16'b0;
    end
  endcase   


   
endmodule 
	

