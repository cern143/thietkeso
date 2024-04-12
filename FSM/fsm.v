module fsm (
    input x,clk,rst_n,
    output reg y
);

localparam s0=2'b00;
localparam s1=2'b01;
localparam s10=2'b10;
localparam s101=2'b11;
reg [1:0] state, nextstate;

always @(x, state)
// mô tả hàm delta, lambda
// mô tả STG của FSM
begin
	case (state)
	s0: 
        begin
			if (x) nextstate = s1;
			else nextstate=s0;
			y = 0;
        end
	s1: 
        begin
			if (x) nextstate = s1;
			else nextstate = s10;
			y = 0;
        end
	s10: 
        begin
			if (x) nextstate = s101;
			else nextstate = s0;
			y = 0;
        end
	s101: 
        begin
			if (x) nextstate = s1;
			else nextstate = s10;
			y=1;
        end
	endcase
end
    
always @(posedge clk or negedge rst_n)
    // mô tả flip-flop lưu trạng thái
	begin
		if (!rst_n) state <= s0;
		else state <= nextstate;
	end
endmodule