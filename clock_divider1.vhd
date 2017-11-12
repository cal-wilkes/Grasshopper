library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable: in STD_LOGIC;
			  kHz: out STD_LOGIC;	  
		   -- added in lab 2:
		   seconds_port: out STD_LOGIC_VECTOR(4-1 downto 0);
		   ten_seconds_port: out STD_LOGIC_VECTOR(3-1 downto 0);
		   minutes_port: out STD_LOGIC_VECTOR(4-1 downto 0);
		   ten_minutes_port: out STD_LOGIC_VECTOR(3-1 downto 0);
		   -- ADDED:
		   twentyfive_MHz: out STD_LOGIC;
		   hHz: out STD_LOGIC
		  );
end clock_divider;

architecture Behavioral of clock_divider is
-- Signals:
signal  i_enable: STD_LOGIC;
signal 	kilohertz: STD_LOGIC;
signal 	hundredhertz: STD_LOGIC;
signal	tenhertz: STD_LOGIC;
signal onehertz: STD_LOGIC;
signal tensec: STD_LOGIC;
signal onemin: STD_LOGIC;
signal tenmin: STD_LOGIC;

signal seconds_value: STD_LOGIC_VECTOR(4-1 downto 0);
signal ten_seconds_value: STD_LOGIC_VECTOR(3-1 downto 0);
signal minutes_value: STD_LOGIC_VECTOR(4-1 downto 0);
signal ten_minutes_value: STD_LOGIC_VECTOR(3-1 downto 0);

-- Components:
-- This is kind of like a function prototype in C/C++
component downcounter is
	Generic ( period: integer:= 4;
				WIDTH: integer:= 3);
		Port ( clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  enable : in  STD_LOGIC;
				  zero : out  STD_LOGIC;
				  value: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end component;
begin

-- ADDED
megaHzClock_25MHz: downcounter
generic map(
				period => (4-1), -- divide by 4
				WIDTH => 2
			)
port map (
				clk => clk,
				reset => reset,
				enable => '1',
				zero => twentyfive_MHz,
				value => open			-- Leave open since we won't display this value
);

kiloHzClock: downcounter
generic map(
				period => (100000-1), -- "1 1000 0110 1010 0000" in binary
				WIDTH => 17
			)
port map (
				clk => clk,
				reset => reset,
				enable => '1',
				zero => kilohertz,
				value => open			-- Leave open since we won't display this value
);

hundredHzClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => i_enable,
				zero => hundredhertz,
				value => open			-- Leave open since we won't display this value
);

tenHzClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => hundredhertz,
				zero => tenhertz,
				value => open			-- Leave open since we won't display this value
);

oneHzClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => tenhertz,
				zero => onehertz,
				value => open			-- Leave open since we won't display this value
);

singleSecondsClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => onehertz,
				zero => tensec,
				value => seconds_value			
);

tensSecondsClock: downcounter
generic map(
				period => (6-1),	-- Counts numbers between 0 and 5 -> that's 6 values!
				WIDTH => 3
			)
port map (
				clk => clk,
				reset => reset,
				enable => tensec,
				zero => onemin,
				value => ten_seconds_value			
);

singleMinutesClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => onemin,
				zero => tenmin,
				value => minutes_value			
);

tensMinutesClock: downcounter
generic map(
				period => (6-1),	-- Counts numbers between 0 and 5 -> that's 6 values!
				WIDTH => 3
			)
port map (
				clk => clk,
				reset => reset,
				enable => tenmin,
				zero => open,
				value => ten_minutes_value			
);

i_enable <= kilohertz and enable;

-- Connect internal signals to outputs
kHz <= kilohertz;

-- added in lab 2:
seconds_port <= seconds_value;
ten_seconds_port <= ten_seconds_value;
minutes_port <= minutes_value;
ten_minutes_port <= ten_minutes_value;

-- ADDED:
hHz <= hundredhertz;

end Behavioral;