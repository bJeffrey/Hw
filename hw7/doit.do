add wave -position insertpoint  \
sim:/tb/clock_0/clk_1sec
add wave -position insertpoint  \
sim:/tb/clock_0/clk_1ms
add wave -position insertpoint  \
sim:/tb/clock_0/changeSec
add wave -position insertpoint  \
sim:/tb/clock_0/changeMin
add wave -position insertpoint  \
sim:/tb/clock_0/changeHour
add wave -position insertpoint  \
sim:/tb/clock_0/hour
add wave -position insertpoint  \
sim:/tb/clock_0/min

#print every hour (with scaled 1 ns = 1 s clock)
configure list -strobestart {0 ns} -strobeperiod {3600 ns}
configure list -usestrobe 1

add list -notrigger -dec -width 12 -label changeSec    /tb/clock_0/changeSec
add list -notrigger -dec -width 12 -label changeMin	 /tb/clock_0/changeMin
add list -notrigger -dec -width 12 -label changeHour	 /tb/clock_0/changeHour
add list -notrigger -dec -width 12 -label min	 /tb/clock_0/min
add list -notrigger -dec -width 12 -label hour		/tb/clock_0/hour
#add list -notrigger -dec -width 12 -label dot	 /tb/clock_0/dot

#run for 1 day (with scaled 1 ns = 1 s)
run 43200

write list test.list
