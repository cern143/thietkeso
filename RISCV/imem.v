module imem (addr,inst);
input [0:6] addr;
output reg [0:31] inst;
	
reg [0:7] mem_block [0:127];
	
always @(addr) begin
	inst <= mem_block[addr:addr+3];
end

endmodule