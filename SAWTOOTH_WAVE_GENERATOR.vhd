
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SAWTOOTH_WAVE_GENERATOR is
	port(   clk: in std_logic;   					-- system clock 
			reset: in std_logic;  				-- system reset
			SAW_PWM: out std_logic);			-- saw wave signal 
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

signal amp: integer :=0;
signal counter, internal_counter: integer;



begin


saw_jenny: PWM_JENNY						-- instantiation of pwm signal generator 
        PORT MAP (
                  num_of_cycles => amp,
                  CLK => CLK,
                  reset => reset,
                  PWM => SAW_PWM
        );
        
 
               
        
process (CLK)

begin 

                if(rising_edge(CLK)) then  		
                
                       if(RESET = '1') then               						-- reset behaviour
                             counter <= 0;
                             internal_counter <= 0;
                             amp <= 0;
                                      
                
                       elsif((counter < 100000000) and (internal_counter = 1000000)) then 
                             amp <= amp + 10;                        					-- increase amplitude output signal to create linear ramping 
                             counter <= counter+1;
                             internal_counter <= 0;
                             
                       
                       elsif(counter < 100000000) then                    
                             counter <= counter+1;
                             internal_counter <= internal_counter +1;
                             
                       
                       else
                            amp <= 0;
                            counter <= 0;
                            internal_counter <= 0;
                             
                       end if;
       
                end if;
                
end process;                
                


end behavioural;
