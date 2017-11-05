
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SOLENOID_CONTROL is
	port(   CLK: in std_logic; 
			RESET: in std_logic;
			ENABLE: in STD_LOGIC;
			DISTANCE_X: in INTEGER;
		    LEVEL: in INTEGER;
			SOLENOID_CONTROL_SIGNAL: out std_logic);
end SOLENOID_CONTROL;

architecture Behavioural of SOLENOID_CONTROL is

component PWM_JENNY is			
		Port ( 
		          num_of_cycles: in integer;
				  clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  PWM : out  STD_LOGIC
			);
			
end component;

signal amp: integer;
signal counter, trigger: integer;




begin


saw_jenny: PWM_JENNY
        PORT MAP (
                  num_of_cycles => amp,
                  CLK => CLK,
                  reset => reset,
                  PWM => SOLENOID_CONTROL_SIGNAL
        );
        
 
               
        
actuate: process (DISTANCE_X, CLK)
begin 

        if (rising_edge(CLK)) then 
        
           if(RESET = '1') then 
                counter <= 0;                                                 -- reset counter signal
                trigger <= 0;                                        -- reset solenoid actuation signal
                amp <= 0;                                                     -- turn solenoid off
            
           elsif ((DISTANCE_X < LEVEL) and (trigger = 0) and (ENABLE = '1')) then 
            
                 trigger <= 1;                                                 -- actuate the solenoid
                 
                 
            elsif((trigger = 1)  and (counter < 500000000)) then               -- adjust counter limits for simulationS
                 amp <= 1000;                                                     -- can be adjusted to control solenoid 
                 counter <= counter +1;                                           -- increase counter
            
            else
                 counter <= 0;                                                 -- reset counter signal
                 trigger <= 0;                                        -- reset solenoid actuation signal
                 amp <= 0;                                                     -- turn solenoid off
            end if;
                                   
                    
        end if;
             
end process;                
                
                


end behavioural;
