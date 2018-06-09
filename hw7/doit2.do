#monitor the 1 second clock
add wave -position insertpoint  \
sim:/tb/clock0/clk_1sec

#monitor the 1 ms clock
add wave -position insertpoint  \
sim:/tb/clock0/clk_1ms

#monitor the 1 ms clock
add wave -position insertpoint  \
sim:/tb/clock0/reset_n

#monitor the changeSec flag
add wave -position insertpoint  \
sim:/tb/clock0/changeSec

#monitor the current second
add wave -position insertpoint  \
sim:/tb/clock0/seconds0/sec

#monitor the changeMin flag
add wave -position insertpoint  \
sim:/tb/clock0/changeMin

#monitor the current minute
add wave -position insertpoint  \
sim:/tb/clock0/minutes0/min

#monitor the current minute most significant bit
add wave -position insertpoint  \
sim:/tb/clock0/minMSB

#monitor the current minute least significant bit
add wave -position insertpoint  \
sim:/tb/clock0/minLSB

#monitor the changeHour flag
add wave -position insertpoint  \
sim:/tb/clock0/changeHour

#monitor the current hour
add wave -position insertpoint  \
sim:/tb/clock0/hours0/hour

#monitor the current hour MSB
add wave -position insertpoint  \
sim:/tb/clock0/hourMSB

#monitor the current hour LSB
add wave -position insertpoint  \
sim:/tb/clock0/hourLSB

#print every half hour (with scaled 1 ns = 1 s clock)
configure list -strobestart {0 ns} -strobeperiod {60000 ns}
configure list -usestrobe 1

#add relevant values to the list
add list -notrigger -unsigned -width 12 -label hour		/tb/clock0/hour
add list -notrigger -unsigned -width 12 -label min	 /tb/clock0/minutes0/min
add list -notrigger -unsigned -width 12 -label changeSec    /tb/clock0/seconds0/sec

#military time test
force mil_time 1

#run for 1 day (with scaled 1 ns = 1 s)
run 86400000

write list test.list
