
module mem_gen_solider( pos_h, pos_v, Width, Height, h_cnt_div2, v_cnt_div2, addr, valid );
input valid;
input [9:0] pos_h, pos_v;
input [9:0] h_cnt_div2, v_cnt_div2;
input [9:0] Width, Height;
output [16:0] addr;

wire [19:0] SIZE = Width*Height;

wire addr_h, addr_v, addr_valid;
wire [9:0] dh, dv;
wire [16:0] tmp_addr;

assign addr_h = ( h_cnt_div2 >= pos_h && h_cnt_div2 <= pos_h + Width ) ? 1'b1 : 1'b0;
assign addr_v = ( v_cnt_div2 >= pos_v && v_cnt_div2 <= pos_v + Height ) ? 1'b1 : 1'b0;

assign addr_valid = ( addr_h & addr_v );

assign dh = h_cnt_div2 - pos_h;
assign dv = v_cnt_div2 - pos_v;

assign tmp_addr = dh + dv*Width;
assign addr = ( valid == 1'b0 || addr_valid == 1'b0 ) ? 17'd0 : tmp_addr%SIZE;
 
endmodule