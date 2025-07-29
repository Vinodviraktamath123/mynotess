vlib work
vlog bd.v
vlog bd_tb.v
vsim tb +testcase=WRITE_FD_READ_BD 
add wave -r sim:/tb/dut/*
run -all
