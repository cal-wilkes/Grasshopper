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

entity DISTANCE_DEDUCE_TB is
--  Port ( );
end DISTANCE_DEDUCE_TB;

architecture Behavioral of DISTANCE_DEDUCE_TB is

component DISTANCE_DEDUCER is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       COMPARE: in STD_LOGIC;
	       REF:  in INTEGER;
	       MEAS: in INTEGER;
	       DISTANCE_D: out INTEGER;
	       DISTANCE_X: out INTEGER   );

end component;

signal clk, reset, compare: STD_LOGIC;
signal ref, meas, distance_d, distance_x: INTEGER;


begin

uut: DISTANCE_DEDUCER 
	port map(   
	           CLK => clk,
	           RESET => reset,
	           COMPARE => compare, 
	           REF => ref,
	           MEAS => meas,
	           DISTANCE_D => distance_d,
	           DISTANCE_X => distance_x );
	           

clock_process: process
begin

        clk <= '0';
        wait for 5ns;
        clk <= '1';
        wait for 5ns;

end process;

stim_process: process
begin

        meas <= 100;
        ref <= 20;
        compare <= '0';
        wait for 10ns;
        meas <= 300;
        ref <= 20;
        compare <= '1';
        wait for 10ns;
        meas <= 100;
        ref <= 40;
        compare <= '1';
        wait for 10ns;
        meas <= 50;
        ref <= 40;
        compare <= '0';
        wait for 10ns;
        meas <= 300;
        ref <= 40;
        compare <= '1';
        wait for 10ns;
        meas <= 25;
        ref <= 20;
        compare <= '0';
        wait for 10ns;
        wait;

end process;


end Behavioral;
