library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity CALIBRATION is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       CALIBRATE: in STD_LOGIC;
	       DISTANCE_RAW:  in INTEGER;
	       REF: out INTEGER   );
	       
end CALIBRATION;

architecture Behavioural of CALIBRATION is

signal i_REF: INTEGER := 100;

begin

cali: process(CALIBRATE)
begin

        if(CALIBRATE = '1') then
                    
                        i_REF <= DISTANCE_RAW;
        
        end if;            
                

end process;

up_date_REF: process(CLK)
begin
         if(rising_edge(CLK)) then
         
                        if(reset = '1') then
                        
                        REF <= 3520;
                        
                        else
         
                        REF <= i_REF;
                        
                        end if;
         
         end if;
                        
end process;                       

end behavioural;
