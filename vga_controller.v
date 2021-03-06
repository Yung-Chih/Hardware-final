module vga_controller( clk, rst, hsync, vsync, valid, h_cnt, v_cnt );

input clk, rst;
output hsync, vsync, valid;
output [9:0] h_cnt, v_cnt;

reg [9:0]pixel_cnt;
reg [9:0]line_cnt;
reg hsync_i,vsync_i;
wire hsync_default, vsync_default;
wire [9:0] HD, HF, HS, HB, HT, VD, VF, VS, VB, VT;

assign HD = 640;
assign HF = 16;
assign HS = 96;
assign HB = 48;
assign HT = 800; 
assign VD = 480;
assign VF = 10;
assign VS = 2;
assign VB = 33;
assign VT = 525;
assign hsync_default = 1'b1;
assign vsync_default = 1'b1;

always@( posedge clk )begin
	if( rst == 1 ) begin
		pixel_cnt <= 0;
	end else if( pixel_cnt < (HT-1) ) begin
		pixel_cnt <= pixel_cnt + 1;
	end else begin
		pixel_cnt <= 0;
	end
end

always@( posedge clk )begin
	if( rst == 1 ) begin
		hsync_i <= hsync_default;
	end else if( ( pixel_cnt >= (HD+HF-1) ) && ( pixel_cnt < (HD+HF+HS-1) ) )begin
		hsync_i <= ~hsync_default;
	end else begin
		hsync_i <= hsync_default;
	end
end

always@( posedge clk )begin
	if( rst == 1 ) begin
		line_cnt <= 0;
	end else if( pixel_cnt == (HT-1) ) begin
		line_cnt <= ( line_cnt < VT-1 ) ? line_cnt+1 : 0;
	end else begin
		line_cnt <= line_cnt;
	end
end

always@( posedge clk )begin
	if( rst == 1 ) begin
		vsync_i <= vsync_default;
	end else if( ( line_cnt >= (VD+VF-1) ) && ( line_cnt < (VD+VF+VS-1) ) )begin
		vsync_i <= ~vsync_default;
	end else begin
		vsync_i <= vsync_default;
	end
end




assign hsync = hsync_i;
assign vsync = vsync_i;
assign valid = ( (pixel_cnt < HD) && (line_cnt < VD) );

assign h_cnt = ( pixel_cnt < HD ) ? pixel_cnt : 0;
assign v_cnt = ( line_cnt < VD ) ? line_cnt : 0;

endmodule