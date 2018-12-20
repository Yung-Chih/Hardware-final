`define MAXSIZE 16
module Queue_t( clk, rst, btn_L, btn_R, LED);
input clk, rst, btn_L, btn_R;
output [15:0] LED;
wire [4:0] size;
wire push, pop, de_L, de_R;

Debounce db_L( .pb_debounced(de_L), .pb(btn_L), .clk(clk));
Debounce db_R( .pb_debounced(de_R), .pb(btn_R), .clk(clk));
OnePulse op_L( push, de_L, clk);
OnePulse op_R( pop, de_R, clk);
Queue queue( .clk(clk), .rst(rst), .push(push), .pop(pop), .size(size), .valid(LED) );

endmodule
