add list -notrigger -hex -width 12 -label 1SecondClock /clock/clk_1sec
add list -notrigger -hex -width 12 -label 1miliSecondClock /clock/clk_1ms
add list -notrigger -hex -width 12 -label 1miliSecondClock /clock/clkSync0/changeSec

force -freeze sim:/clock/clk_1sec 1 0, 0 {500 ns} -r 1000
force -freeze sim:/clock/clk_1ms 1 0, 0 {50 ns} -r 100
force reset_n 1
run
force reset_n 0
run
run
force reset_n 1
run
run
run
run
run
run
run
run
run
run
run
run
write list clock.list

#quit -f
