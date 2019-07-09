
module shiftRightL (In, Cnt, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 16;
   parameter   C = 4;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   reg [N-1:0] intermediate;
   output [N-1:0]  Out;

   always @* case(Cnt)
   	4'b0000: intermediate = In;
   	4'b0001: intermediate = {1'b0,In[15:1]};
  	4'b0010: intermediate = {2'b0,In[15:2]};
  	4'b0011: intermediate = {3'b0,In[15:3]};
  	4'b0100: intermediate = {4'b0,In[15:4]};
  	4'b0101: intermediate = {5'b0,In[15:5]};
  	4'b0110: intermediate = {6'b0,In[15:6]};
  	4'b0111: intermediate = {7'b0,In[15:7]};
  	4'b1000: intermediate = {8'b0,In[15:8]};
  	4'b1001: intermediate = {9'b0,In[15:9]};
  	4'b1010: intermediate = {10'b0,In[15:10]};
  	4'b1011: intermediate = {11'b0,In[15:11]};
   	4'b1100: intermediate = {12'b0,In[15:12]};
   	4'b1101: intermediate = {13'b0,In[15:13]};
  	4'b1110: intermediate = {14'b0,In[15:14]};
  	4'b1111: intermediate = {15'b0,In[15]};
	default: intermediate = In;
   endcase
   assign Out = intermediate;


endmodule