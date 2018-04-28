add wave -r sim:/mult/*
force a_in 10#14
force b_in 10#9
#add wave -position insertpoint \

add list -nodelta
configure list -strobestart {99 ns} -strobeperiod {100 ns}
configure list -usestrobe 1
add list -notrigger -dec -width 24 -label clk clk
add list -notrigger -dec -width 24 -label product product

force -freeze sim:/mult/clk 1 0, 0 {50 ns} -r 100
force reset 1
force start 0
run 200
run 50
force reset 0
run 100
run 50
force start 1
run 100
force start 0
run 500
run 8000

write list mult.list

quit -f
