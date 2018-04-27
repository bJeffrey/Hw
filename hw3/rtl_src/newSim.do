add wave -r sim:/mult/*
force a_in 10#14
force b_in 10#9
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
#quit -f
# End time: 21:08:16 on Apr 26,2018, Elapsed time: 0:02:39
# Errors: 0, Warnings: 1
