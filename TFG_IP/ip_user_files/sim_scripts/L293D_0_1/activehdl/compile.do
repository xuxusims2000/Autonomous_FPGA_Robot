vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vcom -work xil_defaultlib -93 \
"../../../../L293D_0_1/src/DEBOUNCING.vhd" \
"../../../../L293D_0_1/hdl/L293D_v1_0_S00_AXI.vhd" \
"../../../../L293D_0_1/src/PWM_generator.vhd" \
"../../../../L293D_0_1/hdl/L293D_v1_0.vhd" \
"../../../../L293D_0_1/sim/L293D_0.vhd" \


