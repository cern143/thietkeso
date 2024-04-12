module btn_count(
	input cnt, clk, rst,
	output reg [1:0] y
);

localparam s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;

reg [1:0] next_y;

always @(cnt, y)
// stg cua fsm
begin
	case(y)
	s0: 
		begin
		if(cnt) next_y = s1;
		next_y = s0;
		end
	s1: 
		begin
		if(cnt) next_y = s2;
		else next_y = s1;
		end
	s2: 
		begin
		if(cnt) next_y = s3;
		else next_y = s2;
		end
	s3: 
		begin
		if(cnt) next_y = s0;
		else next_y = s3;
		end
	endcase
end

always @(posedge clk or posedge rst)
//flip-flop
	begin
		if (rst) y <= s0;
		else y <= next_y;
	end
endmodule
	
	
		

