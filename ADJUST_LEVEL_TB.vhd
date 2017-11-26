library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADJUST_LEVEL_TB is

end ADJUST_LEVEL_TB;

architecture Behavioral of ADJUST_LEVEL_TB is

component ADJUST_LEVEL is
  Port (
        CLK: in STD_LOGIC;
        RESET: in STD_LOGIC;
        LEVEL_SWITCH: in STD_LOGIC_VECTOR(1 downto 0);
		sam: out integer;
        LEVEL: out INTEGER  );

end component;

signal clk, reset: STD_LOGIC;
signal level: INTEGER;
signal sam: integer:= 0;
signal level_switch: STD_LOGIC_VECTOR(1 downto 0);


begin

uut: ADJUST_LEVEL
	port map(   
	           CLK => clk,
               RESET => reset,
               LEVEL_SWITCH => level_switch,
               LEVEL => LEVEL,
               sam => sam
    
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
