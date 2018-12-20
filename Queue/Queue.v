`define MAXSIZE 16
module Queue( clk, rst, push, pop, size, valid );
input clk, rst, push, pop;
output reg [4:0]size;
output reg [15:0] valid;

reg [3:0] front, nfront;
reg [4:0] nsize;
wire [15:0] btw;
wire [3:0] tail, max, min;

always@( posedge clk )begin
    if( rst == 1 ) begin
        size <= 4'd0;
        front <= 4'd0;
    end else begin
        size <= nsize;
        front <= nfront;
    end
end

always@(*) begin
    if( push == 1 && size < `MAXSIZE ) begin
        nsize = size+1;
        nfront = front;
    end else if( pop == 1 && size > 0) begin
        nsize = size-1;
        nfront = front+1;
    end else begin
        nsize = size;
        nfront = front;
    end
end

assign tail = ( front + size < `MAXSIZE ) ? front + size : front + size - `MAXSIZE;
assign max = ( front > tail ) ? front : tail;
assign min = ( front > tail ) ? tail : front;

assign btw[0] = ( min <= 0 && 0 < max ) ? 1'b1 : 1'b0;
assign btw[1] = ( min <= 1 && 1 < max ) ? 1'b1 : 1'b0;
assign btw[2] = ( min <= 2 && 2 < max ) ? 1'b1 : 1'b0;
assign btw[3] = ( min <= 3 && 3 < max ) ? 1'b1 : 1'b0;
assign btw[4] = ( min <= 4 && 4 < max ) ? 1'b1 : 1'b0;
assign btw[5] = ( min <= 5 && 5 < max ) ? 1'b1 : 1'b0;
assign btw[6] = ( min <= 6 && 6 < max ) ? 1'b1 : 1'b0;
assign btw[7] = ( min <= 7 && 7 < max ) ? 1'b1 : 1'b0;
assign btw[8] = ( min <= 8 && 8 < max ) ? 1'b1 : 1'b0;
assign btw[9] = ( min <= 9 && 9 < max ) ? 1'b1 : 1'b0;
assign btw[10] = ( min <= 10 && 10 < max ) ? 1'b1 : 1'b0;
assign btw[11] = ( min <= 11 && 11 < max ) ? 1'b1 : 1'b0;
assign btw[12] = ( min <= 12 && 12 < max ) ? 1'b1 : 1'b0;
assign btw[13] = ( min <= 13 && 13 < max ) ? 1'b1 : 1'b0;
assign btw[14] = ( min <= 14 && 14 < max ) ? 1'b1 : 1'b0;
assign btw[15] = ( min <= 15 && 15 < max ) ? 1'b1 : 1'b0;

always@(*) begin
    if( front == tail )begin
        valid = ( size == 0 ? btw : ~btw);
    end else begin
        valid = ( front < tail ? btw : ~btw);
    end
end




endmodule
