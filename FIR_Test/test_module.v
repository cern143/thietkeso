`timescale 1ps/1ps

module test_module #(parameter delay = 499) ();
    reg clk, rst_p, ena;
    reg signed [15:0] x_in;
    wire signed [15:0] x_out;
    wire signed [31:0] y_out;
    reg signed [31:0] y_in;
    reg signed [15:0] sig_in [19:0];
    reg [8:0] address;
    initial begin
        $readmemb("sig_out.txt", sig_in);
    end
    initial begin
        clk = 0;
        x_in = 0;
        y_in = 0;
        ena = 1;
        rst_p = 1;
        #1
        rst_p = 0;
    end
    always #5 clk = ~clk;
    Filter_block filter(.clk(clk), .rst_p(rst_p), .x_in(x_in), .x_out(x_out), .y_in(y_in), .y_out(y_out));
    always @(posedge clk or posedge rst_p) begin
        if(address == 9 || rst_p) begin
            address <= 0;
        end 
        else begin
            address <= address + 1;
        end
    end
    always @(address) begin
        x_in <= sig_in[address];
    end
    // always @(y_out) begin
    //     $display("y_out = %d", y_out);
    // end

endmodule



