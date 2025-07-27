# This script sets up and compiles an HLS project.
#
# vitis_hls hls_build.tcl
# vitis_hls -p hls_proj/hls.app

open_project -reset band_pass_filter_10k
set_top filter2
add_files filter2.hpp
add_files filter2.cpp
add_files -tb filter2_tb.cpp
open_solution -reset "solution1"
set_part {xc7a100t-csg324-1}
create_clock -period 10 -name default
config_export -format ip_catalog -rtl verilog
csynth_design
export_design -rtl verilog -format ip_catalog -description "BPF_10KHz" -vendor "caccolillo" -display_name "filter2" -output "../filter2.zip"
exit
