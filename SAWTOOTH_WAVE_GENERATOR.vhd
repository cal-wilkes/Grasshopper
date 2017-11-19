
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SAWTOOTH_WAVE_GENERATOR is
	port(   clk: in std_logic; 
			reset: in std_logic;
			MEAS: out INTEGER;
			SAW_PWM: out std_logic);
end SAWTOOTH_WAVE_GENERATOR;

architecture Behavioural of SAWTOOTH_WAVE_GENERATOR is

component PWM_JENNY is			
		Port ( 
		          num_of_cycles: in integer;
				  clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  PWM : out  STD_LOGIC
			);
			
end component;



signal amp, temp: integer :=0;
signal counter, internal_counter: integer;



begin




saw_jenny: PWM_JENNY
        PORT MAP (
                  num_of_cycles => amp,
                  CLK => CLK,
                  reset => reset,
                  PWM => SAW_PWM
        );


 
               
        
process (CLK)

begin 



                if(rising_edge(CLK)) then 
                
      
                                
                       if(RESET = '1') then               
                             counter <= 0;
                             internal_counter <= 0;
                             amp <= 0;
                                      
                
                       elsif((counter < 100000000) and (internal_counter = 100000)) then 
                             amp <= amp + 1;
                             meas <= amp;
                             counter <= counter+1;
                             internal_counter <= 0;
                             
                       
                       elsif(counter < 100000000) then                    
                             counter <= counter+1;
                             meas <= amp;
                             internal_counter <= internal_counter +1;
                             
                       
                       else
                            amp <= 0;
                            counter <= 0;
                            internal_counter <= 0;
                             
                       end if;
       
                end if;
                
end process;  


end behavioural;