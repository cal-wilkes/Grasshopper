library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lookup_tb is
end lookup_tb;

architecture behaviour of lookup_tb is

	component lookup_tb
		port( clk: in std_logic;
				reset: in std_logic;
				ones: in integer;
				tens: in integer;
				tenths: in integer;
				scan_line_x: in std_logic_vector(10 downto 0);
				scan_line_y: in std_logic_vector(10 downto 0);
				colour: in std_logic_vector(11 downto 0);
				tablevalue: in std_logic_vector(8 downto 0);
				red: out std_logic_vector(3 downto 0);
				blue: out std_logic_vector(3 downto 0);
				green: out std_logic_vector(3 downto 0)
			);
	end component;
	
	constant clk_period : time := 10 ns;
	signal clk: std_logic := '0';
	signal reset: std_logic "= '0';
	
	signal scan_line_x: std_logic_vector(10 downto 0) := "00000000000";
	signal scan_line_y: std_logic_vector(10 downto 0) := "00000000000";
	signal colour: std_logic_vector(11 downto 0) := "000000000000";
	signal tablevalue: in std_logic_vector(8 downto 0);
	signal ones: integer:= 0;
	signal tens: integer:= 0;
	signal tenths: integer:= 0;
	
	signal red: std_logic_vector(3 downto 0);
	signal blue: std_logic_vector(3 downto 0);
	signal green: std_logic_vector(3 downto 0);
	
	begin
	
	uut: lookup
		port map( clk => clk,
					reset => reset,
					scan_line_x => scan_line_x,
					scan_line_y => scan_line_y,
					colour => colour,
					tablevalue => tablevalue,
					red => red,
					blue => blue,
					green => green
					);
					
	clk_process: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end;
	
	stim_proc: process
	begin
		reset <= '0';
		wait for 100 ns;
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		wait for 100 ns;
		
		ones <= 0;
		wait for 100 ns;
		ones <= 1;
		wait for 100 ns;
		ones <= 2;
		wait for 100 ns;
		ones <= 3;
		wait for 100 ns;
		ones <= 4;
		wait for 100 ns;
		ones <= 5;
		wait for 100 ns;
		ones <= 6;
		wait for 100 ns;
		ones <= 7;
		wait for 100 ns;
		ones <= 8;
		wait for 100 ns;
		ones <= 9;
		wait for 100 ns;
		
		tens <= 0;
		wait for 100 ns;
		tens <= 1;
		wait for 100 ns;
		tens <= 2;
		wait for 100 ns;
		tens <= 3;
		wait for 100 ns;
		tens <= 4;
		wait for 100 ns;
		tens <= 5;
		wait for 100 ns;
		tens <= 6;
		wait for 100 ns;
		tens <= 7;
		wait for 100 ns;
		tens <= 8;
		wait for 100 ns;
		tens <= 9;
		wait for 100 ns;
		
		tenths <= 0;
		wait for 100 ns;
		tenths <= 1;
		wait for 100 ns;
		tenths <= 2;
		wait for 100 ns;
		tenths <= 3;
		wait for 100 ns;
		tenths <= 4;
		wait for 100 ns;
		tenths <= 5;
		wait for 100 ns;
		tenths <= 6;
		wait for 100 ns;
		tenths <= 7;
		wait for 100 ns;
		tenths <= 8;
		wait for 100 ns;
		tenths <= 9;
		wait for 100 ns;
		wait;
	end process;