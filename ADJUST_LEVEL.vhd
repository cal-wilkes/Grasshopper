library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_lOGIC_UNSIGNED.ALL;

entity ADJUST_LEVEL is
		Port (
				CLK: in STD_LOGIC;
				RESET: in STD_LOGIC;
				sam: out integer;
                LEVEL_SWITCH: in STD_LOGIC_VECTOR(1 downto 0);
                LEVEL: out INTEGER  );
end ADJUST_LEVEL;

architecture Behaviour of ADJUST_LEVEL is

begin


CHANGE_LEVEL: process(CLK) begin

      if(rising_edge(CLK)) then
            
            if( (LEVEL_SWITCH(0) = '0') and (LEVEL_SWITCH(1) = '0')) then 
                    
                    LEVEL <= 3000;
                    sam <= 30000000;
                    
            
            elsif((LEVEL_SWITCH(0) = '1') and (LEVEL_SWITCH(1) = '0')) then 
                                       
                    LEVEL <= 2500;
                       sam <= 30000000;
                    
              
            elsif((LEVEL_SWITCH(0) = '0') and (LEVEL_SWITCH(1) = '1')) then 
                                                        
                    LEVEL <= 2500;
                       sam <= 20000000;
                    
                    
            elsif((LEVEL_SWITCH(0) = '1') and (LEVEL_SWITCH(1) = '1')) then 
                                                        
                    LEVEL <= 2000;
                       sam <= 10000000;
                    
            
            end if;
       
      end if;
       
end process;


end behaviour;