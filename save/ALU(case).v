module ALU(
		input [3:0] a,b,
		input [1:0] sel,
		output [3:0] out,
		output flag
);
		reg [7:0] y;
		assign out = y[3:0];
		assign flag = y[4] | y[5] | y[6] | y[7];
		always @(a,b,sel)
		begin
			casex (sel)
				2'b0?: y = a+b;
				2'b10: y = a-b;	
				default: y = a*b;
			endcase
		end
endmodule
