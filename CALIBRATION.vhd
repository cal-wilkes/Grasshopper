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


entity CALIBRATION is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       CALIBRATE: in STD_LOGIC;
	       DISTANCE_RAW:  in INTEGER;    -- incoming ADC sampled value 
	       REF: out INTEGER   );        -- signal that corresponds to ADC value at predetermined distance
	       
end CALIBRATION;

architecture Behavioural of CALIBRATION is

signal i_REF: INTEGER := 100;

begin

cali: process(CALIBRATE)
begin

        if(CALIBRATE = '1') then
                    
                        i_REF <= DISTANCE_RAW;      -- sample and hold the ADC value at predetermine calibration distance
        
        end if;            
                

end process;

up_date_REF: process(CLK)
begin
         if(rising_edge(CLK)) then
         
                        REF <= i_REF;           -- update reference value for sensor calibration
         
         end if;
                        
end process;

        
                               

end behavioural;
