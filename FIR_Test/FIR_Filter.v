module FIR_Filter 

(
    input clk,
    input rst_p, 
    input signed [15:0] x_in,
    output signed [31:0] y_out,
    input ena,
    input signed [7:0] coef [9:0]
);
    wire signed [15:0] x_wire;
    wire signed [15:0] y_wire;
    wire signed [15:0] x_sync;
    delay_block block1 (.clk(clk), .rst_p(rst_p), .ena(ena), .x_in(x_in), .x_out(x_sync));
    five_tapped_block block2(.clk(clk), .rst_p(rst_p), .ena(ena), .x_in(x_sync), .x_out(x_wire), .y_out(y_wire), .y_in(y_in), .coef(coef[4:0]));
    five_tapped_block block3(.clk(clk), .rst_p(rst_p), .ena(ena), .x_in(x_wire), .x_out(), .y_out(y_out), .y_in(y_wire), .coef(coef[9:5]));
endmodule




