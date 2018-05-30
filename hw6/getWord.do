add wave sim:/getWord/*
force -freeze sim:/getWord/clk_50 1 0, 0 {50 ns} -r 100
force reset_n 1
force data_ena 1
force serial_data 1
run 100
force serial_data 0
run 100
force serial_data 1
run 100
force serial_data 0
run 100
force serial_data 0
run 100
force serial_data 1
run 100
force serial_data 0
run 100
force serial_data 1
run 100
#quit -f
