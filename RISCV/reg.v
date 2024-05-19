module Reg(clk, WEn, DataD, AddrD, AddrA, AddrB, DataA, DataB);

input WEn, clk;
input [0:31] DataD;
input [0:4] AddrA, AddrB, AddrD;
output [0:31] DataA, DataB;

reg [0:31] mem_block [0:31];

assign DataA = Reg[AddrA];
assign DataB = Reg[AddrB];

always @(posedge clk) begin
	if (WEn) mem_block[AddrD] <= DataD;
end

endmodule
	