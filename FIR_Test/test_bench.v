`timescale 1ps/1ps

module test_bench ();
    reg clk, rst_n, ena;
    reg signed [15:0] x_in;
    //wire  [15:0] x_out_1;
    wire signed  [31:0] y_out;
    // wire  [15:0] x_out_2;
    // wire  [15:0] y_out_2;
    // wire  [15:0] x_out_3;
    // wire  [15:0] y_out_3;
    reg signed [15:0] sig_in [7999:0];
    reg signed [32:0] sig_out[8061:0];
    reg [12:0] address_1;
    reg [12:0] address_2;
    initial begin
        $readmemb("sig_in.txt", sig_in);
    end
    initial begin
        clk = 0;
        address_2 = 0;
        rst_n = 1; #20;
        rst_n = 0; #50;
        rst_n = 1; #20;
        ena = 1;
        address_1 = 0;
        address_2 = 0;
    end
    always #5 clk = ~clk;
    Filter_block_1 filter1(.clk(clk), .rst_n(rst_n), .x_in(x_in), .y_out(y_out), .ena(ena));
    // Filter_block_2 filter2(.clk(clk), .rst_p(rst_p), .x_in(x_out_1), .x_out(x_out_2), .y_in(y_out_1), .y_out(y_out_2));
    // Filter_block_3 filter3(.clk(clk), .rst_p(rst_p), .x_in(x_out_2), .x_out(x_out_3), .y_in(y_out_2), .y_out(y_out_3));
    always @(posedge clk or negedge rst_n) begin
        if(address_1 == 7999) begin
            address_1 <= 0;
        end 
        else begin
            address_1 <= address_1 + 1;
        end
    end
    always @(address_1) begin
        x_in <= sig_in[address_1];
    end
    always @(posedge clk) begin
        if(address_2 == 8062) begin
            $writememb("sig_out.txt", sig_out);
            $stop;
        end
        else begin
            sig_out[address_2] = y_out;
            address_2 = address_2 + 1;
        end
        //$display("y_out = %b", y_out);
    end

endmodule



