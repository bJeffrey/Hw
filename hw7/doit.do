add wave -position insertpoint  \
sim:/tb/clock_0/changeSec
add wave -position insertpoint  \
sim:/tb/clock_0/changeMin

#add wave -position insertpoint  \
#sim:/tb/clock_0/hr_n_h
#add wave -position insertpoint  \
#sim:/tb/clock_0/hr_n_l

#add wave -position insertpoint  \
#sim:/tb/clock_0/min_h
#add wave -position insertpoint  \
#sim:/tb/clock_0/min_l

#add wave -position insertpoint  \
#sim:/tb/clock_0/dot

#print every minute
add list -nodelta
#print every minute
configure list -strobestart {0 ns} -strobeperiod {60000 ns}
#print every hour
configure list -strobestart {0 ns} -strobeperiod {60000 ns}
configure list -usestrobe 1

add list -notrigger -dec -width 12 -label changeSec    /tb/clock_0/changeSec
add list -notrigger -dec -width 12 -label changeMin	 /tb/clock_0/changeMin
#add list -notrigger -dec -width 12 -label dot	 /tb/clock_0/dot

#add list -notrigger -dec -width 12 -label hr_n_h    /tb/clock_0/hr_n_h
#add list -notrigger -dec -width 12 -label hr_n_l    /tb/clock_0/hr_n_l

#add list -notrigger -dec -width 12 -label min_h    /tb/clock_0/min_h
#add list -notrigger -dec -width 12 -label min_l    /tb/clock_0/min_l

run 200000000
	write list test.list
