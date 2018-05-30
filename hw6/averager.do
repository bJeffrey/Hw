# //  ModelSim SE-64 10.5 Feb 12 2016 Linux 3.10.0-693.11.1.el7.x86_64
# //
# //  Copyright 1991-2016 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  ModelSim SE-64 and its associated documentation contain trade
# //  secrets and commercial or financial information that are the property of
# //  Mentor Graphics Corporation and are privileged, confidential,
# //  and exempt from disclosure under the Freedom of Information Act,
# //  5 U.S.C. Section 552. Furthermore, this information
# //  is prohibited from disclosure under the Trade Secrets Act,
# //  18 U.S.C. Section 1905.
# //
# vsim -novopt averager 
# Start time: 16:54:17 on May 29,2018
# ** Warning: (vsim-8891) All optimizations are turned off because the -novopt switch is in effect. This will cause your simulation to run very slowly. If you are using this switch to preserve visibility for Debug or PLI features please see the User's Manual section on Preserving Object Visibility with vopt.
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw6/work.averager
# Loading sv_std.std
# Loading work.averager
add wave sim:/averager/*
force -freeze sim:/averager/rd_clk 1 0, 0 {1 ns} -r 2
force -freeze sim:/averager/wr_clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/averager/rd_clk 1 0, 0 {1 ns} -r 2
force reset_n 1
force wr 1
force data_in 2#1000
force rd 0
run 100
force wr 0
run 100
force wr 1
force data_in 2#1100
run 100
force data_in 2#1000
run 100
force data_in 2#1100
run 100
#quit -f
# End time: 17:13:39 on May 29,2018, Elapsed time: 0:19:22
# Errors: 0, Warnings: 1
