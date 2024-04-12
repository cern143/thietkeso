module min(rst_n, clk, incr, dcr, min_en, min_ones, min_tens, hour_en);
    input rst_n, clk, min_en, incr, dcr;
    output reg [3:0] min_ones;
    output reg [2:0] min_tens;
	 output reg hour_en;
	 
always @(posedge clk or negedge rst_n) begin
	if (~rst_n) min_ones <= 4'd0;
	if (min_en || incr) begin
		if (min_ones == 4'd9) min_ones <= 4'd0;
		else min_ones <= min_ones + 1;
	end
	if (dcr) begin
		if (min_ones == 4'd0) min_ones <= 4'd0;
		else min_ones <= min_ones - 1;
	end
	else min_ones <= min_ones;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		min_tens <= 3'd0;
		hour_en <= 1'b0;
	end
	if ((min_en || incr) && (min_ones == 4'd9)) begin
		if (min_tens == 3'd5) begin
			min_tens <= 3'd0;
			hour_en <= 1'b1;
		end
		else begin
			min_tens <= min_tens +1;
			hour_en <= 1'b0;
		end
	end
	if (dcr && (min_ones == 4'd0)) begin 
		if (min_tens == 3'd0) min_tens <= min_tens;
		else min_tens <= min_tens - 1;
	end
	else min_tens <= min_tens;
end
endmodule