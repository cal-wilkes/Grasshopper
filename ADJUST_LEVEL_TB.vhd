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

entity ADJUST_LEVEL_TB is
--  Port ( );
end ADJUST_LEVEL_TB;

architecture Behavioral of ADJUST_LEVEL_TB is

component ADJUST_LEVEL is
  Port (
        CLK: in STD_LOGIC;
        RESET: in STD_LOGIC;
        LEVEL_SWITCH: in STD_LOGIC_VECTOR(1 downto 0);
        LEVEL: out INTEGER  );

end component;

signal clk, reset: STD_LOGIC;
signal level: INTEGER;
signal level_switch: STD_LOGIC_VECTOR(1 downto 0);


begin

uut: ADJUST_LEVEL
	port map(   
	           CLK => clk,
               RESET => reset,
               LEVEL_SWITCH => level_switch,
               LEVEL => LEVEL
                 );

clock_process: process
begin

        clk <= '0';
        wait for 5ns;
        clk <= '1';
        wait for 5ns;

end process;

stim_process: process
begin
        reset <= '0';
        level_switch(0) <= '0';
        level_switch(1) <= '0';
        wait for 10ns;
        level_switch(0) <= '1';
        level_switch(1) <= '0';
        wait for 10ns;
        level_switch(0) <= '0';
        level_switch(1) <= '1';
        wait for 10ns;
        level_switch(0) <= '1';
        level_switch(1) <= '1';
        wait for 10ns;
        level_switch(0) <= '0';
        level_switch(1) <= '0';
        wait for 10ns;
        level_switch(0) <= '1';
        level_switch(1) <= '0';
        wait for 10ns;
        wait;

end process;


end Behavioral;
