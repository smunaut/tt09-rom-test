set layout [readnet spice $project.lvs.spice]
set schem  [readnet verilog ../src/project.v]
readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_sc_hs/spice/sky130_fd_sc_hs.spice $schem
readnet verilog ../src/control.v $schem
lvs "$layout $project" "$schem $project" $::env(PDK_ROOT)/sky130A/libs.tech/netgen/sky130A_setup.tcl lvs.report -blackbox

