module giaima7thanh (
    input [0:3] num,
    output reg [0:6] seg
);

    always @(num) begin
        case (num)
            0 : seg = 7'b0000001;
            1 : seg = 7'b1001111;
            2 : seg = 7'b0010010;
            3 : seg = 7'b0000110;
            4 : seg = 7'b1001100;
            5 : seg = 7'b0100100;
            6 : seg = 7'b0100000;
            7 : seg = 7'b0001111;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0000100;
            default: seg = 7'b1111111;
        endcase
    end

endmodule
