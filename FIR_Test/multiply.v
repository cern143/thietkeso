module multiply
(
    input [0:15] delay_x, coef,
    output [0:31] acc
);
    wire [0:15] mul_1, mul_2;
    wire [0:32] num;
    assign mul_1 = (delay_x[0] == 1'b1) ? (~delay_x + 1'b1) : delay_x;
    assign mul_2 = (coef[0] == 1'b1) ? (~coef + 1'b1) : coef;
    assign num = mul_1 * mul_2;
    assign acc = (delay_x[0] ^ coef[0] == 1) ? (~num + 1'b1) : num;
    // reg [32:0] add_1, add_2;
    // assign add_1 = (num_out[23] == 1'b1) ? {1'b1, num_out} : {1'b0, num_out};
    // assign add_2 = (y_in[23] == 1'b1) ? {1'b1, y_in} : {1'b0, y_in};
endmodule

module addition
(

);
endmodule