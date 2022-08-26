vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/hdl" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/sim/vio.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

