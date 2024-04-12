`timescale 1ns / 1ps

module tb_alu;
//inputs
reg[3:0] a,b;
reg[1:0] sel;
//ouputs
wire[3:0] out;
wire flag;
//set up test unit
ALU test_unit(
    a,b,
    sel,
    out,
    flag
);
//test
integer i;
initial begin
    a = 4'h0C;
    b = 4'h02;
    for (i=0; i<=3; i=i+1)
    begin
        sel = sel + 2'b01;
        #10;
    end
end
endmodule
