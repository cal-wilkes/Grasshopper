library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_JENNY is			
		Port (    
		          num_of_cycles: in integer;            -- indicates the number of system clock cycles that the output is set high for
				  clk : in  STD_LOGIC;          -- system clock @ 100 MHz
				  reset : in  STD_LOGIC;        -- system reset
				  PWM : out  STD_LOGIC          -- Pulse width modulated output signal 
			);
			
end PWM_JENNY;

architecture Behavioural of PWM_JENNY is 

signal counter: integer;                                     -- internal system clock counter
signal max_counter: integer := 999;                           -- number of system clock cycles per period 

begin
 
process(CLK, RESET)
begin
			if(reset = '1') then 
				PWM <= '0';
			
			elsif(rising_edge(CLK)) then 
			
					if((counter < max_counter) and (counter < num_of_cycles-1)) then       -
						counter <= counter + 1;                                 
						PWM <= '1';                                                          -- set output to logic high
					
					elsif ((counter < max_counter) and (counter >= num_of_cycles-1)) then 
						counter <= counter + 1;
						PWM <= '0'; 								-- set output to logic low 
					
					else
					
					counter <= 0;
					
					end if;
			end if;

end process;

end behavioural; 
