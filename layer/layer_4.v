
module layer_4( clk_25MHz, addr, pixel_addr, pixel_valid );
input clk_25MHz;
input [67:0] addr;
output [16:0] pixel_addr;
output pixel_valid;

wire [3:0] have_color, data;

wire [16:0] sel01, sel23, selall;
assign sel01 = ( have_color[0] ) ? addr[16:00] : addr[33:17];
assign sel23 = ( have_color[2] ) ? addr[50:34] : addr[67:51];

assign pixel_addr = ( have_color[0]|have_color[1] ) ? sel01 : sel23;
assign pixel_valid = have_color[0] | have_color[1] | have_color[2] | have_color[3];

blk_mem_gen_0 v0
(
	.clka(clk_25MHz),
	.wea(0),
	.addra(addr[16:00]),
	.dina(data),
	.douta(have_color[0])
);
blk_mem_gen_0 v1
(
	.clka(clk_25MHz),
	.wea(0),
	.addra(addr[33:17]),
	.dina(data),
	.douta(have_color[1])
);
blk_mem_gen_0 v2
(
	.clka(clk_25MHz),
	.wea(0),
	.addra(addr[50:34]),
	.dina(data),
	.douta(have_color[2])
);
blk_mem_gen_0 v3
(
	.clka(clk_25MHz),
	.wea(0),
	.addra(addr[67:51]),
	.dina(data),
	.douta(have_color[3])
);

endmodule

