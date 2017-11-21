LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity debounce_tb is
end debounce_tb;

architecture behavior of debounce_tb is

component debounce
GENERIC(
    counter_size  :  INTEGER := 19); 
  PORT(
    clk     : IN  STD_LOGIC; 
    button  : IN  STD_LOGIC;  
    result  : OUT STD_LOGIC
	);
END component;

signal clk: std_logic;
signal button: std_logic;

signal result: std_logic;

constant clk_period: time := 10 ns;

begin
	
	uut: debounce
	port map( clk => clk,
				button => button,
				result => result
				);
				
	
	clk_process: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	stim_proc: process
	begin
		button <= '0';
		wait for 100 ns;
		button <= '1';
		wait for 100 ns;
		wait;
	end process;
	
end behavior;