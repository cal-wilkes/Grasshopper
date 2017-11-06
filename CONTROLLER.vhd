----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2017 03:57:29 PM
-- Design Name: 
-- Module Name: CONTROLLER - Behavioral
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

entity CONTROLLER is
        PORT(
                CLK: in STD_LOGIC;
                BUTTON: in STD_LOGIC_VECTOR(1 downto 0);
                SWITCH: in STD_LOGIC_VECTOR(2 downto 0);
                COMPARE: in STD_LOGIC;
                SAW_PWM: out STD_LOGIC;
                SOLENOID_CONTROL_SIG: out STD_LOGIC   );

end CONTROLLER;

architecture Behavioral of CONTROLLER is


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
			DISTANCE_X: in INTEGER;
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
	       DISTANCE_D: out INTEGER;
	       DISTANCE_X: out INTEGER   );
	       
end component;



component SAWTOOTH_WAVE_GENERATOR is
	port(   clk: in std_logic; 
			reset: in std_logic;
			SAW_PWM: out std_logic);
end component;


-- ADD VGA CONTROLLER MODULE




signal D_BUTTON, LEVEL_SWITCHES: STD_LOGIC_VECTOR(1 downto 0);
signal D_SWITCH: STD_LOGIC_VECTOR(2 downto 0);
signal RESET, ENABLE, CALIBRATER: STD_LOGIC;
signal DISTANCE_X, LEVEL, ref, DISTANCE_RAW, meas, DISTANCE_D: INTEGER;


begin

RESET <= D_BUTTON(0);
LEVEL_SWITCHES <= D_SWITCH(1 downto 0);
ENABLE <= D_SWITCH(2);
CALIBRATER <= D_BUTTON(1);

MD: multi_debounce 
  PORT MAP(
            clk =>  CLK,
            buttons => BUTTON,
	        switches => SWITCH,
	        d_buttons => D_BUTTON, 
	        d_switches => D_SWITCH
	);



SC:SOLENOID_CONTROL 
	port map(   
	          CLK => CLK,
			  RESET => RESET,
			  ENABLE => ENABLE,
			  DISTANCE_X => DISTANCE_X,
		      LEVEL => LEVEL,
			  SOLENOID_CONTROL_SIGNAL => SOLENOID_CONTROL_SIG     
			  
		);


AL: ADJUST_LEVEL 
		Port MAP(
				CLK => CLK,
				RESET => RESET,
                LEVEL_SWITCH => LEVEL_SWITCHES,
                LEVEL => LEVEL
              );



CAL: CALIBRATION 
	port map(   
	            CLK => CLK, 
	            RESET => RESET, 
	            CALIBRATE => CALIBRATER,
	            DISTANCE_RAW => DISTANCE_RAW,
	            REF => ref
	         );
	       

DD: DISTANCE_DEDUCER 
	port map(   
	           CLK => CLK,
	           RESET => RESET,
	           COMPARE => COMPARE,
	           REF => ref, 
	           MEAS => meas,
	           DISTANCE_RAW => DISTANCE_RAW,
	           DISTANCE_D => DISTANCE_D,
	           DISTANCE_X => DISTANCE_X
	        );
	       



SWG: SAWTOOTH_WAVE_GENERATOR 
	port map(   
	           clk => CLK,
			   reset => reset,
			   SAW_PWM => SAW_PWM	   
			 );

-- INSTANTIATE THE VGA CONTROL MODULE AND ADD ANY NECESSARY INTERNAL AND EXTERNAL SIGNALS




end Behavioral;
