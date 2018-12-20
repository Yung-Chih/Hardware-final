`define init_v 10'd120
module Soldier_Queue( clk, clk_div22, rst, push, pop, h_cnt, v_cnt, left_bound, right_bound, pixel, valid );
input clk, clk_div22;
input rst, push, pop;
input [9:0] left_bound,right_bound;
input [9:0] h_cnt, v_cnt;

output reg [11:0] pixel;
output [15:0] valid;

wire [4:0] size;
wire [15:0] inside;
wire [9:0] pos [0:15];

parameter [11:0] Color [0:15] ={
    12'hf00,
    12'hf80,
    12'hf08,
    12'hf88,

    12'h0f0,
    12'h8f0,
    12'h0f8,
    12'h8f8,

    12'hf88,
    12'hff8,
    12'hf8f,
    12'hffF,

    12'hff8,
    12'h8ff,
    12'h888,
    12'hfaa
};

always@(*) begin
    if( inside[00] )
        pixel = Color[00];
    else if( inside[01] )
        pixel = Color[01];
    else if( inside[02] )
        pixel = Color[02];
    else if( inside[03] )
        pixel = Color[03];
    else if( inside[04] )
        pixel = Color[04];
    else if( inside[05] )
        pixel = Color[05];
    else if( inside[06] )
        pixel = Color[06];
    else if( inside[07] )
        pixel = Color[07];
    else if( inside[08] )
        pixel = Color[08];
    else if( inside[09] )
        pixel = Color[09];
    else if( inside[10] )
        pixel = Color[10];
    else if( inside[11] )
        pixel = Color[11];
    else if( inside[12] )
        pixel = Color[12];
    else if( inside[13] )
        pixel = Color[13];
    else if( inside[14] )
        pixel = Color[14];
    else if( inside[15] )
        pixel = Color[15];
    else
        pixel = 12'h111;
end

Queue queue( .clk(clk), .rst(rst), .push(push), .pop(pop), .size(size), .valid(valid) );

Soldier cat00( .clk(clk_div22), .rst(rst), .valid(valid[00]), .pos_h(pos[00]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat01( .clk(clk_div22), .rst(rst), .valid(valid[01]), .pos_h(pos[01]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat02( .clk(clk_div22), .rst(rst), .valid(valid[02]), .pos_h(pos[02]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat03( .clk(clk_div22), .rst(rst), .valid(valid[03]), .pos_h(pos[03]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );

Soldier cat04( .clk(clk_div22), .rst(rst), .valid(valid[04]), .pos_h(pos[04]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat05( .clk(clk_div22), .rst(rst), .valid(valid[05]), .pos_h(pos[05]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat06( .clk(clk_div22), .rst(rst), .valid(valid[06]), .pos_h(pos[06]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat07( .clk(clk_div22), .rst(rst), .valid(valid[07]), .pos_h(pos[07]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );

Soldier cat08( .clk(clk_div22), .rst(rst), .valid(valid[08]), .pos_h(pos[08]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat09( .clk(clk_div22), .rst(rst), .valid(valid[09]), .pos_h(pos[09]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat10( .clk(clk_div22), .rst(rst), .valid(valid[10]), .pos_h(pos[10]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat11( .clk(clk_div22), .rst(rst), .valid(valid[11]), .pos_h(pos[11]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );

Soldier cat12( .clk(clk_div22), .rst(rst), .valid(valid[12]), .pos_h(pos[12]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat13( .clk(clk_div22), .rst(rst), .valid(valid[13]), .pos_h(pos[13]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat14( .clk(clk_div22), .rst(rst), .valid(valid[14]), .pos_h(pos[14]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat15( .clk(clk_div22), .rst(rst), .valid(valid[15]), .pos_h(pos[15]), .dir(1'b1), .left_bound(left_bound), .right_bound(right_bound) );

Circle    r00 ( .pos_h( pos[00] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[00]), .inside(inside[00] ) );
Circle    r01 ( .pos_h( pos[01] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[01]), .inside(inside[01] ) );
Rectangle r02 ( .pos_h( pos[02] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[02]), .inside(inside[02] ) );
Rectangle r03 ( .pos_h( pos[03] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[03]), .inside(inside[03] ) );

Circle    r04 ( .pos_h( pos[04] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[04]), .inside(inside[04] ) );
Rectangle r05 ( .pos_h( pos[05] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[05]), .inside(inside[05] ) );
Circle    r06 ( .pos_h( pos[06] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[06]), .inside(inside[06] ) );
Rectangle r07 ( .pos_h( pos[07] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[07]), .inside(inside[07] ) );

Circle    r08 ( .pos_h( pos[08] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[08]), .inside(inside[08] ) );
Rectangle r09 ( .pos_h( pos[09] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[09]), .inside(inside[09] ) );
Rectangle r10 ( .pos_h( pos[10] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[10]), .inside(inside[10] ) );
Circle    r11 ( .pos_h( pos[11] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[11]), .inside(inside[11] ) );

Rectangle r12 ( .pos_h( pos[12] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[12]), .inside(inside[12] ) );
Circle    r13 ( .pos_h( pos[13] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[13]), .inside(inside[13] ) );
Circle    r14 ( .pos_h( pos[14] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[14]), .inside(inside[14] ) );
Rectangle r15 ( .pos_h( pos[15] ), .pos_v(`init_v), .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid[15]), .inside(inside[15] ) );

endmodule

module Rectangle( pos_h, pos_v, h_cnt, v_cnt, valid, inside );
input [9:0] pos_h, pos_v, h_cnt, v_cnt;
input valid;
output inside;

parameter [9:0] Width = 10'd30;
parameter [9:0] Height = 10'd30;

wire inside_v, inside_h;

assign inside_h = ( (h_cnt>>1) >= pos_h && (h_cnt>>1) <= pos_h + Width ) ? 1'b1 : 1'b0;
assign inside_v = ( (v_cnt>>1) >= pos_v && (v_cnt>>1) <= pos_v + Height ) ? 1'b1 : 1'b0;
assign inside = inside_h & inside_v & valid;

endmodule

module Circle( pos_h, pos_v, h_cnt, v_cnt, valid, inside );
input [9:0] pos_h, pos_v;
input [9:0] h_cnt, v_cnt;
input valid;
output inside;

parameter [9:0] r = 10'd20;
wire [9:0]dh,dv;
wire [20:0] dh2, dv2, r2;

assign dh = ( pos_h > (h_cnt>>1) ) ? pos_h - (h_cnt>>1) : (h_cnt>>1) - pos_h;
assign dv = ( pos_v > (v_cnt>>1) ) ? pos_v - (v_cnt>>1) : (v_cnt>>1) - pos_v;

assign dh2 = dh*dh;
assign dv2 = dv*dv;
assign r2 = r*r;

assign inside = ( valid == 1 && dh2 + dv2 < r) ? 1'b1 : 1'b0;

endmodule
