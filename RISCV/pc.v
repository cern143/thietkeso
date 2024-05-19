module pc(clk, rst_n, addr);

  input clk, rst_n;
  output reg [0:4] addr;

  always @(posedge clk, negedge rst_n)
  begin
    if(!rst_n)
      addr <= 5'b0;
    else
      addr <= addr + 5'b0;
  end

endmodule


