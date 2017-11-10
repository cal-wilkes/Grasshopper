library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity numbers_tb is
end numbers_tb;

architecture behavior of numbers_tb is

	component numbers
	port ( clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
            box_color: in STD_LOGIC_VECTOR(11 downto 0);          
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0);
		  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal scan_line_x: std_logic_vector(10 downto 0) := "00000000001"; -- stay on the same x,y location
signal scan_line_y: std_logic_vector(10 downto 0) := "00000000001";
signal box_color: std_logic_vector(11 downto 0) := "111100001111"; -- don't need to change the color

signal red:   std_logic_vector(3 downto 0);
signal blue:  std_logic_vector(3 downto 0);
signal green: std_logic_vector(3 downto 0);
	
	
 constant clk_period : time := 10 ns;
 
 begin
 
	uut: numbers
	port map( clk => clk,
          reset => reset,
          scan_line_x => scan_line_x,
          scan_line_y => scan_line_y,
          box_color => box_color,
          red => red,
          blue => blue,
          green => green                           
        );
		
		clk_process: process
		begin	
			clk <= '0';
			wait for 100 ns;
			clk <= '1';
			wait for 100 ns;
		end process;
		
		stim_proc: process
		begin
			reset <= '0';
			wait for 100 ns;
			reset <= '1';
			wait for 100 ns;
			reset <= '0';
			wait for 100 ns;
			wait;
		end process;
		
end;