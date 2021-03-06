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
# vsim -novopt clock 
# Start time: 22:10:07 on Jun 05,2018
# ** Warning: (vsim-8891) All optimizations are turned off because the -novopt switch is in effect. This will cause your simulation to run very slowly. If you are using this switch to preserve visibility for Debug or PLI features please see the User's Manual section on Preserving Object Visibility with vopt.
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw7/work.clock
# Loading sv_std.std
# Loading work.clock
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw7/work.clkSync
# Loading work.clkSync
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw7/work.seconds
# Loading work.seconds
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw7/work.minutes
# Loading work.minutes
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw7/work.hours
# Loading work.hours
# Refreshing /nfs/stak/users/noej/ece574/Hw/hw7/work.displayDigits
# Loading work.displayDigits
add wave -position insertpoint sim:/clock/clkSync0/*
add wave -position insertpoint sim:/clock/seconds0/*
force -freeze sim:/clock/clkSync0/clkSec 1 0, 0 {500 ns} -r 1000
force -freeze sim:/clock/clkSync0/clkMSec 1 0, 0 {50 ns} -r 100
force resetN 1
run
# ** Warning: (vsim-8315) seconds.sv(37): No condition is true in the unique/priority if/case statement.
#    Time: 0 ns  Iteration: 0  Instance: /clock/seconds0
# ** Warning: (vsim-8315) seconds.sv(37): No condition is true in the unique/priority if/case statement.
#    Time: 0 ns  Iteration: 2  Instance: /clock/seconds0
# ** Warning: (vsim-8315) seconds.sv(37): No condition is true in the unique/priority if/case statement.
#    Time: 50 ns  Iteration: 1  Instance: /clock/seconds0
force resetN 0
run
run
force resetN 1
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
#quit -f
# End time: 22:12:46 on Jun 05,2018, Elapsed time: 0:02:39
# Errors: 0, Warnings: 4
