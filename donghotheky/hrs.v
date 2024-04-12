module hrs(rst_n, clk, incr, dcr, hrs_en, hrs_ones, hrs_tens, day_en);
    input rst_n, clk, hrs_en, incr, dcr;
    output reg [3:0] hrs_ones;
    output reg [1:0] hrs_tens;
	 output reg day_en;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n)
	       hrs_ones <= 4'd0;
	if (hrs_en || incr)
	begin
		if (hrs_ones == 4'd9 || ({hrs_tens,hrs_ones} == 6'b100011)) // b10 = d2; 4'b0011 = d3
			hrs_ones <= 4'd0;
		else
			hrs_ones <= hrs_ones + 1;
	end
	else if (dcr) begin
		if (hrs_ones == 4'd0) hrs_ones <= 4'd0;
		else hrs_ones <= hrs_ones - 1;
	end
	else hrs_ones <= hrs_ones;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
	       hrs_tens <= 2'd0;
			 day_en <= 1'b0;
	end
	else if (hrs_en || incr)
	begin
		if ({hrs_tens,hrs_ones} == 6'b100011) begin
			hrs_tens <= 2'd0;
			day_en <= 1'b1;
		end
		else if (hrs_ones == 3'd9) begin
			hrs_tens <= hrs_tens + 1;
			day_en <= 1'b0;
		end
	end
	else if (dcr || hrs_ones == 4'd0) begin
		if (hrs_tens == 2'd0) hrs_tens <= 2'd0;
		else hrs_tens <= hrs_tens - 1;
	end
	else hrs_tens <= hrs_tens;
end

endmodule
