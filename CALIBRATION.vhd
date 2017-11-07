--This module's functionality is extremely important for consistent functioning of our VHDL code and system. 
--The module will function as a state machine where in the first state (S0) the code waits for the signal from 
--the input CALIBRATE to equal 1. This occurs only when the Calibrate Button on the FPGA is pressed. Once in 
--the second state (S1) the code will sample and hold the current value of the input DISTANCE_X and store the value 
--in a temporary storage signal internal to the module. Finally in the final code will update the code should wait a
--predetermined number of clock cycles (using an internal counter or an instantiation of the down counter module) 
--before updating the output signal REFERENCE with the value store in the internal temporary signal. The value of 
--REFERENCE will correspond to the voltage output of the ADC at a predetermined distance of for example 10cm. The signal
--REFERENCE will be used in other modules to determine the mathematical translation of the ADC value to a measurement of
--distance in centimetres. 



--Inputs: CLK: STD_LOGIC 
--            RESET: STD_LOGIC 
--            CALIBRATE: STD_LOGIC
--            DISTANCE_X: INTEGER



--Outputs: 
--         REFERENCE: INTEGER


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
