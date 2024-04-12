module led7thanh(
    input [0:3] in1, in2, in3, in4,
    output [0:6] out1, out2, out3, out4
);

    giaima7thanh led1(in1,out1);
    giaima7thanh led2(in2,out2);
    giaima7thanh led3(in3,out3);
    giaima7thanh led4(in4,out4);
    
endmodule