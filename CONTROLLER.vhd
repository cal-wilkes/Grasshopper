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
                clk: in STD_LOGIC;
                BUTTON: in STD_LOGIC_VECTOR(1 downto 0);
                SWITCH: in STD_LOGIC_VECTOR(2 downto 0);
                COMPARE: in STD_LOGIC;
                SAW_PWM: out STD_LOGIC;
                CHANGE: in std_logic;
                r: out STD_LOGIC_VECTOR(3 downto 0);
                g: out STD_LOGIC_VECTOR(3 downto 0);
                b: out STD_LOGIC_VECTOR(3 downto 0);
                hs : out STD_LOGIC;
                vs : out STD_LOGIC;
                SOLENOID_CONTROL_SIG: out STD_LOGIC   );

end CONTROLLER;

architecture Behavioral of CONTROLLER is

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
                sam: out integer;
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
	       CHANGE: in STD_LOGIC;
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
	          ENABLE: in std_logic;
			reset: in std_logic;
			sam: in INTEGER;
			MEAS: out INTEGER;
			SAW_PWM: out std_logic);
end component;


-- ADD VGA CONTROLLER MODULE




signal D_BUTTON, LEVEL_SWITCHES: STD_LOGIC_VECTOR(1 downto 0);
signal D_SWITCH: STD_LOGIC_VECTOR(2 downto 0);
signal RESET, ENABLE, CALIBRATER: STD_LOGIC;
signal DISTANCE_X, LEVEL, ref, DISTANCE_RAW, meas, meas_1, DISTANCE_D, one, ten, tenth, i_sam: INTEGER;



begin

RESET <= D_BUTTON(0);
LEVEL_SWITCHES <= D_SWITCH(1 downto 0);
ENABLE <= D_SWITCH(2);
CALIBRATER <= D_BUTTON(1);

VGA: vga_module 
    Port Map (   clk => clk,
           reset => reset,
           P_1 => one,
           P_2 => ten,
           P_3 => tenth,
           red => r,
           green => g,
           blue => b,
           hsync => hs,
           vsync => vs
	 );
	 

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
			  DISTANCE_RAW => DISTANCE_RAW,
		      LEVEL => LEVEL,
			  SOLENOID_CONTROL_SIGNAL => SOLENOID_CONTROL_SIG     
			  
		);


AL: ADJUST_LEVEL 
		Port MAP(
				CLK => CLK,
				RESET => RESET,
                LEVEL_SWITCH => LEVEL_SWITCHES,
                sam => i_sam,
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
	           CHANGE => CHANGE,
	           REF => ref, 
	           MEAS => meas,
	           DISTANCE_RAW => DISTANCE_RAW,
	          DISTANCE_ONES => one,
               DISTANCE_TENS => ten,
               DISTANCE_TENTHS => tenth
	         --  DISTANCE_D => DISTANCE_D,
	        --   DISTANCE_X => DISTANCE_X
	        );
	       



SWG: SAWTOOTH_WAVE_GENERATOR 
	port map(   
	           clk => CLK,
	           enable => enable,
			   reset => reset,
			   sam => i_sam,
			 MEAS => meas,
			   SAW_PWM => SAW_PWM	   
			 );

-- INSTANTIATE THE VGA CONTROL MODULE AND ADD ANY NECESSARY INTERNAL AND EXTERNAL SIGNALS



--meas <= meas_1;

end Behavioral;
