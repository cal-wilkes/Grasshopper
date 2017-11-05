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