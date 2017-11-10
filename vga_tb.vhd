library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_tb is
end vga_tb;

architecture behavior of vga_tb is

	component vga_tb
	port ( clk : in  STD_LOGIC;
            red: out STD_LOGIC_VECTOR(3 downto 0);
            green: out STD_LOGIC_VECTOR(3 downto 0);
            blue: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC
         );
    END COMPONENT;
	
	signal clk: std_logic;
	signal red: std_logic_vector(3 downto 0);
	signal green: std_logic_vector(3 downto 0);
	signal blue: std_logic_vector(3 downto 0);
	signal hsync: std_logic;
	signal vsync: std_logic;
	
	constant clk_period : time := 10 ns;
	
	begin
	
		
		uut: vga 
		port map( clk => clk,
            red => red,
            green => green,
            blue => blue,
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
		
end;