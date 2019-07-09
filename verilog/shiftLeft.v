module shiftLeft (In, Cnt, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 16;
   parameter   C = 4;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   reg [N-1:0] intermediate;
   output [N-1:0]  Out;

   always @* case(Cnt)
   	4'b0000: intermediate = In;
   	4'b0001: intermediate = {In[14:0],1'b0};
  	4'b0010: intermediate = {In[13:0],2'b0};
  	4'b0011: intermediate = {In[12:0],3'b0};
  	4'b0100: intermediate = {In[11:0],4'b0};
  	4'b0101: intermediate = {In[10:0],5'b0};
  	4'b0110: intermediate = {In[9:0],6'b0};
  	4'b0111: intermediate = {In[8:0],7'b0};
  	4'b1000: intermediate = {In[7:0],8'b0};
  	4'b1001: intermediate = {In[6:0],9'b0};
  	4'b1010: intermediate = {In[5:0],10'b0};
  	4'b1011: intermediate = {In[4:0],11'b0};
   	4'b1100: intermediate = {In[3:0],12'b0};
   	4'b1101: intermediate = {In[2:0],13'b0};
  	4'b1110: intermediate = {In[1:0],14'b0};
  	4'b1111: intermediate = {In[0],15'b0};
	default: intermediate = In;
   endcase
   assign Out = intermediate;


endmodule
