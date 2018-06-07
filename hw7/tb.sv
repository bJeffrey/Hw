module tb;

reg clk_1ms,clk_1sec,mil_time,reset_n;
reg[7:0] segment_data;
reg[2:0] digit_select;


parameter CYCLE_100 = 10; //100mhz clock
parameter CYCLE_1   = 1000;  // 1mhz clock use 1000 for right, use 10 for testing

initial begin
	clk_1ms  <= 0;
	forever #(CYCLE_100/2) clk_1ms = ~clk_1ms;
end


initial begin
	clk_1sec    <= 0;
	forever #(CYCLE_1/2)  clk_1sec    = ~clk_1sec;
end

initial begin
	reset_n = 0;
	#(10*CYCLE_100) @(posedge clk_1ms);
	@(negedge clk_1ms); reset_n =1;
end

clock clock_0(

.*

);

endmodule
