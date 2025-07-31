
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# clocked_comparator_25bit, mux2to1, sinewave_generator

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
   set_property BOARD_PART digilentinc.com:arty-a7-100:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:c_shift_ram:12.0\
caccolillo:hls:filter1:1.0\
caccolillo:hls:filter2:1.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:xlconstant:1.1\
caccolillo:hls:applyIIRFilter:1.0\
xilinx.com:ip:mult_gen:12.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
clocked_comparator_25bit\
mux2to1\
sinewave_generator\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: ENVELOPE_DETECTOR_1
proc create_hier_cell_ENVELOPE_DETECTOR_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ENVELOPE_DETECTOR_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 24 -to 0 -type data B
  create_bd_pin -dir O -from 24 -to 0 -type data ap_return
  create_bd_pin -dir I -type rst ap_rst
  create_bd_pin -dir I ap_start
  create_bd_pin -dir I -type clk clk

  # Create instance: applyIIRFilter_3, and set properties
  set applyIIRFilter_3 [ create_bd_cell -type ip -vlnv caccolillo:hls:applyIIRFilter:1.0 applyIIRFilter_3 ]

  # Create instance: mult_gen_1, and set properties
  set mult_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_1 ]
  set_property -dict [list \
    CONFIG.MultType {Parallel_Multiplier} \
    CONFIG.OutputWidthHigh {31} \
    CONFIG.PortAType {Signed} \
    CONFIG.PortAWidth {25} \
    CONFIG.PortBWidth {25} \
    CONFIG.Use_Custom_Output_Width {true} \
  ] $mult_gen_1


  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {31} \
    CONFIG.DIN_TO {7} \
  ] $xlslice_2


  # Create port connections
  connect_bd_net -net ap_clk_0_1 [get_bd_pins clk] [get_bd_pins applyIIRFilter_3/ap_clk] [get_bd_pins mult_gen_1/CLK]
  connect_bd_net -net applyIIRFilter_3_ap_return [get_bd_pins ap_return] [get_bd_pins applyIIRFilter_3/ap_return]
  connect_bd_net -net c_shift_ram_0_Q [get_bd_pins ap_rst] [get_bd_pins applyIIRFilter_3/ap_rst]
  connect_bd_net -net c_shift_ram_1_Q [get_bd_pins ap_start] [get_bd_pins applyIIRFilter_3/ap_start]
  connect_bd_net -net filter1_1_ap_return [get_bd_pins B] [get_bd_pins mult_gen_1/A] [get_bd_pins mult_gen_1/B]
  connect_bd_net -net mult_gen_1_P [get_bd_pins mult_gen_1/P] [get_bd_pins xlslice_2/Din]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins applyIIRFilter_3/filter_in] [get_bd_pins xlslice_2/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ENVELOPE_DETECTOR2
proc create_hier_cell_ENVELOPE_DETECTOR2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ENVELOPE_DETECTOR2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 24 -to 0 -type data B
  create_bd_pin -dir O -from 24 -to 0 -type data ap_return
  create_bd_pin -dir I -type rst ap_rst
  create_bd_pin -dir I ap_start
  create_bd_pin -dir I -type clk clk

  # Create instance: applyIIRFilter_2, and set properties
  set applyIIRFilter_2 [ create_bd_cell -type ip -vlnv caccolillo:hls:applyIIRFilter:1.0 applyIIRFilter_2 ]

  # Create instance: mult_gen_0, and set properties
  set mult_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_0 ]
  set_property -dict [list \
    CONFIG.MultType {Parallel_Multiplier} \
    CONFIG.OutputWidthHigh {31} \
    CONFIG.PortAType {Signed} \
    CONFIG.PortAWidth {25} \
    CONFIG.PortBWidth {25} \
    CONFIG.Use_Custom_Output_Width {true} \
  ] $mult_gen_0


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {31} \
    CONFIG.DIN_TO {7} \
  ] $xlslice_1


  # Create port connections
  connect_bd_net -net ap_clk_0_1 [get_bd_pins clk] [get_bd_pins applyIIRFilter_2/ap_clk] [get_bd_pins mult_gen_0/CLK]
  connect_bd_net -net applyIIRFilter_2_ap_return [get_bd_pins ap_return] [get_bd_pins applyIIRFilter_2/ap_return]
  connect_bd_net -net c_shift_ram_0_Q [get_bd_pins ap_rst] [get_bd_pins applyIIRFilter_2/ap_rst]
  connect_bd_net -net c_shift_ram_1_Q [get_bd_pins ap_start] [get_bd_pins applyIIRFilter_2/ap_start]
  connect_bd_net -net filter2_1_ap_return [get_bd_pins B] [get_bd_pins mult_gen_0/A] [get_bd_pins mult_gen_0/B]
  connect_bd_net -net mult_gen_0_P [get_bd_pins mult_gen_0/P] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins applyIIRFilter_2/filter_in] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: MODULATOR
proc create_hier_cell_MODULATOR { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_MODULATOR() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I fsk_binary_modulating_data_in
  create_bd_pin -dir O -from 15 -to 0 sine_out_0

  # Create instance: mux2to1_0, and set properties
  set block_name mux2to1
  set block_cell_name mux2to1_0
  if { [catch {set mux2to1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux2to1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sinewave_generator_0, and set properties
  set block_name sinewave_generator
  set block_cell_name sinewave_generator_0
  if { [catch {set sinewave_generator_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sinewave_generator_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0x0c} \
    CONFIG.CONST_WIDTH {16} \
  ] $xlconstant_0


  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0x17} \
    CONFIG.CONST_WIDTH {16} \
  ] $xlconstant_1


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {7} \
    CONFIG.DIN_WIDTH {16} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net ap_clk_0_1 [get_bd_pins clk] [get_bd_pins sinewave_generator_0/clk]
  connect_bd_net -net fsk_binary_modulating_data_in_1 [get_bd_pins fsk_binary_modulating_data_in] [get_bd_pins mux2to1_0/Sel]
  connect_bd_net -net mux2to1_0_Y [get_bd_pins mux2to1_0/Y] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net sinewave_generator_0_sine_out [get_bd_pins sine_out_0] [get_bd_pins sinewave_generator_0/sine_out]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins mux2to1_0/A] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins mux2to1_0/B] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins sinewave_generator_0/frequency_setting] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: DEMODULATOR
proc create_hier_cell_DEMODULATOR { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_DEMODULATOR() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 -type data FSK_modulated_data
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir O fsk_demodulated_data_out
  create_bd_pin -dir I -from 0 -to 0 -type rst rst
  create_bd_pin -dir I -from 0 -to 0 start

  # Create instance: ENVELOPE_DETECTOR2
  create_hier_cell_ENVELOPE_DETECTOR2 $hier_obj ENVELOPE_DETECTOR2

  # Create instance: ENVELOPE_DETECTOR_1
  create_hier_cell_ENVELOPE_DETECTOR_1 $hier_obj ENVELOPE_DETECTOR_1

  # Create instance: c_shift_ram_0, and set properties
  set c_shift_ram_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_0 ]
  set_property -dict [list \
    CONFIG.Depth {1050} \
    CONFIG.ShiftRegType {Fixed_Length} \
    CONFIG.Width {1} \
  ] $c_shift_ram_0


  # Create instance: c_shift_ram_1, and set properties
  set c_shift_ram_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_1 ]
  set_property -dict [list \
    CONFIG.Depth {1070} \
    CONFIG.ShiftRegType {Fixed_Length} \
    CONFIG.Width {1} \
  ] $c_shift_ram_1


  # Create instance: c_shift_ram_2, and set properties
  set c_shift_ram_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_2 ]
  set_property -dict [list \
    CONFIG.Depth {1050} \
    CONFIG.ShiftRegType {Fixed_Length} \
    CONFIG.Width {1} \
  ] $c_shift_ram_2


  # Create instance: clocked_comparator_2_0, and set properties
  set block_name clocked_comparator_25bit
  set block_cell_name clocked_comparator_2_0
  if { [catch {set clocked_comparator_2_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $clocked_comparator_2_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: filter1_1, and set properties
  set filter1_1 [ create_bd_cell -type ip -vlnv caccolillo:hls:filter1:1.0 filter1_1 ]

  # Create instance: filter2_1, and set properties
  set filter2_1 [ create_bd_cell -type ip -vlnv caccolillo:hls:filter2:1.0 filter2_1 ]

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {0} \
  ] $xlslice_3


  # Create port connections
  connect_bd_net -net ap_clk_0_1 [get_bd_pins clk] [get_bd_pins ENVELOPE_DETECTOR2/clk] [get_bd_pins ENVELOPE_DETECTOR_1/clk] [get_bd_pins c_shift_ram_0/CLK] [get_bd_pins c_shift_ram_1/CLK] [get_bd_pins c_shift_ram_2/CLK] [get_bd_pins clocked_comparator_2_0/clk] [get_bd_pins filter1_1/ap_clk] [get_bd_pins filter2_1/ap_clk]
  connect_bd_net -net ap_rst_0_1 [get_bd_pins rst] [get_bd_pins c_shift_ram_0/D] [get_bd_pins filter1_1/ap_rst] [get_bd_pins filter2_1/ap_rst]
  connect_bd_net -net applyIIRFilter_2_ap_return [get_bd_pins ENVELOPE_DETECTOR2/ap_return] [get_bd_pins clocked_comparator_2_0/A]
  connect_bd_net -net applyIIRFilter_3_ap_return [get_bd_pins ENVELOPE_DETECTOR_1/ap_return] [get_bd_pins clocked_comparator_2_0/B]
  connect_bd_net -net c_shift_ram_0_Q [get_bd_pins ENVELOPE_DETECTOR2/ap_rst] [get_bd_pins ENVELOPE_DETECTOR_1/ap_rst] [get_bd_pins c_shift_ram_0/Q] [get_bd_pins c_shift_ram_2/D]
  connect_bd_net -net c_shift_ram_1_Q [get_bd_pins ENVELOPE_DETECTOR2/ap_start] [get_bd_pins ENVELOPE_DETECTOR_1/ap_start] [get_bd_pins c_shift_ram_1/Q]
  connect_bd_net -net c_shift_ram_2_Q [get_bd_pins c_shift_ram_2/Q] [get_bd_pins clocked_comparator_2_0/reset]
  connect_bd_net -net clocked_comparator_2_0_A_gt_B [get_bd_pins fsk_demodulated_data_out] [get_bd_pins clocked_comparator_2_0/A_gt_B]
  connect_bd_net -net filter1_1_ap_return [get_bd_pins ENVELOPE_DETECTOR_1/B] [get_bd_pins filter1_1/ap_return]
  connect_bd_net -net filter2_1_ap_return [get_bd_pins ENVELOPE_DETECTOR2/B] [get_bd_pins filter2_1/ap_return]
  connect_bd_net -net input_r_0_1 [get_bd_pins FSK_modulated_data] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net start_1 [get_bd_pins start] [get_bd_pins c_shift_ram_1/D] [get_bd_pins filter1_1/ap_start] [get_bd_pins filter2_1/ap_start]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins filter1_1/input_r] [get_bd_pins filter2_1/input_r] [get_bd_pins xlslice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set FSK_modulated_data [ create_bd_port -dir I -from 31 -to 0 -type data FSK_modulated_data ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set fsk_binary_modulating_data_in [ create_bd_port -dir I fsk_binary_modulating_data_in ]
  set fsk_demodulated_data_out [ create_bd_port -dir O -from 0 -to 0 fsk_demodulated_data_out ]
  set fsk_modulated_data_out [ create_bd_port -dir O -from 15 -to 0 fsk_modulated_data_out ]
  set rst [ create_bd_port -dir I -type rst rst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $rst
  set start [ create_bd_port -dir I start ]

  # Create instance: DEMODULATOR
  create_hier_cell_DEMODULATOR [current_bd_instance .] DEMODULATOR

  # Create instance: MODULATOR
  create_hier_cell_MODULATOR [current_bd_instance .] MODULATOR

  # Create port connections
  connect_bd_net -net SINE_GEN_sine_out_0 [get_bd_ports fsk_modulated_data_out] [get_bd_pins MODULATOR/sine_out_0]
  connect_bd_net -net Sel_0_1 [get_bd_ports fsk_binary_modulating_data_in] [get_bd_pins MODULATOR/fsk_binary_modulating_data_in]
  connect_bd_net -net ap_clk_0_1 [get_bd_ports clk] [get_bd_pins DEMODULATOR/clk] [get_bd_pins MODULATOR/clk]
  connect_bd_net -net ap_rst_0_1 [get_bd_ports rst] [get_bd_pins DEMODULATOR/rst]
  connect_bd_net -net clocked_comparator_2_0_A_gt_B [get_bd_ports fsk_demodulated_data_out] [get_bd_pins DEMODULATOR/fsk_demodulated_data_out]
  connect_bd_net -net input_r_0_1 [get_bd_ports FSK_modulated_data] [get_bd_pins DEMODULATOR/FSK_modulated_data]
  connect_bd_net -net start_1 [get_bd_ports start] [get_bd_pins DEMODULATOR/start]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


