
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SAWTOOTH_WAVE_GENERATOR_TB is
end SAWTOOTH_WAVE_GENERATOR_TB;

architecture behaviour of SAWTOOTH_WAVE_GENERATOR_TB is

component SAWTOOTH_WAVE_GENERATOR is
	port(   CLK: in std_logic;
			RESET: in std_logic;
			SAW_PWM: out std_logic   );
end component;


signal clk, reset, saw_pwm: STD_LOGIC;



constant clk_period : time := 10 ns;


begin

	uut: SAWTOOTH_WAVE_GENERATOR 
		port map (
					clk => clk,
					reset => reset,
					SAW_PWM => saw_pwm	);
					
					
clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 
   
   
stim_proc : process
	begin
	
	reset <= '0';
    wait for 100 ns;    
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    wait;
	
end process;

end behaviour;