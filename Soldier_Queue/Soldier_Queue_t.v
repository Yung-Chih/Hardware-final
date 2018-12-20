
module Soldier_Queue_t( clk, rst, btn_L, btn_R, LED, vgaRed, vgaBlue, vgaGreen, hsync, vsync);
input clk;
input rst, btn_L, btn_R;

output [15:0] LED;
output hsync, vsync;
output [3:0] vgaRed, vgaBlue, vgaGreen;

wire clk_25M, clk_div22, push, pop, valid;
wire [11:0] pixel;
wire [9:0] h_cnt, v_cnt;
assign {vgaRed, vgaGreen, vgaBlue } = ( valid == 1 ) ? pixel : 12'h000;

Debounce_and_OnePulse left ( .clk(clk), .in(btn_L), .out(push) );
Debounce_and_OnePulse right( .clk(clk), .in(btn_R), .out(pop) );

Soldier_Queue squeue(
    .clk(clk),
    .clk_div22(clk_div22),
    .rst(rst), 
    .push(push),
    .pop(pop),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .left_bound( 10'd0 ),
    .right_bound( 10'd200 ),
    .valid(LED),
    .pixel(pixel)
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