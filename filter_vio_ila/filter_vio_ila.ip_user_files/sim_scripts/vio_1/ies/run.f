-makelib ies_lib/xil_defaultlib -sv \
  "/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../filter_vio_ila.srcs/sources_1/ip/vio_1/sim/vio.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

