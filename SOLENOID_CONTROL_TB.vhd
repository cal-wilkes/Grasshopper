----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2017 11:40:06 AM
-- Design Name: 
-- Module Name: DISTANCE_DEDUCE_TB - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SOLENOID_CONTROL_TB is
--  Port ( );
end SOLENOID_CONTROL_TB;

architecture Behavioral of SOLENOID_CONTROL_TB is

component SOLENOID_CONTROL is
	        port(   CLK: in std_logic; 
			        RESET: in std_logic;
			        ENABLE: in STD_LOGIC;
			        DISTANCE_X: in INTEGER;
		            LEVEL: in INTEGER;
			        SOLENOID_CONTROL_SIGNAL: out std_logic);


end component;

signal clk, reset, enable, solenoid_control_signal: STD_LOGIC;
signal level, distance_x: INTEGER;


begin

uut: SOLENOID_CONTROL
	port map(   
	           CLK => clk,
               RESET => reset,
               ENABLE => enable,
               DISTANCE_X => distance_x,
               LEVEL => level,
               SOLENOID_CONTROL_SIGNAL => solenoid_control_signal );

clock_process: process
begin

        clk <= '0';
        wait for 5ns;
        clk <= '1';
        wait for 5ns;

end process;

stim_process: process
begin
        RESET <= '0';
        level <= 100;
        distance_x <= 100;
        enable <= '0';
        wait for 10ns;
        distance_x <= 300;
        enable <= '1';
        wait for 10ns;
        distance_x <= 400;
        wait for 10ns;
        distance_x <= 250;
        wait for 10ns;
        distance_x <= 100;
        wait for 10ns;
        distance_x <= 45;
        wait for 10ns;
        wait;

end process;


end Behavioral;
