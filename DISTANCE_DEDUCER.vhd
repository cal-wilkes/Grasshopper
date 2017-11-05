----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2017 11:22:13 AM
-- Design Name: 
-- Module Name: DISTANCE_DEDUCER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DISTANCE_DEDUCER is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       COMPARE: in STD_LOGIC;
	       REF:  in INTEGER;
	       MEAS: in INTEGER;
	       DISTANCE_D: out INTEGER;
	       DISTANCE_X: out INTEGER   );
	       
end DISTANCE_DEDUCER;

architecture Behavioural of DISTANCE_DEDUCER is

signal i_DISTANCE_X, i_DISTANCE_D: integer;

begin


process(COMPARE)
begin
          
                            if (COMPARE = '0') then 
                            
                                        i_DISTANCE_X <= (MEAS)+REF;   -- example distance mathematical expression for cm
                                        i_DISTANCE_D <= (MEAS)+REF; -- example distance mathematical expression for mm 
                                        
                            end if;
                                       
            
end process;

process(CLK)
begin

                           if(rising_edge(CLK)) then 
                                        
                                        DISTANCE_X <= i_DISTANCE_X;
                                        DISTANCE_D <= i_DISTANCE_D;
                          
                           end if;
                                        


end process;

        
                               

end behavioural;