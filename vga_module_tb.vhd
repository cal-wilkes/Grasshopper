library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_module_tb is
end vga_module_tb;

architecture behavior of vga_module_tb is

component (  clk : in  STD_LOGIC;
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

signal clk, reset, hsync, vsync: std_logic;
signal P_1,P_2,P_3: integer;
signal red, blue, green: std_logic_vector(3 downto 0);

constant clk_period: time := 10 ns;

begin

	uut: vga_module
		port map( clk => clk,
					reset => reset,
					P_1 => P_1,
					P_2 => P_2,
					P_3 => P_3,
					red => red,
					blue => blue,
					green => green,
					hsync => hsync,
					vsync => vsync
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
		reset <= '0';
		wait for 100 ns;
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		wait for 100 ns;
		P_1 < = 0;
		wait for 100 ns;
		P_1 < = 1;
		wait for 100 ns;
		P_1 < = 2;
		wait for 100 ns;
		P_2 < = 0;
		wait for 100 ns;
		P_2 < = 1;
		wait for 100 ns;
		P_2 < = 2;
		wait for 100 ns;
		P_3 < = 0;
		wait for 100 ns;
		P_3 < = 1;
		wait for 100 ns;
		P_3 < = 2;
		wait for 100 ns;
		wait;
	end process;
	
end behavior;