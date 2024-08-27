vlib work
vlog APB_Master.v APB_Slave.v APB_Wrapper.v APB_tb.v
vsim -voptargs=+acc work.APB_tb
add wave -position insertpoint  \
sim:/APB_tb/dut/Master/IDLE \
sim:/APB_tb/dut/Master/SETUP \
sim:/APB_tb/dut/Master/ACCESS \
sim:/APB_tb/dut/Master/SWRITE \
sim:/APB_tb/dut/Master/SADDR \
sim:/APB_tb/dut/Master/SWDATA \
sim:/APB_tb/dut/Master/SSTRB \
sim:/APB_tb/dut/Master/SPROT \
sim:/APB_tb/dut/Master/transfer \
sim:/APB_tb/dut/Master/PSEL \
sim:/APB_tb/dut/Master/PENABLE \
sim:/APB_tb/dut/Master/PWRITE \
sim:/APB_tb/dut/Master/PADDR \
sim:/APB_tb/dut/Master/PWDATA \
sim:/APB_tb/dut/Master/PSTRB \
sim:/APB_tb/dut/Master/PPROT \
sim:/APB_tb/dut/Master/PCLK \
sim:/APB_tb/dut/Master/PRESETn \
sim:/APB_tb/dut/Master/PREADY \
sim:/APB_tb/dut/Master/PSLVERR \
sim:/APB_tb/dut/Master/ns \
sim:/APB_tb/dut/Master/cs
add wave -position insertpoint  \
sim:/APB_tb/dut/Slave/PRDATA \
sim:/APB_tb/dut/Slave/Cache
run -all