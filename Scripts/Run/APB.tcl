# First write the name for the project (APB_Master_Slave_Model) then select the path to the folder that has the design codes and the run file
create_project APB_Master_Slave_Model "D:/Personal Courses/AMBA_APB/Vivado" -part xc7a35ticpg236-1L -force

# Add source files & XDC files
add_files {APB_Master.v APB_Slave.v APB_Wrapper.v APB.xdc}

# Elaborate Design (Will open the schematic)
synth_design -rtl -top APB_Wrapper > elab.log

# Save Schematic
write_schematic -force -format pdf elaborated_schematic.pdf

# Synthesize Design
launch_runs synth_1 > synth.log

# Open GUI (Schematic)
wait_on_run synth_1
open_run synth_1

# Save Schematic
write_schematic -force -format pdf synthesized_schematic.pdf

# Generate netlist
write_verilog -force APB_Model_netlist.v

# Implementation
launch_runs impl_1 -to_step write_bitstream 

# Open GUI (Schematic & Device view)
wait_on_run impl_1
open_run impl_1