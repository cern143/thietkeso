module Filter_block_2
#(
    parameter n = 21,
    parameter signed [0:8*n-1] coef = 
    {
    8'b11101111,
    8'b11110101,
    8'b00000001,
    8'b00010000,
    8'b00100011,
    8'b00111000,
    8'b01001101,
    8'b01100001,
    8'b01110000,
    8'b01111010,
    8'b01111110,
    8'b01111010,
    8'b01110000,
    8'b01100001,
    8'b01001101,
    8'b00111000,
    8'b00100011,
    8'b00010000,
    8'b00000001,
    8'b11110101,
    8'b11101111
    }
)

(
    input clk, 
    input rst_p, 
    input signed [15:0] x_in,
    input signed [15:0] y_in,
    output reg signed [15:0] x_out,
    output reg signed [15:0] y_out
);  
    
    reg signed [0:16*(n-1)-1] delay_x ;
    integer i, j, k;
    reg signed [15:0] sum;
    
    always @(posedge clk or posedge rst_p) begin
        if(rst_p) begin
            for(i=0; i<n-1; i=i+1) begin
                delay_x[16*i +: 16] <= 0;
            end
            sum <= 0; 
            x_out <= 0;
            y_out <= 0;
        end
        else begin
            delay_x[0:15] <= x_in;
            x_out <= delay_x[16*(n-2):16*(n-1)-1];
            for(j=1; j<n-1; j=j+1) begin
                delay_x[16*j +: 16] <= delay_x[16*(j-1) +: 16];
            end
        end
    end
    
    always @(x_in or delay_x) begin
        sum = 0;
        sum = sum + $signed({8'b0, x_in}) * $signed(coef[0:7]); // Mở rộng số nguyên 8 bit thành 32 bit trước khi cộng
        for(k=0; k<n-1; k=k+1) begin
            sum = sum + ($signed({8'b0, delay_x[16*k +: 16]}) * $signed(coef[8*(k+1) +: 8])); // Mở rộng số nguyên 8 bit thành 32 bit trước khi cộng
            // $display("x_in = %d", $signed(x_in));
            // $display("k = %d, delay_x = %d", k, $signed(delay_x[16*k +: 16]));  
            // $display("coef = %d", $signed(coef[8*k +:8]));  
            // $display("sum = %b", $signed(sum));
        end
    end
    
    always @(x_in) begin
        y_out <= sum;
    end

endmodule
