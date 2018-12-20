`define width 50
`define height 20
module Soldier_t( clk, rst, SW, vgaRed, vgaBlue, vgaGreen, hsync, vsync);
input clk, rst;
input SW;
output hsync, vsync;
output [3:0] vgaRed, vgaBlue, vgaGreen;

wire valid, clk_25M, clk_div22;
wire [9:0] pos_h;
wire [9:0] h_cnt, v_cnt;
wire inside;


assign {vgaRed, vgaGreen, vgaBlue} = ( valid == 1'b0 ) ? 12'h000 :
                                     ( inside & SW ) ? 12'h3ff : 12'h333;
Circle2 cir
(
    .pos_h(pos_h+10),
    .pos_v(100),
    .r(10),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .valid(SW),
    .inside(inside)
);

Soldier cat1
(
    .clk(clk_div22),
    .rst(rst),
    .valid(SW),
    .pos_h(pos_h),
    .dir(1'b1),
    .left_bound(10'd0),
    .right_bound(10'd200)
);

vga_controller vga
( 
    .clk(clk_25M),
    .rst(rst),
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
);

clock_divisor clkdiv (.clk1(clk_25M), .clk(clk), .clk22(clk_div22));

endmodule

/*
module Circle( pos_h, pos_v, r, h_cnt, v_cnt, valid, inside );
input [9:0] pos_h, pos_v, r;
input [9:0] h_cnt, v_cnt;
input valid;
output inside;

wire [9:0]dh,dv;
assign dh = ( pos_h > (h_cnt>>1) ) ? pos_h - (h_cnt>>1) : (h_cnt>>1) - pos_h;
assign dv = ( pos_v > (v_cnt>>1) ) ? pos_v - (v_cnt>>1) : (v_cnt>>1) - pos_v;

assign inside = ( valid == 1 && dh*dh + dv*dv <= r*r) ? 1'b1 : 1'b0;

endmodule
*/

module Circle2( pos_h, pos_v, r, h_cnt, v_cnt, valid, inside );
input [9:0] pos_h, pos_v, r;
input [9:0] h_cnt, v_cnt;
input valid;
output inside;

wire [9:0]dh,dv;
wire [20:0] dh2, dv2, r2;

assign dh = ( pos_h > (h_cnt>>1) ) ? pos_h - (h_cnt>>1) : (h_cnt>>1) - pos_h;
assign dv = ( pos_v > (v_cnt>>1) ) ? pos_v - (v_cnt>>1) : (v_cnt>>1) - pos_v;

assign dh2 = dh*dh;
assign dv2 = dv*dv;
assign r2 = r*r;

assign inside = ( valid == 1 && dh2 + dv2 < r) ? 1'b1 : 1'b0;

endmodule

module clock_divisor(clk1, clk, clk22);
input clk;
output clk1;
output clk22;
reg [21:0] num;
wire [21:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk22 = num[21];
endmodule