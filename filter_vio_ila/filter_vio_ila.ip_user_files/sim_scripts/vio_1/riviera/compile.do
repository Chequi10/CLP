vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/sim/vio.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

