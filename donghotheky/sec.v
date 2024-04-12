module sec (rst_n, incr, dcr, clk, sec_en, sec_ones, sec_tens, min_en);
    input rst_n, clk, sec_en, incr, dcr;
    output reg [3:0] sec_ones;
    output reg [2:0] sec_tens;
	 output reg min_en;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) sec_ones <= 4'd0;
	if (sec_en || incr) begin
		if (sec_ones == 4'd9) sec_ones <= 4'd0;
		else sec_ones <= sec_ones + 1;
	end
	if (dcr) begin
		if (sec_ones == 4'd0) sec_ones <= 4'd0;
		else sec_ones <= sec_ones - 1;
	end
	else sec_ones <= sec_ones;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
	       sec_tens <= 3'd0;
			 min_en <= 1'b0;
	end
	if ((sec_en || incr) && (sec_ones == 4'd9)) begin
		if (sec_tens == 3'd5) begin
			sec_tens <= 3'd0;
			min_en <= 1'b1;
		end
		else begin
			sec_tens <= sec_tens + 1;
			min_en <= 1'b0;
		end
	end
	if (dcr && (sec_ones == 4'd0)) begin 
		if (sec_tens == 3'd0) sec_tens <= sec_tens;
		else sec_tens <= sec_tens - 1;
	end
	else sec_tens <= sec_tens;
end

endmodule