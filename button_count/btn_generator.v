module btn_generator(
    input clk,          // Clock signal
    output reg btn      // btn signal
);

reg [3:0] counter;    // Counter for button debounce

always @(posedge clk) 
begin
	if (counter < 4'd3) counter <= counter + 1;
	else
		begin
		counter = 4'd0;
		btn = ~btn;    // Toggle button signal every 65536 clock cycles
		end
end

endmodule