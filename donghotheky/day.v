module day (rst_n, clk, incr, dcr, day_en, day_ones, day_tens, lastday_ones, lastday_tens, month_en);

    input rst_n, clk, day_en, incr, dcr;
	 input [3:0] lastday_ones;
    input [1:0] lastday_tens;
    output reg [3:0] day_ones;
    output reg [1:0] day_tens;
	 output reg month_en;

always @(posedge clk or negedge rst_n) begin
   if(~rst_n) begin
		day_ones <= 4'd1;
		month_en <= 1'b0;
   end
   if (day_en || incr) begin
	   if ((day_tens == lastday_tens) && (day_ones == lastday_ones)) begin
        day_ones <= 4'd1;
		  month_en <= 1'b1;
		endday_tens <= day_tens + 1;
		if (day_ones == 4'd9) begin
        day_ones <= 4'd0;
		  month_en <= 1'b0;
		end
		else begin
			day_ones <= day_ones + 1;
			month_en <= 1'b0;
		end
	end
	if (dcr) begin
		if (day_tens == 4'd0) begin
			if (day_ones == 4'd1) day_ones <= 4'd1;
			else day_ones <= day_ones - 1;
		end
		else begin
			if (day_ones == 4'd0)
				day_ones <= 4'd9;
			else 
				day_ones <= day_ones - 1;
		end
	end
	else begin
		day_ones <= day_ones;
		day_tens <= day_tens;
	end
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) 
		day_tens <= 4'd1;
	if (day_en || incr) begin
	   if ((day_tens == lastday_tens) && (day_ones == lastday_ones))
			day_tens <= 4'd0;
		if (day_ones == 9)
			day_tens <= day_tens + 1;
		else day_tens <= day_tens;
	if (dcr) begin
		if (day_tens == 4'd0) daytens <= daytens;
		else daytens <= daytens - 1;
	end
	else day_tens;
endmodule


