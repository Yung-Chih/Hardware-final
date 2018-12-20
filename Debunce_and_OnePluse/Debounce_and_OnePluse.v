module Debounce_and_OnePulse( clk, in, out );
input clk, in;
output out;

wire de_in;

Debounce DB ( .clk(clk), .pb(in), .pb_debounced(de_in) );
OnePulse OP ( .clock(clk), .signal(de_in), .signal_single_pulse(out));

endmodule