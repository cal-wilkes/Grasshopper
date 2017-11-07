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
	       COMPARE: in STD_LOGIC;               -- signal from ADC circuit that signals that the measure value correlates to the value read by the IR sensor
	       REF:  in INTEGER;
	       MEAS: in INTEGER;                    -- incoming ADC value from saw wave (DAC) module
	       DISTANCE_RAW: out INTEGER;
	       DISTANCE_D: out INTEGER;
	       DISTANCE_X: out INTEGER   );
	       
end DISTANCE_DEDUCER;

architecture Behavioural of DISTANCE_DEDUCER is

signal i_DISTANCE_X, i_DISTANCE_D, i_DISTANCE_RAW: integer;

begin


sample: process(COMPARE)
begin
          
                            if (COMPARE = '0') then 
                                        
                                        i_DISTANCE_RAW <= MEAS;        -- raw unprocessed ADC value
                                        i_DISTANCE_X <= (MEAS)+REF;   -- example distance mathematical expression for cm REQUIRES CALIBRATION
                                        i_DISTANCE_D <= (MEAS)+REF; -- example distance mathematical expression for mm REQUIRES CALIBRATION
                                        
                            end if;
                                       
            
end process;

up_date: process(CLK)
begin

                           if(rising_edge(CLK)) then 
                                        
                                        DISTANCE_RAW <= i_DISTANCE_RAW;       -- update signals
                                        DISTANCE_X <= i_DISTANCE_X;
                                        DISTANCE_D <= i_DISTANCE_D;
                          
                           end if;
                                        


end process;

        
                               

end behavioural;
