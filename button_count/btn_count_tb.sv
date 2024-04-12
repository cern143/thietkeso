`timescale 1ns/1ps
parameter CLK_PERIOD = 2;

module btn_count_tb;
// Signals
wire cnt;
reg clk;
reg rst;
wire y;

btn_generator btn (
	.clk(clk),
	.btn(cnt)
);

// Instantiate the module under test
btn_count dut (
	.cnt(cnt),
	.clk(clk),
	.rst(rst),
	.y(y)
);

// Clock generation
always #((CLK_PERIOD/2)) clk = ~clk;

// Initial stimulus
initial begin
	//Initialize input
	rst = 0;
	clk = 0;
	// Reset FSM
	#1 rst = 1;
	#20
	// End simulation
	// $finish;
	$stop;
	end
endmodule



