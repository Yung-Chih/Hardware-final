`define init_h 160

module Soldier( clk, rst, valid, pos_h, dir, left_bound, right_bound );
input clk, rst, valid;
input dir;
input [9:0] left_bound,right_bound;
output [9:0] pos_h;

parameter INIT = 2'b00;
parameter MOVE = 2'b01;
parameter STOP = 2'b10;
parameter ATK  = 2'b11;

reg [1:0] state, n_state;
reg [9:0] pos_h, nxt_h;

wire cnt_start, cnt_flag;
assign cnt_start = ( state == STOP ? 1'b1 : 1'b0 );

Counter cnt( .clk(clk), .start(cnt_start), .max(3'b111), .flag(cnt_flag) );

always@( posedge clk )begin
    if( rst | !valid ) begin
        state <= INIT;
        pos_h <= ( dir == 1 ) ? left_bound : right_bound;
    end else begin
        state <= n_state;
        pos_h <= nxt_h;
    end
end

always@(*) begin
    case( state )
    MOVE: begin
        if( dir == 1 ) begin
            n_state = ( pos_h + 1 < right_bound ) ? MOVE : STOP;
            nxt_h = ( pos_h + 1 < right_bound ) ? pos_h+1 : right_bound;
        end else begin
            n_state = ( pos_h - 1 > left_bound ) ? MOVE : STOP;
            nxt_h = ( pos_h - 1 > left_bound ) ? pos_h-1 : left_bound;
        end
    end
    STOP: begin
        nxt_h = pos_h;
        n_state = ( cnt_flag == 1 ? ATK : STOP );
    end
    ATK: begin
        nxt_h = pos_h;
        n_state = ( cnt_flag == 1 ? STOP : ATK );
    end
    default: begin
        nxt_h = ( dir == 1 ) ? left_bound : right_bound;;
        n_state = MOVE;
    end
    endcase
end

endmodule