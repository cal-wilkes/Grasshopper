library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CALIBRATION_TB is
end CALIBRATION_TB;

architecture Behavioral of CALIBRATION_TB is

component CALIBRATION is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       CALIBRATE: in STD_LOGIC;
	       DISTANCE_RAW:  in INTEGER;
	       REF: out INTEGER   );


end component;

signal clk, reset, calibrate: STD_LOGIC;
signal ref, distance_raw: INTEGER;


begin

uut: CALIBRATION 
	port map(   
	           CLK => clk,
               RESET => reset,
               CALIBRATE => calibrate,
               DISTANCE_RAW => distance_raw,
               REF => ref  );

clock_process: process
begin

        clk <= '0';
        wait for 5ns;
        clk <= '1';
        wait for 5ns;

end process;

stim_process: process
begin

        distance_raw <= 100;
        calibrate <= '0';
        wait for 10ns;
        distance_raw <= 300;
        calibrate <= '1';
        wait for 10ns;
        distance_raw <= 100;
        calibrate <= '1';
        wait for 10ns;
        distance_raw <= 50;
        calibrate <= '0';
        wait for 10ns;
        distance_raw <= 30;
        calibrate <= '1';
        wait for 10ns;
        distance_raw <= 25;
        calibrate <= '0';
        wait for 10ns;
        wait;

end process;


end Behavioral;
