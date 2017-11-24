library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_JENNY is			
		Port (    
		          num_of_cycles: in integer;
				  clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  PWM : out  STD_LOGIC
			);
			
end PWM_JENNY;

architecture Behavioural of PWM_JENNY is 

signal counter: integer;
signal max_counter: integer := 9999;

begin

process(CLK, RESET)
begin
			if(reset = '1') then 
				PWM <= '0';
			
			elsif(rising_edge(CLK)) then 
			
					if((counter < max_counter) and (counter < num_of_cycles-1)) then
						counter <= counter + 1;
						PWM <= '1';
					
					elsif ((counter < max_counter) and (counter >= num_of_cycles-1)) then 
						counter <= counter + 1;
						PWM <= '0';
					
					else
					
					counter <= 0;
					
					end if;
			end if;

end process;

end behavioural; 