# Edited rebuild_project.tcl for Portability
# Set the reference directory to the current script location
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

set _xil_proj_name_ "VEIHCLE_v1"

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7z020clg400-1

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "tul.com.tw:pynq-z2:part0:1.0" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj

# Set IP repository paths (Point to the TFG_IP folder in your repo)
set obj [get_filesets sources_1]
if { $obj != {} } {
   set_property "ip_repo_paths" "[file normalize "$origin_dir/TFG_IP/ip_repo"]" $obj
   update_ip_catalog -rebuild
}

# Add Block Design
add_files -fileset sources_1 [file normalize "${origin_dir}/design_1.bd"]

# Add Constraints
add_files -fileset constrs_1 [file normalize "${origin_dir}/constrains.xdc"]

# Add Top Level Wrapper
add_files -fileset sources_1 [file normalize "${origin_dir}/design_1_wrapper.vhd"]

puts "INFO: Project created successfully from relative paths!"