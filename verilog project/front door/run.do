vlib work
vlog frontdoor.v
vlog frontdoor_tb.v
vsim tb +testcase=CONSECUTIVE_WR_RD 
add wave -r sim:/tb/dut/*
#do wave.do
run -all
