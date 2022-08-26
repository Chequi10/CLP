ghdl -a ../../N_bit_Reg/Fuentes/N_bit_Reg.vhd ../Fuentes/FIR_RI.vhd ../Fuentes/FIR_RI_tb.vhd
ghdl -s ../../N_bit_Reg/Fuentes/N_bit_Reg.vhd ../Fuentes/FIR_RI.vhd ../Fuentes/FIR_RI_tb.vhd
ghdl -e FIR_RI_tb
ghdl -r FIR_RI_tb --vcd=FIR_RI_tb.vcd --stop-time=1000ns
gtkwave FIR_RI_tb.vcd

