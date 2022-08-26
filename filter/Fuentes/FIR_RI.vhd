Library IEEE;  
use IEEE.Std_logic_1164.all;   
use IEEE.Std_logic_signed.all;  
use IEEE.numeric_std.all;
 
  -- Aca creo la entidad del Filtro Fir( se declaran la variables y junto con los puertos)
  ---------------------------------------------------------------------------------------------
 entity FIR_RI is  
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
          
end;  
 
architecture FIR_RI_arq of FIR_RI is  
 
--Se llama al componente Registro de N bits (que es un retardo de la señal de entrada entre etapas)
 
 component N_bit_Reg   
     generic ( input_width: integer:=8);  
           port(  
                 D :in std_logic_vector(input_width-1 downto 0); 
                 Q :out std_logic_vector(input_width-1 downto 0);     
               Clk :in std_logic;    
             reset :in std_logic   
                    
                );  
 
 end component;
 
 -----------------------------------Se declara un tipo de variable para los coeficientes-----------------------------------
 type Coeficient_type is array (1 to tap) of std_logic_vector(coef_width-1 downto 0);  
 
 
 
 -----------------------------------Coeficientes del filtro----------------------------------------------------------------  
 constant coeficient: coeficient_type := (X"F1",X"F3",X"07",X"26",X"42",X"4E",X"42",X"26",X"07",X"F3",X"F1");                    
  
  
                                   
 -------Se declaran tipos de variable para el multiplicador, sumador y para la señales de entrada entre etapas-------------
 
 type   shift_reg_type is array (0 to tap-1) of std_logic_vector(input_width-1 downto 0);  
 signal shift_reg : shift_reg_type;  
 type   mult_type      is array (0 to tap-1) of std_logic_vector(input_width+coef_width-1 downto 0);  
 signal mult : mult_type;  
 type   ADD_type       is array (0 to tap-1) of std_logic_vector(input_width+coef_width-1 downto 0);  
 signal ADD: ADD_type;  
 
 begin  

-----------Aqui se implementa el primer multiplicador, observar que los operandos tienen el mismo ancho---------------------   
        shift_reg(0)<= Din;  
             mult(0)<= Din*coeficient(1);  
              ADD(0)<= Din*coeficient(1);  
              
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-------------------Aqui se implementa la cantidad de etapas del filtro mediante un GENERATE---------------------------------             

        GEN_FIR:  
       for i in 0 to tap-2 generate  
           begin  
--Unidad del retardo de N  Bits, Aqui le asigno las señales a los distintos puertos  
                 N_bit_Reg_unit : N_bit_Reg generic map (input_width => 8)   
                          port map ( 
                                      Clk => Clk,   
                                    reset => reset,  
                                        D => shift_reg(i),  
                                        Q => shift_reg(i+1)  
                                    );       
              
--Aca implemento una multiplicacion segun la estructura del Filtro Digital  
               
                mult(i+1)<= shift_reg(i+1)*coeficient(i+2);  
            
--Aca implemento una suma segun la estructura del Filtro Digital
               
                ADD(i+1)<=ADD(i)+mult(i+1);  
          
           end generate GEN_FIR; 
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------           
---------------------------------------------------------------------------------------------------------------------------------            
--Aca asigno al puerto de Salida la señal del ultimo sumador               
                   Dout <= ADD(tap-1);  
                   
 end Architecture; 
