`define init_v 10'd120
`define LB 10'd0
`define RB 10'd320
module mem_gen_solider_t( clk, rst, SW, hsync, vsync, vgaRed, vgaGreen, vgaBlue );

input clk, rst;
input SW;
output hsync, vsync;
output [3:0] vgaRed, vgaGreen, vgaBlue;

wire clk_25MHz, clk_div22;
wire vga_valid;
wire [9:0] h_cnt, v_cnt, h_cnt2, v_cnt2;
wire [9:0] pos_h;
wire [16:0] pixel_addr;
wire pixel, data;

assign h_cnt2 = h_cnt >> 1;
assign v_cnt2 = v_cnt >> 1;
assign {vgaRed, vgaGreen, vgaBlue} = ( !vga_valid ) ? 12'h000 :
                                     ( pixel != 17'd0 ) ? 12'h0A0 : 12'hfff;

Soldier cat0(
    .clk(clk_div22),
    .rst(rst),
    .valid(SW),
    .pos_h( pos_h ),
    .dir(1'd1),
    .left_bound(`LB),
    .right_bound(`RB)
);

mem_gen_solider mem_gen
(
    .pos_h(pos_h),
    .pos_v(`init_v),
    .Width( 10'd40 ),
    .Height(10'd40),
    .h_cnt_div2( h_cnt2),
    .v_cnt_div2(v_cnt2),
    .addr(pixel_addr),
    .valid(SW)
);

blk_mem_gen_0 blk_mem_gen_0_inst
(
	.clka(clk_25MHz),
	.wea(0),
	.addra(pixel_addr),
	.dina(data),
	.douta(pixel)
);

vga_controller vga( .clk( clk_25MHz ), .rst(rst), .hsync(hsync), .vsync(vsync), .valid(vga_valid), .h_cnt(h_cnt), .v_cnt(v_cnt) );

clock_divisor clkdiv( .clk1(clk_25MHz), .clk(clk), .clk22(clk_div22) );

endmodule