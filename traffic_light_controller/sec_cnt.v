module sec_cnt (clk, rst_n, sec_en);

input clk, rst_n;
reg [26:0] clk_cnt;
output reg sec_en;

localparam SEC_START = 26'd17108865; // sec_cnt it will end at 2^26, allow us to use 27th bit as end signal
    
always @(posedge clk) begin
	if (~rst_n | (clk_cnt[26])) clk_cnt <= SEC_START;
	else clk_cnt <= clk_cnt + 1;
end

always @(posedge clk) begin
	if (~rst_n) sec_en <= 1'b0;
	else sec_en <= clk_cnt[26];
end
endmodule