module five_tapped_block(
    input clk, 
    input rst_p, 
    input ena,
    input signed [15:0] x_in,
    input signed [31:0] y_in,
    output signed [15:0] x_out,
    output reg signed [31:0] y_out,
    input signed [7:0] coef [0:4]
);
    wire signed [15:0] x_1, x_2, x_3, x_4;
    wire signed [31:0] y_1, y_2, y_3, y_4;
    tapped_delay_block block1(
        .clk(clk), 
        .rst_p(rst_p), 
        .ena(ena), 
        .x_in(x_wire[x_in]), 
        .x_out(x_1),
        .y_in(y_wire[y_in]), 
        .y_out(y_1),
        .coef(coef[0])
    );
    tapped_delay_block block2(
        .clk(clk), 
        .rst_p(rst_p), 
        .ena(ena), 
        .x_in(x_wire[x_1]), 
        .x_out(x_2),
        .y_in(y_wire[y_1]), 
        .y_out(y_2),
        .coef(coef[1])
    );
    tapped_delay_block block3(
        .clk(clk), 
        .rst_p(rst_p), 
        .ena(ena), 
        .x_in(x_wire[x_2]), 
        .x_out(x_3),
        .y_in(y_wire[y_2]), 
        .y_out(y_3),
        .coef(coef[2]));
    tapped_delay_block block4(
        .clk(clk), 
        .rst_p(rst_p), 
        .ena(ena), 
        .x_in(x_wire[x_3]), 
        .x_out(x_4),
        .y_in(y_wire[y_3]), 
        .y_out(y_4),
        .coef(coef[3])
    );
    tapped_delay_block block5(
        .clk(clk), 
        .rst_p(rst_p), 
        .ena(ena), 
        .x_in(x_wire[x_4]), 
        .x_out(x_out),
        .y_in(y_wire[y_4]), 
        .y_out(y_out),
        .coef(coef[4])
    );

endmodule