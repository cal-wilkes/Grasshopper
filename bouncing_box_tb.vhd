library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bouncing_box_tb is
end bouncing_box_tb;

architecture behavior of bouncing_box_tb is

    component bouncing_box
        port( clk: in std_logic;
                reset: in std_logic;
                scan_line_x: in std_logic_vector(10 downto 0);
                scan_line_y: in std_logic_vector(10 downto 0);
                ones: in integer;
                tens: in integer;
                tenths: in integer;
                kHz: in std_logic;
                red: out std_logic_vector(3 downto 0);
                blue: out std_logic_vector(3 downto 0);
                green: out std_logic_vector(3 downto 0)
                );
     end component;



    signal clk: std_logic;
    signal reset: std_logic;
    signal scan_line_x: std_logic_vector(10 downto 0):= "00000000001";
    signal scan_line_y: std_logic_vector(10 downto 0):= "00000000001";
    signal kHz: std_logic;
    signal ones: integer:= 0;
    signal tens: integer:= 0;
    signal tenths: integer:= 0;
    
    signal red: std_logic_vector(3 downto 0);
    signal blue: std_logic_vector(3 downto 0);
    signal green: std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;
   
begin

    uut: bouncing_box
        port map( clk => clk,
                    reset => reset,
                    scan_line_x => scan_line_x,
                    scan_line_y => scan_line_y,
                    ones => ones,
                    tens => tens,
                    tenths => tenths,
                    kHz => kHz,
                    red => red,
                    blue => blue,
                    green => green
                    );
                    
    clk_process: process
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process;
    
    
    kHz_process: process
    begin
        kHz <= '1';
        wait for clk_period;
        kHz <= '0';
        wait for clk_period;
    end process; 
    
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
	   
end behavior;
