############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project filter_envelope_detector
set_top applyIIRFilter
add_files filter_envelope_detector.c
add_files filter_envelope_detector.h
add_files -tb filter_envelope_detector_tb.c
open_solution "solution1" -flow_target vivado
set_part {xc7a100tcsg324-1}
create_clock -period 10 -name default
#source "./filter_envelope_detector/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -format ip_catalog
