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
	       DISTANCE_RAW: out INTEGER;
	       DISTANCE_ONES: out INTEGER;
	       DISTANCE_TENS: out INTEGER;
	       DISTANCE_TENTHS: out INTEGER
	                     --;
	      -- DISTANCE_D: out INTEGER;
	     --  DISTANCE_X: out INTEGER  
	      );
	       
end DISTANCE_DEDUCER;

architecture Behavioural of DISTANCE_DEDUCER is

signal i_DISTANCE_X, i_DISTANCE_D, i_DISTANCE_RAW, snap, aquired: integer;

begin


sample: process(COMPARE)
begin
          if rising_edge(CLK) then
                            if (COMPARE = '0' and aquired = 0 and meas /= 0) then 
                                        
                                        DISTANCE_RAW <= MEAS;
                                        snap <= meas;
                                        aquired <= 1;
                                     --   i_DISTANCE_X <= (MEAS)+REF;   -- example distance mathematical expression for cm REQUIRES CALIBRATION
                                     --   i_DISTANCE_D <= (MEAS)+REF; -- example distance mathematical expression for mm REQUIRES CALIBRATION
                             
                             elsif(aquired = 1 and meas = 0) then 
                                       
                                    aquired <= 0;
                                    snap <= snap;
                                        
                            end if;
            end if;                
                                       
            
end process;

up_date: process(snap)
begin

                        if(rising_edge(CLK)) then 
                                        
                                   DISTANCE_ONES <=  (snap - (snap/100)*100)/10;
                                   DISTANCE_TENS <=  snap/100;
                                   DISTANCE_TENTHS <= (snap - (snap/100)*100 - (snap/10)*10) ;
                          
                         end if;
                                        


end process;

	       
        
                               

end behavioural;