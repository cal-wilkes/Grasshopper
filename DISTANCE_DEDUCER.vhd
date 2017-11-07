--This module is responsible for the translation of the ADC value to a distance measurement with accuracy to the 0.1cm scale.
--The module receives an integer ADC value which its then converts to a distance measurement in centimetres. The module does
--this using a calibration point and a mathematical module based on this calibration point to determine all other distance.
--This could be achieved through an equation or a lookup table. I suggest trying to implement both the lookup table and equation
--so we have the option to determine which works more effectively. The module outputs both a 3 integer array, for which the most 
--significant index represents the tens of centimetres position and the last significant index represents the tenths of centimetres
--positions to be used by the VGA Controller Module, and a single integer which represents the measurement with only a 1 cm resolution
--to be used by the Solenoid Control Module. 


--Inputs: CLK: STD_LOGIC 
--           RESET: STD_LOGIC 
--            COMPARE: STD_LOGIC
--            REF: INTEGER
--            MEAS: INTEGER

--The module receives both the system clock and reset signals. The module also receives a signal COMPARE from the ADC circuitry
--which signals for the module to record the current value of the input signal MEAS which is proportional to the current voltage
--out of the Saw Wave Generator Module. The module finally receives a signal, REFERENCE which is used as the calibration point. 

--Outputs: DISTANCE_D: Integer
--                DISTANCE_X: Integer

--The module outputs both a 3 integer array, for which the most significant index represents the tens of centimetres position and
--the last significant index represents the tenths of centimetres positions to be used by the VGA Controller Module, and a single
--integer which represents the measurement with only a 1 cm resolution to be used by the Solenoid Control Module.


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
