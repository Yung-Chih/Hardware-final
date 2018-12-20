module clock_divisor(clk, clk1, clk22, rst);
input clk, rst;
output clk1;
output clk22;
reg [21:0] num;
wire [21:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = ( rst ) ? 0 : num + 1'b1;
assign clk1 = num[1];
assign clk22 = num[21];
endmodule