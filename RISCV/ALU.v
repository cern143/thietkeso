module alu(rs1, rs2, rd, sel);

input sel;
input [0:31] rs1, rs2;
output [0:31] rd;

always @(rs1, rs2, sel) begin
	if(!sel) rd = rs1 + rs2;
	else rd = rs1 - rs2;
end

endmodule
