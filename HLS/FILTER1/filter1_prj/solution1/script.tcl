############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project filter1_prj
set_top filter1
add_files filter1.c
add_files filter1.h
add_files -tb filter1_tb.c
open_solution "solution1" -flow_target vivado
set_part {xc7a100tcsg324-1}
create_clock -period 10 -name default
config_export -output /home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER1
#source "./filter1_prj/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design -trace_level port
export_design -rtl verilog -format ip_catalog -output /home/caccolillo/Downloads/TUTORIAL_FSK/FSK_MODEM/HLS/FILTER1
