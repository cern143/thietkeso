module timer(clk, rst_n, start, time_out, sec_ones, sec_tens);

input start;
output time_out;
output reg [3:0] sec_ones;
output reg [3:0] sec_tens;

always @(posedge clk) begin
    if (rst_n) sec_ones <= 4'd0;
	if (sec_en) begin
		if (sec_ones == 4'd0) begin 
            if (sec_tens == 4'd0) sec_ones <= 4'd0;
            else sec_ones <= 4'd9; 
        end
		else sec_ones <= sec_ones - 1;
	end
	else sec_ones <= sec_ones;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) sec_tens <= 4'd9;
	if (sec_en && (sec_ones==4'd0)) begin
		if (sec_tens == 4'd0) begin 
            if (start) sec_tens <= 4'd1;
            else sec_tens <= 4'd9; 
		end
		else sec_ones <= sec_ones - 1;
	end
	else sec_ones <= sec_ones;
end