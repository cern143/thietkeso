`timescale 1ns / 100ps
`default_nettype none

module fir_n(x_in, y_out, b, clk, clk, ena, rst);
parameter DELAYS = 3;  // Number of delays (must be >= 2); number of tapped_delay_block instances is one greater than the number of delays.
parameter N = 32;

input  wire  signed [N-1:0]            x_in;  // filter signal imput (as a signed integer)
output logic signed [N-1:0]            y_out; // output from the system (as a signed integer)
input  wire         [(DELAYS+1)*N-1:0] b;     // signed integer coefficients, concatenated in order from 0th delay coefficient to nth delay coefficient
input  wire                            clk;   // divided clock
input  wire                            ena;
input  wire                            rst;

// Synchronizes x_in with clk
logic signed [N-1:0] x_in_sync;
async_reg #(.N(N)) SYNCHRONIZER_X_IN(
    .clk(clk),
    .ena(ena),
    .rst(rst),
    .d(x_in),
    .q(x_in_sync)
);

wire [DELAYS * N -1:0] x_wire; // wires that connect the delay blocks (registers) to propagate x_in through the filter
wire [DELAYS * N -1:0] y_wire; // wires that connect y_out from the tapped_delay_blocks to propagate y_in through the filter
generate
    genvar i;
    for(i = 0; i <= DELAYS; i++) begin
        if (i == 0) begin
            tapped_delay_block #(.N(N)) TDB0(  // First delay block
                .b(b         [N-1 : 0]),
                .x_in(x_in_sync), // initial x_in input
                .x_out(x_wire[N-1 : 0]),
                .y_in(0), // first block does not recieve any previous y_wire input
                .y_out(y_wire[N-1 : 0]),
                .clk(clk),
                .ena(ena),
                .rst(rst)
            );
        end else if (i == DELAYS) begin
            tapped_delay_block #(.N(N)) TDBD(  // Last delay block
                .b(b         [(DELAYS+1)*N-1  :  DELAYS*N]),
                .x_in(x_wire [ DELAYS*N -1    : (DELAYS-1)*N]),
                .y_in(y_wire [ DELAYS*N -1    : (DELAYS-1)*N]),
                .y_out(y_out), //final output of the FIR filter
                .clk(clk),
                .ena(ena),
                .rst(rst)
            );
        end else begin
            tapped_delay_block #(.N(N)) TDBI(  // ith delay block
                .b(b         [(i+1)*N-1 :  i*N]),
                .x_in(x_wire [ i*N-1    : (i-1)*N]),
                .x_out(x_wire[(i+1)*N-1 :  i*N]),
                .y_in(y_wire [ i*N -1   : (i-1)*N]),
                .y_out(y_wire[(i+1)*N-1 :  i*N]),
                .clk(clk),
                .ena(ena),
                .rst(rst)
            );
        end
    end
endgenerate

task print_io();
    $display("%d,%d", x_in, y_out);
endtask

endmodule

`default_nettype wire // reengages default behaviour, needed when using 
                      // other designs that expect it.
