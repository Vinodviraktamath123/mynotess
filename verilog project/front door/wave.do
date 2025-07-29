onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clk_i
add wave -noupdate /tb/dut/rst_i
add wave -noupdate /tb/dut/valid_i
add wave -noupdate /tb/dut/wr_rd_i
add wave -noupdate /tb/dut/addr_i
add wave -noupdate /tb/dut/wdata_i
add wave -noupdate /tb/dut/ready_o
add wave -noupdate /tb/dut/rdata_o
add wave -noupdate /tb/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
configure wave -timelineunits ps
update
WaveRestoreZoom {1145 ps} {2145 ps}
