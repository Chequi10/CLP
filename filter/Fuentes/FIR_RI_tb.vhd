Library IEEE;  
USE IEEE.Std_logic_1164.all;    
USE IEEE.numeric_std.all;  
Use STD.TEXTIO.all;  

 entity TB_FIR is  
 end TB_FIR; 
 
 architecture TB_FIR_arq of TB_FIR is  
 
 Component FIR_RI is  
     generic (  
              input_width  : integer     :=8 ; -- para configurar el ancho de la entrada 
              output_width : integer     :=16; -- para configurar el ancho de salida  
              coef_width   : integer     :=8 ; -- para configurar el ancho del coeficiente 
              tap          : integer     :=11; -- para configurar el orden del filtro   
              guard        : integer     :=4); -- log2(tap)+1  
            
             port(  
                   Din   : in  std_logic_vector(input_width-1 downto 0); -- entrada de la señal a filtrar  
                   Clk   : in  std_logic ;                               -- Clock   
                   reset : in  std_logic ;                               -- Reset   
                   Dout  : out std_logic_vector(output_width-1 downto 0) -- salida de la señal filtrada  
                 );
 end Component;  
 
 ---------------------------------Se declaran las señales de entrada entre etapas-------------------------------------
 signal Din          :std_logic_vector(7 downto 0);  
 signal Clk          :std_logic:='0';  
 signal reset        :std_logic:='1';       
 signal output_ready :std_logic:='0';                                
 signal Dout         :std_logic_vector(15 downto 0);  
 signal input        :std_logic_vector(7 downto 0);  
 
 ---------------------------------Se declaran los archivos de la señal de entrada y salida------------------------------
 file my_input : TEXT open READ_MODE  is "input101.txt";  
 file my_output: TEXT open WRITE_MODE is "output101_functional_sim.txt";  
 
 
 begin  


   FIR_int : FIR_RI  
           generic map(  
                         input_width   => 8,  
                         output_width  => 16,  
                         coef_width    => 8,  
                         tap           => 11,  
                          guard        => 0)  
               port map(  
                          Din   => Din,  
                          Clk   => Clk,  
                          reset => reset,  
                          Dout  => Dout  
                       );  
           
process(clk)  
    
        begin  
-------------------------------------Genero una señal de RELOJ cada 10 nano segundos-----------------------------------------   
           Clk <= not Clk after 10 ns;  
   
end process;  
      
--------Genero un ciclo de RESET se pone alto a los 100 nano segundos y luego a los 503 nano segundos se pone en bajo--------     

         reset <= '1', '1' after 100 ns, '0' after 503 ns; 
 


--------------------Aqui se lee los datos para el banco de pruebas y tambien se escribe la salida--------------------------


process(clk)  
         variable my_input_line : LINE;  
         variable input1: integer;  
    begin  
             if reset ='1' then  
                    
                     Din           <= (others=> '0');  
                     input         <= (others=> '0');  
                     output_ready  <= '0';  
             
             elsif rising_edge(clk) then                      
                   
                     readline(my_input, my_input_line);  
                     read(my_input_line,input1);                      --para leer los valores del banco de prueba
                     Din <= std_logic_vector(to_signed(input1, 8));         
                     output_ready <= '1';  
    end if;  
end process;                      

----------------------------------------------------------------------------------------------------------------------
process(clk)  
           variable my_output_line : LINE;  
           variable input1: integer;  
           begin  
                if falling_edge(clk) then  
                     if output_ready ='1' then  
                          write(my_output_line, to_integer(signed(Dout)));  
                          writeline(my_output,my_output_line);        --para escribir los valores del banco de prueba
                     end if;  
                end if;  
end process;   
-----------------------------------------------------------------------------------------------------------------------                                
end Architecture; 
