// *********************************************************
// Program: tb.sv
// Description: test bench module for the clock (generates scaled 1 sec and 1 ms clock signal)
// Author: Jeffrey Noe
// Due: 6/8/2018
// *********************************************************

module tb;

//both clock values are scaled for testing purposes
parameter SHORTCLOCK = 10; //digit display clock (1 ns period)
parameter LONGCLOCK   = 1000;//seconds clock (100 ns period)

logic clk_1ms,clk_1sec,mil_time,reset_n;

reg[7:0] segment_data;
reg[2:0] digit_select;

//cycle the digit display clock
initial begin
	clk_1ms  <= 0;
	forever #(SHORTCLOCK/2) clk_1ms = ~clk_1ms;
end

//cycle the second display clock
initial begin
	clk_1sec    <= 0;
	forever #(LONGCLOCK/2) clk_1sec = ~clk_1sec;
end

//provide reset signal
initial begin
	reset_n = 0;
	#(10 * SHORTCLOCK) @(posedge clk_1ms);
	@(negedge clk_1ms);
	reset_n =1;
end

//instantiate all wires in the clock top module
clock clock0(.*);

endmodule
