`define init_v 10'd120
`define LB 10'd0
`define RB 10'd200

module layer_4_t( clk, rst, SW, hsync, vsync, vgaRed, vgaGreen, vgaBlue );
input clk, rst;
input [3:0] SW;
output hsync, vsync;
output [3:0] vgaRed, vgaGreen, vgaBlue;

wire [9:0] pos_h[0:3];

wire clk_25MHz, clk_div22;
wire vga_valid;
wire [9:0] h_cnt, v_cnt, h_cnt2, v_cnt2;
wire [16:0] pixel_addr[0:3];
wire [16:0] final_addr;
wire [11:0] pixel, data;
wire pixel_valid;

assign h_cnt2 = h_cnt >> 1;
assign v_cnt2 = v_cnt >> 1;
assign {vgaRed, vgaGreen, vgaBlue} = ( !vga_valid ) ? 12'h000 :
                                     ( pixel_valid ) ? pixel: 12'h0A0;

layer_4 l4
(
    .clk_25MHz(clk_25MHz),
    .addr( { pixel_addr[3], pixel_addr[2], pixel_addr[1], pixel_addr[0] } ),
    .pixel_addr(final_addr),
    .pixel_valid(pixel_valid)
);

Soldier cat0( clk_div22, rst, SW[0], pos_h[0], 1'b1, 10'd50, 10'd200 );
Soldier cat1( clk_div22, rst, SW[1], pos_h[1], 1'b1, 10'd50, 10'd200 );
Soldier cat2( clk_div22, rst, SW[2], pos_h[2], 1'b1, 10'd50, 10'd200 );
Soldier cat3( clk_div22, rst, SW[3], pos_h[3], 1'b1, 10'd50, 10'd200 );

mem_gen_solider a0( pos_h[0], `init_v, 10'd40, 10'd40, h_cnt2, v_cnt2, pixel_addr[0], SW[0] );
mem_gen_solider a1( pos_h[1], `init_v, 10'd40, 10'd40, h_cnt2, v_cnt2, pixel_addr[1], SW[1] );
mem_gen_solider a2( pos_h[2], `init_v, 10'd40, 10'd40, h_cnt2, v_cnt2, pixel_addr[2], SW[2] );
mem_gen_solider a3( pos_h[3], `init_v, 10'd40, 10'd40, h_cnt2, v_cnt2, pixel_addr[3], SW[3] );



blk_mem_gen_1 Graph
(
	.clka(clk_25MHz),
	.wea(0),
	.addra(final_addr),
	.dina(data),
	.douta(pixel)
);

vga_controller vga( .clk( clk_25MHz ), .rst(rst), .hsync(hsync), .vsync(vsync), .valid(vga_valid), .h_cnt(h_cnt), .v_cnt(v_cnt) );

clock_divisor clkdiv( .clk1(clk_25MHz), .clk(clk), .clk22(clk_div22), .rst(rst) );
endmodule

