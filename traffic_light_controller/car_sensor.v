module car_sensor(car, detect, sec_en);

input detect;
output reg car;
reg [10:0] period;
reg [10:0] sampling;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) period <= 10'd0;
	if (sec_en) begin
		if (period[10]) period <= 10'd0;
		else period <= period + 1;
	end
	else period <= period;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) sampling <= 10'd0;
    if (sec_en) begin
		if (car) sampling <= sampling + 1;
		else sampling <= sampling;
	end
end

always @(posedge clk or negedge rst_n) begin
    if (period[10]) begin
        if (!(sampling[10]|sampling[9])) car <= 1'b1;
        else car <= 1'b0;
    end
end

endmodule