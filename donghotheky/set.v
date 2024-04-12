module set (rst_n, clk, incr, dcr, digit);

input rst_n, clk, incr, dcr;
output reg [3:0] digit;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) digit <= 4'd0;
	else if (incr) digit <= digit + 1;
	else if (dcr && (digit != 4'd0)) digit <= digit - 1;
end
endmodule