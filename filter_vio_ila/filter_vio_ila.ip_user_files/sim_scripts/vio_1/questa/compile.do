vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/sim/vio.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

