--This module is responsible for controlling the distance measurement at which the solenoid control module should actuate the solenoid.
--The module takes input from two buttons to either increase or decrease the module's output integer LEVEL. The increments between levels
--should be equivalent to approximately 1cm intervals from 4cm to 10cm. The values of these increments shall be determined using the calibration 
--signal REFERENCE and a mathematical formulation to determine all other level measurements from the reference distance. Essentially, implementation 
--requires a Moore FSM which transitions between states equivalent to various levels of difficulty. I would suggest beginning work on this module 
--by referring to the code for the frequency_module and amplitude_module from lab 4. Please use if statements to replace the case statements as I 
--have found that if statements synthesize more reliably. Additionally designing a FSM on paper will be beneficial for designing this module and should 
--be completed with the intention that it may be used in the final report. 

--Inputs: 
--		CLK: STD_LOGIC 
--		RESET: STD_LOGIC 
--		LEVEL_UP_BTN: INTEGER
--		LEVEL_DOWN_BTN: INTEGER 
--		REFERENCE: INTEGER . 

--Outputs: 
--		LEVEL: INTEGER




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_lOGIC_UNSIGNED.ALL;

entity ADJUST_LEVEL is
		Port (
				CLK: in STD_LOGIC;
				RESET: in STD_LOGIC;
                LEVEL_SWITCH: in STD_LOGIC_VECTOR(1 downto 0);
                LEVEL: out INTEGER  );
end ADJUST_LEVEL;

architecture Behaviour of ADJUST_LEVEL is

begin


CHANGE_LEVEL: process(CLK) begin

      if(rising_edge(CLK)) then
            
            if( (LEVEL_SWITCH(0) = '0') and (LEVEL_SWITCH(1) = '0')) then 
                    
                    LEVEL <= 4;
                    
            
            elsif((LEVEL_SWITCH(0) = '1') and (LEVEL_SWITCH(1) = '0')) then 
                                       
                    LEVEL <= 5;
                    
              
            elsif((LEVEL_SWITCH(0) = '0') and (LEVEL_SWITCH(1) = '1')) then 
                                                        
                    LEVEL <= 7;
                    
                    
            elsif((LEVEL_SWITCH(0) = '1') and (LEVEL_SWITCH(1) = '1')) then 
                                                        
                    LEVEL <= 10;
                    
            
            end if;
       
      end if;
       
end process;


end behaviour;
