library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_down_counter is
	Generic ( WIDTH: integer:= 6);
	Port (
		up: in STD_LOGIC;
		down: in STD_LOGIC;
		clk: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
        val: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end up_down_counter;

architecture Behavioral of up_down_counter is

signal current_val: std_logic_vector(WIDTH-1 downto 0) := (others => '0');

-- Create a logic vector of proper length filled with zeros (also done during synthesis)
constant zeros: 			std_logic_vector(WIDTH-1 downto 0) := (others => '0');

begin
	Count: process(clk, reset)
	begin
        -- Asynchronous reset
	    if (reset = '1') then
	       current_val <= zeros; -- Set output to 0
		elsif (rising_edge(clk)) then	
			if ((up = '1') and (enable = '1')) then
				current_val <= current_val + '1';
			elsif ((down = '1') and (enable = '1')) then
				current_val <= current_val - '1';
			end if;
		end if;
	end process Count;

val <= current_val;

end Behavioral;