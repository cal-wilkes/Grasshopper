library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity controller_tb is
end controller_tb;


architecture behavior of controller_tb is

component controller is
port( clk: in STD_LOGIC;
                BUTTON: in STD_LOGIC_VECTOR(1 downto 0);
                SWITCH: in STD_LOGIC_VECTOR(2 downto 0);
                COMPARE: in STD_LOGIC;
                CHANGE: in std_logic;
                SAW_PWM: out STD_LOGIC;
                r: out STD_LOGIC_VECTOR(3 downto 0);
                g: out STD_LOGIC_VECTOR(3 downto 0);
                b: out STD_LOGIC_VECTOR(3 downto 0);
                hs : out STD_LOGIC;
                vs : out STD_LOGIC;
                SOLENOID_CONTROL_SIG: out STD_LOGIC   );

end component;



signal clk: std_logic;
signal change: std_logic := '0';
signal button: std_logic_vector(1 downto 0) := "00";
signal switch: std_logic_vector(2 downto 0) := "000";
signal compare: std_logic := '0';

signal saw_pwm: std_logic;
signal r: std_logic_vector(3 downto 0);
signal g: std_logic_vector(3 downto 0);
signal b: std_logic_vector(3 downto 0);
signal hs: std_logic;
signal vs: std_logic;
signal solenoid_control_sig: std_logic;

constant clk_period: time := 10 ns;

begin

	uut: controller 
	port map( clk => clk,
				button => button,
				switch => switch,
				compare => compare,
				change => change,
				saw_pwm => saw_pwm,
				r => r,
				b => b,
				g => g,
				hs => hs,
				vs => vs,
				solenoid_control_sig => solenoid_control_sig
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
		button(0) <= '0';
		wait for 100 ns;
		button(0) <= '1';
		wait for 100 ns;
		button(1) <= '0';
		wait for 100 ns;
		button(1) <= '1';
		wait for 100 ns;
		switch(0) <= '0';
		wait for 100 ns;
		switch(0) <= '1';
		wait for 100 ns;
		switch(1) <= '0';
		wait for 100 ns;
		switch(1) <= '1';
		wait for 100 ns;
		switch(2) <= '0';
		wait for 100 ns;
		switch(2) <= '1';
		wait for 100 ns;
		compare <= '0';
		wait for 100 ns;
		compare <= '1';
		wait for 100 ns;
		change <= '0';
		wait for 100 ns;
		change <= '1';
		wait for 100 ns;
		wait;
	end process;
	
end behavior;
				
