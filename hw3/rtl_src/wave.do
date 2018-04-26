onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mult/reset
add wave -noupdate /mult/clk
add wave -noupdate -radix unsigned /mult/a_in
add wave -noupdate -radix unsigned /mult/b_in
add wave -noupdate -radix unsigned /mult/start
add wave -noupdate -radix unsigned /mult/product
add wave -noupdate -radix unsigned /mult/done
add wave -noupdate -radix unsigned /mult/count
add wave -noupdate /mult/cycleAlternator
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8801 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {8800 ns}
