module highway_controller (time_out, enable_h, car, start_h, enable_c, clk, rst);
    
input car, time_out, enable_h;
output start_h;
output enable_c;

localparam red = 3'b001;
localparam yellow = 3'b010;
localparam green = 3'b100;
reg [2:0] state,nextstate;

always @(car, time_out, state)
// mô tả hàm delta, lambda
// mô tả STG của FSM
begin
    start_h = 1'b0;
    enable_c = 1'b0;
	case (state)
	green: 
        begin
            if (!(time_out&car)) begin
                nextstate = green;
            end
			else begin 
                nextstate = yellow;
                start_h = 1'b1;
            end
        end
	yellow: 
        begin
			if (!time_out) nextstate = yellow;
			else begin 
                nextstate = red;
                enable_c = 1'b1;
            end
        end
	red: 
        begin
			if (!enable_h) nextstate = red;
			else nextstate = green;		
        end
end

always @(posedge clk or negedge rst_n) // mô tả flip-flop lưu trạng thái
begin
	if (!rst_n) state <= green;
	else state <= nextstate;
end

endmodule