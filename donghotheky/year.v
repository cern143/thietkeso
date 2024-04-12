module year(rst_n, clk, incr, dcr, year_en, year_bin, year_ones, year_tens, year_hundreds);
   input rst_n, clk, year_en;
	input [3:0] incr;
	input [3:0] dcr;
	output reg [10:0] year_bin;
   output reg [3:0] year_ones;
   output reg [3:0] year_tens;
	output reg [3:0] year_hundreds;
	
always @(posedge clk or negedge rst_n) begin
	if (~rst_n) year_ones <= 4'd0;
	if (year_en || incr)
	begin
		if (year_ones == 4'd9) year_ones <= 4'd0;
		else year_ones <= year_ones +1;
	end
	if (dcr)
	begin
		if (year_ones == 4'd0) year_ones <= 4'd0;
		else year_ones <= year_ones - 1;
	end
	else year_ones <= year_ones;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) year_tens <= 4'd0;
	if (year_en && (year_ones == 4'd9))
	begin
		if (year_tens == 4'd9) begin
			year_tens <= 4'd0;
		end
		else year_tens <= year_tens + 1;
	end
	if (dcr && (year_ones == 4'd0))
	begin 
		if (year_tens == 4'd0) year_tens <= year_tens;
		else year_tens <= year_tens - 1;
	end
	else year_tens <= year_tens;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) year_hundreds <= 4'd0;
	if (year_en && (year_ones == 4'd9 && year_tens == 4'd9))
	begin
		if (year_hundreds == 4'd9) year_hundreds <= 4'd0;
		else year_hundreds <= year_hundreds + 1;
	end
	if (dcr && (year_ones == 4'd0 && year_tens == 4'd0))
	begin 
		if (year_hundreds == 4'd0) year_hundreds <= 4'd0;
		else year_hundreds <= year_hundreds - 1;
	end
	else year_hundreds <= year_hundreds;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) year_bin <= 11'b0;
	if (year_en) begin
		if (year_bin == 11'd999) year_bin = 11'b0;
		else year_bin <= year_bin + 1;
	end
	else year_bin <= year_bin;
end

endmodule