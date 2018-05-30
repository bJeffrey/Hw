add wave sim:/control2MHz/*
run 200
force -freeze sim:/control2MHz/clk_2 1 0, 0 {50 ns} -r 100
run 200
force reset_n 1
force full 0
force empty 0
run 200
force full 1
run 100
run 100
force full 0
run 100
run 100
force empty 0
run 100
force empty 1
run 100
run 100
#quit -f
# End time: 12:31:32 on May 29,2018, Elapsed time: 0:12:29
# Errors: 1, Warnings: 1
