
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SOLENOID_CONTROL is
	port(   CLK: in std_logic; 
			RESET: in std_logic;
			ENABLE: in STD_LOGIC;						-- enable actuator signal, otherwise the system will only disaplay the measured distance 
			DISTANCE_X: in INTEGER;						-- current distance measurement 
		        LEVEL: in INTEGER;						-- incoming level setting signal which corresponds to a distance at which the solenoid is actuated
			SOLENOID_CONTROL_SIGNAL: out std_logic); 			-- signal that controls operation of the solenoid
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

	
-- internal signals
signal amp: integer;
signal counter, trigger: integer;




begin


-- intstantiation of PWM signal generator used to control solenoid through a BJT
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
                 
                 
            elsif((trigger = 1)  and (counter < 500000000)) then               -- adjust counter limits for simulations
                 amp <= 1000;                                                     -- can be adjusted to control solenoid, corresponds to a duty cycle out of 1000
                 counter <= counter +1;                                           -- increase counter
            
            else
                 counter <= 0;                                                 -- reset counter signal
                 trigger <= 0;                                        -- reset solenoid actuation signal
                 amp <= 0;                                                     -- turn solenoid off
            end if;
                                   
                    
        end if;
             
end process;                
                
                


end behavioural;
