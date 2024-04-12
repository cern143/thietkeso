module delay_block (
    input clk,
    input rst_p,
    input ena,
    input signed [15:0] x_in,
    output reg signed [15:0] x_out
);
    reg tmp_sig;
    always @(posedge clk or posedge rst_p) begin
        if(rst_p) begin
            x_out <= 0;
        end
        else begin
                x_out <= x_in;
            end 
        end  
endmodule
