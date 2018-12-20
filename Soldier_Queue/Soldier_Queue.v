`define init_v 10'd120
module Soldier_Queue( clk, clk_div22, rst, push, pop, dir, left_bound, right_bound, valid, pos );
input clk, clk_div22;
input dir;
input rst, push, pop;
input [9:0] left_bound,right_bound;

output [159:0] pos;
output [15:0] valid;

wire [4:0] size;
wire [15:0] inside;

Queue queue( .clk(clk), .rst(rst), .push(push), .pop(pop), .size(size), .valid(valid) );

Soldier cat00( .clk(clk_div22), .rst(rst), .valid(valid[00]), .pos_h(pos[009:000]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat01( .clk(clk_div22), .rst(rst), .valid(valid[01]), .pos_h(pos[019:010]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat02( .clk(clk_div22), .rst(rst), .valid(valid[02]), .pos_h(pos[029:020]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat03( .clk(clk_div22), .rst(rst), .valid(valid[03]), .pos_h(pos[039:030]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );

Soldier cat04( .clk(clk_div22), .rst(rst), .valid(valid[04]), .pos_h(pos[049:040]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat05( .clk(clk_div22), .rst(rst), .valid(valid[05]), .pos_h(pos[059:050]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat06( .clk(clk_div22), .rst(rst), .valid(valid[06]), .pos_h(pos[069:060]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat07( .clk(clk_div22), .rst(rst), .valid(valid[07]), .pos_h(pos[079:070]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );

Soldier cat08( .clk(clk_div22), .rst(rst), .valid(valid[08]), .pos_h(pos[089:080]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat09( .clk(clk_div22), .rst(rst), .valid(valid[09]), .pos_h(pos[099:090]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat10( .clk(clk_div22), .rst(rst), .valid(valid[10]), .pos_h(pos[109:100]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat11( .clk(clk_div22), .rst(rst), .valid(valid[11]), .pos_h(pos[119:110]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );

Soldier cat12( .clk(clk_div22), .rst(rst), .valid(valid[12]), .pos_h(pos[129:120]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat13( .clk(clk_div22), .rst(rst), .valid(valid[13]), .pos_h(pos[139:130]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat14( .clk(clk_div22), .rst(rst), .valid(valid[14]), .pos_h(pos[149:140]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );
Soldier cat15( .clk(clk_div22), .rst(rst), .valid(valid[15]), .pos_h(pos[159:150]), .dir(dir), .left_bound(left_bound), .right_bound(right_bound) );

endmodule
/*
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
*/
