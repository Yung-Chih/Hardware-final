module Counter( clk, start, max, flag );
input clk, start;
input [2:0] max;
output flag;
reg [2:0] cnt;
wire [2:0] n_cnt;

always@( posedge clk ) begin
	if( start ) begin
		cnt <= n_cnt;
	end else begin
		cnt <= 1;
	end
end

assign n_cnt = ( cnt < max ) ? cnt+1 : 1;
assign flag = ( cnt == max ) ? 1'b1 : 1'b0;
endmodule