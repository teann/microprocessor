module branchLogic(equalto, lt, gt, opcode, muxsel); 

input equalto, lt, gt;
input [4:0] opcode;
output muxsel;

wire BGEZtrue, BEQZtrue, BLTZtrue, BNEZtrue;

assign BGEZtrue = (opcode == 5'b01111) ? 1'b1 : 1'b0;
assign BEQZtrue = (opcode == 5'b01101) ? 1'b1 : 1'b0;
assign BLTZtrue = (opcode == 5'b01110) ? 1'b1 : 1'b0;
assign BNEZtrue = (opcode == 5'b01100) ? 1'b1 : 1'b0;

assign muxsel = (BGEZtrue & (gt | equalto)) ? 1'b1 :
		((BEQZtrue & equalto) ? 1'b1 :
		((BNEZtrue & (~equalto)) ? 1'b1 :
		((BLTZtrue & lt) ? 1'b1 :
		1'b0)));

endmodule