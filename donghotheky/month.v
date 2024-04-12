module month(rst_n, clk, incr, dcr, month_en, month_ones, month_tens, year_en);

    input rst_n, clk, month_en;
	 input [3:0] incr;
	 input [1:0] dcr;
    output reg [3:0] month_ones;
    output reg [1:0] month_tens;
	 output reg year_en;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n)
	       month_ones <= 4'd0;
	if (month_en || incr) begin
		if (month_ones == 4'd9 || ({month_tens,month_ones} == 6'b010010)) // b10 = d1; 4'b0010 = d2
			month_ones <= 4'd0;
		else
			month_ones <= month_ones + 1;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
	       month_tens <= 2'd0;
			 year_en <= 1'b0;
	end
	if (month_en)
	begin
		if ({month_tens,month_ones} == 6'b010010) begin
			month_tens <= 2'd0;
			year_en <= 1'b1;
		end
		if (month_ones == 4'd9) begin
			month_tens <= month_tens + 1;
			year_en <= 1'b0;
		end
		else month_tens <= month_tens;
	end
	if (dcr && (month_ones == 4'd0))
	begin 
		if (month_tens == 2'd0) month_tens <= month_tens;
		else month_tens <= month_tens - 1;
	end
	else month_tens <= month_tens;
end

endmodule