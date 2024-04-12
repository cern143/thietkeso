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
			if(sel)
		end
endmodule
