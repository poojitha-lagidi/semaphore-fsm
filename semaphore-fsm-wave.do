onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /semaphore_fsm_tb/clk
add wave -noupdate -radix unsigned /semaphore_fsm_tb/reset
add wave -noupdate -radix unsigned /semaphore_fsm_tb/enable
add wave -noupdate -radix unsigned /semaphore_fsm_tb/red
add wave -noupdate -radix unsigned /semaphore_fsm_tb/red_yellow
add wave -noupdate -radix unsigned /semaphore_fsm_tb/green
add wave -noupdate -radix unsigned /semaphore_fsm_tb/yellow
add wave -noupdate -radix binary /semaphore_fsm_tb/state_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {312346 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {328125 ns}
