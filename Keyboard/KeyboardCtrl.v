`define LEFT	    4'b 0000
`define RIGHT	4'b 0001
`define DOWN	    4'b 0010
`define UP		4'b 0011
`define ENTER	4'b 0100
`define PUNCH	4'b 0101
`define GARD	    4'b 0110
`define KICK    	4'b 0111
`define XXX		4'b 1111

module KeyboardCtrl( cmd, clk, rst, PS2_DATA, PS2_CLK );

input clk, rst;
inout PS2_CLK, PS2_DATA;
output reg [3:0] cmd;

parameter [8:0] KEY_CODES [0:11] = {
	{1'b0, 8'h1C }, // a
	{1'b0, 8'h1B }, // s
	{1'b0, 8'h23 }, // d
	{1'b0, 8'h1D }, // w
	
	{1'b0, 8'h1A }, // z
	{1'b0, 8'h22 }, // x
	{1'b0, 8'h21 }, // c
	
	{1'b0, 8'h6B }, // LEFT
	{1'b0, 8'h72 }, // DOWN
	{1'b0, 8'h74 }, // RIGHT
	{1'b0, 8'h75 }, // UP
	
	{1'b0, 8'h5A } // enter
};

wire [511:0] key_down;
wire [8:0] last_change;
wire been_ready;

reg [3:0] key_num;

KeyboardDecoder key_de(
	.key_down(key_down),
	.last_change(last_change),
	.key_valid(been_ready),
	.PS2_CLK(PS2_CLK),
	.PS2_DATA(PS2_DATA),
	.clk(clk),
	.rst(rst)
    );
	
always@( posedge clk, posedge rst ) begin
	if( rst ) begin
		cmd <= `XXX;
	end
	else begin
		if( been_ready && key_down[ last_change ] == 1'b 1 ) begin
			cmd <= key_num;
		end
		else begin
			cmd <= `XXX;
		end
	end
end

always@(*)begin
	case(last_change)
	KEY_CODES[00] : key_num = `LEFT;
	KEY_CODES[01] : key_num = `DOWN;
	KEY_CODES[02] : key_num = `RIGHT;
	KEY_CODES[03] : key_num = `UP;
	
	KEY_CODES[04] : key_num = `PUNCH;
	KEY_CODES[05] : key_num = `KICK;
	KEY_CODES[06] : key_num = `GARD;

	KEY_CODES[07] : key_num = `LEFT;
	KEY_CODES[08] : key_num = `DOWN;
	KEY_CODES[09] : key_num = `RIGHT;
	KEY_CODES[10] : key_num = `UP;
	
	KEY_CODES[11] : key_num = `ENTER;
	default: key_num = `XXX;
	endcase
end

endmodule