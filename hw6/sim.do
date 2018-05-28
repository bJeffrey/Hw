add wave sim:/getWord/*
force -freeze sim:/getWord/clk_50 1 0, 0 {50 ns} -r 100
force data_ena 1
force reset_n 1
force serial_data 1
run 100
force serial_data 0
run 100
force serial_data 1
run 100
force serial_data 0
#no we have 2 zero's in a row
run 200
force serial_data 1
run 100
force serial_data 0
run 100
force serial_data 1
run 100
force data_ena 0
run 100
#run 200
#run 200
#run 50
#run 100
#run 100
write format wave -window .main_pane.wave.interior.cs.body.pw.wf /nfs/stak/users/noej/ece574/Hw/hw6/wave.do
#quit -f
# End time: 19:46:47 on May 27,2018, Elapsed time: 0:16:05
# Errors: 0, Warnings: 1
