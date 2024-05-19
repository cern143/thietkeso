module control (func3, func7, opcode, WEn, alu_sel);

input [0:6] func7, opcode;
input [0:3] func3;
output WEn, alu_sel;

always @({func7, func3, opcode}) begin
	case ({func7, func3, opcode})
	17'b00000000000110011: begin 
		alu_sel = 0;
		WEn = 1;
	end
end

endmodule
	

 