
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
# find_peak

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
xilinx.com:ip:c_counter_binary:12.0\
xilinx.com:ip:xfft:9.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:c_addsub:12.0\
xilinx.com:ip:cordic:6.0\
xilinx.com:ip:mult_gen:12.0\
xilinx.com:ip:xlslice:1.0\
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
find_peak\
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


# Hierarchical cell: FFT_MAGNITUDE_FSK
proc create_hier_cell_FFT_MAGNITUDE_FSK { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_FFT_MAGNITUDE_FSK() - Empty argument(s)!"}
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
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir I -type clk aclk_0
  create_bd_pin -dir O -from 31 -to 0 m_axis_dout_tdata_0
  create_bd_pin -dir O m_axis_dout_tvalid_0
  create_bd_pin -dir I s_axis_cartesian_tvalid_0

  # Create instance: c_addsub_0, and set properties
  set c_addsub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_0 ]
  set_property -dict [list \
    CONFIG.A_Width {32} \
    CONFIG.B_Value {00000000000000000000000000000000} \
    CONFIG.B_Width {32} \
    CONFIG.CE {false} \
    CONFIG.Latency {1} \
    CONFIG.Out_Width {32} \
  ] $c_addsub_0


  # Create instance: cordic_0, and set properties
  set cordic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0 ]
  set_property -dict [list \
    CONFIG.Coarse_Rotation {false} \
    CONFIG.Data_Format {UnsignedFraction} \
    CONFIG.Functional_Selection {Square_Root} \
    CONFIG.Input_Width {32} \
    CONFIG.Output_Width {32} \
  ] $cordic_0


  # Create instance: mult_gen_0, and set properties
  set mult_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_0 ]
  set_property -dict [list \
    CONFIG.PortAType {Signed} \
    CONFIG.PortAWidth {16} \
    CONFIG.PortBType {Signed} \
    CONFIG.PortBWidth {16} \
  ] $mult_gen_0


  # Create instance: mult_gen_1, and set properties
  set mult_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_1 ]
  set_property -dict [list \
    CONFIG.PortAType {Signed} \
    CONFIG.PortAWidth {16} \
    CONFIG.PortBType {Signed} \
    CONFIG.PortBWidth {16} \
  ] $mult_gen_1


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {31} \
    CONFIG.DIN_TO {16} \
  ] $xlslice_0


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {15} \
    CONFIG.DIN_TO {0} \
  ] $xlslice_1


  # Create port connections
  connect_bd_net -net aclk_0_1 [get_bd_pins aclk_0] [get_bd_pins c_addsub_0/CLK] [get_bd_pins cordic_0/aclk] [get_bd_pins mult_gen_0/CLK] [get_bd_pins mult_gen_1/CLK]
  connect_bd_net -net c_addsub_0_S [get_bd_pins c_addsub_0/S] [get_bd_pins cordic_0/s_axis_cartesian_tdata]
  connect_bd_net -net cordic_0_m_axis_dout_tdata [get_bd_pins m_axis_dout_tdata_0] [get_bd_pins cordic_0/m_axis_dout_tdata]
  connect_bd_net -net cordic_0_m_axis_dout_tvalid [get_bd_pins m_axis_dout_tvalid_0] [get_bd_pins cordic_0/m_axis_dout_tvalid]
  connect_bd_net -net mult_gen_0_P [get_bd_pins c_addsub_0/B] [get_bd_pins mult_gen_0/P]
  connect_bd_net -net mult_gen_1_P [get_bd_pins c_addsub_0/A] [get_bd_pins mult_gen_1/P]
  connect_bd_net -net s_axis_cartesian_tvalid_0_1 [get_bd_pins s_axis_cartesian_tvalid_0] [get_bd_pins cordic_0/s_axis_cartesian_tvalid]
  connect_bd_net -net xfft_1_m_axis_data_tdata [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins mult_gen_0/A] [get_bd_pins mult_gen_0/B] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins mult_gen_1/A] [get_bd_pins mult_gen_1/B] [get_bd_pins xlslice_1/Dout]

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
  set S_AXIS_DATA_0_tdata [ create_bd_port -dir I -from 31 -to 0 S_AXIS_DATA_0_tdata ]
  set S_AXIS_DATA_0_tvalid [ create_bd_port -dir I -type ce S_AXIS_DATA_0_tvalid ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $S_AXIS_DATA_0_tvalid
  set aclk_0 [ create_bd_port -dir I -type clk aclk_0 ]
  set max_index_0 [ create_bd_port -dir O -from 31 -to 0 max_index_0 ]

  # Create instance: FFT_MAGNITUDE_FSK
  create_hier_cell_FFT_MAGNITUDE_FSK [current_bd_instance .] FFT_MAGNITUDE_FSK

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Output_Width {12} \
    CONFIG.Restrict_Count {false} \
    CONFIG.Sync_Threshold_Output {true} \
    CONFIG.Threshold_Value {0} \
  ] $c_counter_binary_0


  # Create instance: find_peak_0, and set properties
  set block_name find_peak
  set block_cell_name find_peak_0
  if { [catch {set find_peak_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $find_peak_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xfft_FSK_demod, and set properties
  set xfft_FSK_demod [ create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 xfft_FSK_demod ]
  set_property -dict [list \
    CONFIG.butterfly_type {use_xtremedsp_slices} \
    CONFIG.implementation_options {automatically_select} \
    CONFIG.input_width {16} \
    CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {5} \
    CONFIG.output_ordering {natural_order} \
    CONFIG.ovflo {false} \
    CONFIG.phase_factor_width {16} \
    CONFIG.rounding_modes {convergent_rounding} \
    CONFIG.target_clock_frequency {100} \
    CONFIG.target_data_throughput {100} \
    CONFIG.throttle_scheme {nonrealtime} \
    CONFIG.transform_length {4096} \
  ] $xfft_FSK_demod


  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property CONFIG.CONST_VAL {0} $xlconstant_1


  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {16} \
  ] $xlconstant_2


  # Create port connections
  connect_bd_net -net CE_0_1 [get_bd_ports S_AXIS_DATA_0_tvalid] [get_bd_pins c_counter_binary_0/CE] [get_bd_pins xfft_FSK_demod/s_axis_data_tvalid]
  connect_bd_net -net FFT_MAGNITUDE_FSK_M_AXIS_DOUT_0_tdata [get_bd_pins FFT_MAGNITUDE_FSK/m_axis_dout_tdata_0] [get_bd_pins find_peak_0/M_AXIS_DATA_0]
  connect_bd_net -net FFT_MAGNITUDE_FSK_m_axis_dout_tvalid_0 [get_bd_pins FFT_MAGNITUDE_FSK/m_axis_dout_tvalid_0] [get_bd_pins find_peak_0/m_axis_data_tvalid_0]
  connect_bd_net -net aclk_0_1 [get_bd_ports aclk_0] [get_bd_pins FFT_MAGNITUDE_FSK/aclk_0] [get_bd_pins c_counter_binary_0/CLK] [get_bd_pins find_peak_0/clk] [get_bd_pins xfft_FSK_demod/aclk]
  connect_bd_net -net c_counter_binary_0_THRESH0 [get_bd_pins c_counter_binary_0/THRESH0] [get_bd_pins xfft_FSK_demod/s_axis_data_tlast]
  connect_bd_net -net find_peak_0_max_index [get_bd_ports max_index_0] [get_bd_pins find_peak_0/max_index]
  connect_bd_net -net s_axis_data_tdata_0_1 [get_bd_ports S_AXIS_DATA_0_tdata] [get_bd_pins xfft_FSK_demod/s_axis_data_tdata]
  connect_bd_net -net xfft_0_m_axis_data_tdata [get_bd_pins FFT_MAGNITUDE_FSK/Din] [get_bd_pins xfft_FSK_demod/m_axis_data_tdata]
  connect_bd_net -net xfft_FSK_demod_m_axis_data_tlast [get_bd_pins find_peak_0/m_axis_data_tlast_0] [get_bd_pins xfft_FSK_demod/m_axis_data_tlast]
  connect_bd_net -net xfft_FSK_demod_m_axis_data_tvalid [get_bd_pins FFT_MAGNITUDE_FSK/s_axis_cartesian_tvalid_0] [get_bd_pins xfft_FSK_demod/m_axis_data_tvalid]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins xfft_FSK_demod/s_axis_config_tvalid] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins xfft_FSK_demod/s_axis_config_tdata] [get_bd_pins xlconstant_2/dout]

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


