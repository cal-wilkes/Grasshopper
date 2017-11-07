--This module is responsible for controlling the solenoid which will be used to move the pebble out of reach of the player. 
--The module is responsible for setting the current level. The level is an integer which determines the distance measurement 
--at which the solenoid will be activated. Therefore the module needs to have a comparison between the DISTANCE_X input and 
--the LEVEL input and in response to an equal condition the module should output a PWM square wave output at a frequency to be
--determined based on design of the electromechanical module. The module should output the PWM signal for a predetermined amount
--of time which is determined from a number of clock cycles. (recall: the clock runs at 100MHz that is 10^8 clock cycles per second) 

--Additionally this module should have the ability to be disabled using the ENABLE signal so that the system is not inadvertently 
--triggered. 

--Inputs: CLK: STD_LOGIC
--            RESET: STD_LOGIC 
--            DISTANCE_X: Integer
--            LEVEL: Integer
--            ENABLE: STD_LOGIC


--This module will receive both the system CLK and Reset. The module receives a integer signal 
--DISTANCE_X from the distance deducer which represents the distance measured with 1cm resolution. The module also receives a signal LEVEL which represents the distance at which the actuator should be triggered. Finally the module receives a signal ENABLE which is used for enabling/disabling the electromechanical system. 


--Outputs: SOLENOID_CONTROL: STD_LOGIC 

--This modules outputs a PWM signal in the form of a square wave with a 50% duty cycle at a frequency yet to be determined. 


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
