Library IEEE;  
use IEEE.Std_logic_1164.all;   
use IEEE.Std_logic_signed.all;  
use IEEE.numeric_std.all;
 

 entity FIR_RI_vio_ila  is 
   port(  Clk: in  std_logic
        ); 
          
end;  
 
architecture FIR_RI_vio_ila_arq of FIR_RI_vio_ila is  

 component FIR_RI is  
 generic (  
           input_width  : integer :=8  ;-- para configurar el ancho de la entrada 
           output_width : integer :=16 ;-- para configurar el ancho de salida  
           coef_width   : integer :=8  ;-- para configurar el ancho del coeficiente 
           tap          : integer :=11 ;-- para configurar el orden del filtro 
           guard        : integer :=0   -- log2(tap)+1  
          ) ;
  
   port(  
           Din: in  std_logic_vector(input_width-1 downto 0);-- entrada de la señal a filtrar  
           Clk: in  std_logic;                               -- Clock  
         reset: in  std_logic;                               -- Reset  
          Dout: out std_logic_vector(output_width-1 downto 0)-- salida de la señal filtrada
      
  
        );
end component; 

COMPONENT vio
  PORT (
  clk : IN STD_LOGIC;
  probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
  probe_out1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

COMPONENT ila_0

PORT (
	clk :    IN STD_LOGIC;
	probe0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END COMPONENT;

signal prueba_reset : STD_LOGIC_VECTOR ( 0 downto 0);
signal prueba_dout : STD_LOGIC_VECTOR ( 15 downto 0);
signal din : STD_LOGIC_VECTOR ( 7 downto 0);

begin  
 
 filter_inst: FIR_RI 
 port map(
           Din => din,
           Clk => Clk,
         reset => prueba_reset(0),
          Dout => prueba_dout
         );  
 
 vio_inst: vio
  PORT MAP (
   clk => clk,
   probe_out0 => prueba_reset,
   probe_out1 => din
 );
  
 ila_inst: ila_0
  PORT MAP (
      clk => clk,
      probe0 => prueba_dout( 15 downto 0)
  ); 
                   
 end; 
