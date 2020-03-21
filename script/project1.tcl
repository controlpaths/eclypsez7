## Script name:   project1
## Script version:  1.0
## Author:  P.Trujillo (pablo@controlpaths.com)
## Date:    Mar20
## Description: Script for create eclypsez7_adc_dac project

set projectDir ../project
set projectName eclypsez7_adc_dac

## Delete log and journal
file delete {*}[glob vivado*.backup.jou]
file delete {*}[glob vivado*.backup.log]
file delete -force .Xil/

## Create project in ../project
create_project -force $projectDir/$projectName.xpr

## Set verilog as default language
set_property target_language Verilog [current_project]

## Adding verilog files
add_file [glob ../src/*.v]

## Adding memory files
add_file [glob ../memory_content/*.mem]

## Adding constraints files
read_xdc ../xdc/eclypse_z7_dac_a_adc_b.xdc

## Set top module
set_property top top_eclypse_v1_0 [current_fileset]

## Set current board eclypsez7.
set_property BOARD_PART digilentinc.com:eclypse-z7:part0:1.0 [current_project]

## Open vivado for verify
start_gui
