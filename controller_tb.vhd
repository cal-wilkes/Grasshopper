library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity of controller_tb is
end controller_tb;


architecture behavior of controller_tb is

component controller
port( clk: in STD_LOGIC;
                BUTTON: in STD_LOGIC_VECTOR(1 downto 0);
                SWITCH: in STD_LOGIC_VECTOR(2 downto 0);
                COMPARE: in STD_LOGIC;
                SAW_PWM: out STD_LOGIC;
                r: out STD_LOGIC_VECTOR(3 downto 0);
                g: out STD_LOGIC_VECTOR(3 downto 0);
                b: out STD_LOGIC_VECTOR(3 downto 0);
                hs : out STD_LOGIC;
                vs : out STD_LOGIC;
                SOLENOID_CONTROL_SIG: out STD_LOGIC   );

end component;

component vga_module is
    Port (   clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           P_1: in integer;
           P_2: in integer;
           P_3: in integer;
           red: out STD_LOGIC_VECTOR(3 downto 0);
           green: out STD_LOGIC_VECTOR(3 downto 0);
           blue: out STD_LOGIC_VECTOR(3 downto 0);
           hsync: out STD_LOGIC;
           vsync: out STD_LOGIC
	 );
	 
end component;



component multi_debounce IS
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    buttons  : IN  STD_LOGIC_VECTOR (1 downto 0);  --input signal to be debounced
	switches : in std_logic_vector (2 downto 0);
	d_buttons : out std_logic_vector (1 downto 0);
	d_switches : out std_logic_vector (2 downto 0)
	);
END component;


component SOLENOID_CONTROL is
	port(   CLK: in std_logic; 
			RESET: in std_logic;
			ENABLE: in STD_LOGIC;
			DISTANCE_RAW: in INTEGER;
		    LEVEL: in INTEGER;
			SOLENOID_CONTROL_SIGNAL: out std_logic);
end component;


component ADJUST_LEVEL is
		Port (
				CLK: in STD_LOGIC;
				RESET: in STD_LOGIC;
                LEVEL_SWITCH: in STD_LOGIC_VECTOR(1 downto 0);
                LEVEL: out INTEGER  );
end component;


component CALIBRATION is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       CALIBRATE: in STD_LOGIC;
	       DISTANCE_RAW:  in INTEGER;
	       REF: out INTEGER   );
	       
end component;

component DISTANCE_DEDUCER is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       COMPARE: in STD_LOGIC;
	       REF:  in INTEGER;
	       MEAS: in INTEGER;
	       DISTANCE_RAW: out INTEGER;
	       DISTANCE_ONES: out INTEGER;
           DISTANCE_TENS: out INTEGER;
           DISTANCE_TENTHS: out INTEGER --;
	   --    DISTANCE_D: out INTEGER;
	     --  DISTANCE_X: out INTEGER  
	      );
	       
end component;



component SAWTOOTH_WAVE_GENERATOR is
	port(   clk: in std_logic; 
			reset: in std_logic;
			MEAS: out INTEGER;
			SAW_PWM: out std_logic);
end component;

signal clk: std_logic;
signal button: std_logic_vector(1 downto 0);
signal switch: std_logic_vector(2 downto 0);
signal compare: std_logic;

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
		wait;
	end process;
	
end behavior;
				
