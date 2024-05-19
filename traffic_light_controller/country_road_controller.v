module country_road_controller (time_out, enable_c, start_c, mode, enable_h, clk, rst);
    
input time_out, enable_c;
output start_c;
output enable_h, mode;

localparam red = 3'b001;
localparam yellow = 3'b010;
localparam green = 3'b100;
reg [2:0] state,nextstate;

always @(time_out, state)
// mô tả hàm delta, lambda
// mô tả STG của FSM
begin
    start_c = 1'b0;
    enable_h = 1'b0;
	case (state)
	green: 
        begin
            if (!time_out) begin
                nextstate = green;
            end
			else begin 
                nextstate = yellow;
            end
        end
	yellow: 
        begin
			if (!time_out) nextstate = yellow;
			else begin 
                nextstate = red;
                enable_h = 1'b1;
            end
        end
	red: 
        begin
			if (!enable_c) nextstate = red;
			else begin 
                nextstate = green;
                start_c = 1'b1;
            end	
        end
end

always @(posedge clk or negedge rst_n) // mô tả flip-flop lưu trạng thái
begin
	if (!rst_n) state <= green;
	else state <= nextstate;
end

endmodule