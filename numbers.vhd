library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity numbers is
    Port ( 	clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
            box_color: in STD_LOGIC_VECTOR(11 downto 0);          
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0);
		  );
end numbers;

architecture Behavioral of numbers is

type array_integers is array (0 to 2) of integer;
signal distance : array_integers; -- i get here an error that says <array_integer> is not declared

constant box_width: STD_LOGIC_VECTOR(8 downto 0) := "000100000";
constant box_loc_x_min: std_logic_vector(9 downto 0) := "0000000000";
constant box_loc_y_min: std_logic_vector(9 downto 0) := "0000000000";
signal box_loc_x_max: std_logic_vector(9 downto 0); -- Not constants because these dependant on box_width 
signal box_loc_y_max: std_logic_vector(9 downto 0);
signal pixel_color: std_logic_vector(11 downto 0);
signal box_loc_x, box_loc_y, box_loc_x1, box_loc_x2: std_logic_vector(9 downto 0);
signal vga_blank : std_logic;

begin

box_loc_x1 <= box_loc_x + box_width + box_width + box_width + box_width;
box_loc_x2 <= box_loc_x + box_width + box_width + box_width + box_width + box_width + box_width + box_width + box_width;

tens : process(clk)
begin

if (box_width > "000100000") then
box_width <= "000100000";
end if;

if(distance(2) = 0) then 
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- top of the zero
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										(((scan_line_x = box_loc_x) and (scan_line_x = box_loc_x + box_width + box_width)) and -- second, third and fourth level of the zero
										((scan_line_y = box_loc_y + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width)) and -- bottom of the zero
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(2) = 1) then
		pixel_color <= box_color when ((scan_line_x = box_loc_x) and
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width)))
										
	elsif(distance(2) = 2) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- top level of 2
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x + box_width + box_width + box_width + box_width) and -- second level of 2
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- third level of 2
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x) and -- fourth level of 2
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- bottom level of 2
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(2) = 3) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- top level of 3
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x + box_width + box_width) and -- second level of 3
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- third level of 3
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x + box_width + box_width) and -- fourth level of 3
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + box_width + box_width + box_width)) and -- bottom level of 3
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(2) = 4) then
		pixel_color <= box_color when (((scan_line_x = box_loc_x) or (scan_line_x = box_loc_x + box_width + box_width)) and -- top and second level of 4 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x) and (scan_line_x < box_loc_x + (3 * box_width))) and -- third level of 4
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x + box_width + box_width) and -- fourth and fifth level of 4
										((scan_line_y >= box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width)))
										
	else
		pixel_color <= "111111111111";
	end if;
										
end process;


ones : process(clk)
begin
	
	if(box_width > "000100000") then
		box_width <= "000100000";
	end if;
	
	if(distance(1) = 0) then 
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top of the zero
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										(((scan_line_x = box_loc_x1) and (scan_line_x = box_loc_x1 + box_width + box_width)) and -- second, third and fourth level of the zero
										((scan_line_y = box_loc_y + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width)) and -- bottom of the zero
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(1) = 1) then
		pixel_color <= box_color when ((scan_line_x = box_loc_x1) and
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width)))
										
	elsif(distance(1) = 2) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 2
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width + box_width + box_width) and -- second level of 2
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 2
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1) and -- fourth level of 2
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- bottom level of 2
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(1) = 3) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 3
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width) and -- second level of 3
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 3
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width) and -- fourth level of 3
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- bottom level of 3
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(1) = 4) then
		pixel_color <= box_color when (((scan_line_x = box_loc_x1) or (scan_line_x = box_loc_x1 + box_width + box_width)) and -- top and second level of 4 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 4
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width) and -- fourth and fifth level of 4
										((scan_line_y >= box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width))) 
								
	elsif(distance(1) = 5) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 5
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1) and -- second level of 5
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 5
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width + box_width + box_width) and -- fourth level of 5
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width+ box_width+ box_width)) and -- bottom level of 5
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))


	elsif(distance(1) = 6) then
		pixel_color <= box_color when ((scan_line_x = box_loc_x1) and -- top and second level of 6
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + (3 * box_width))) and --third level of 6
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										(((scan_line_x = box_loc_x1) or (scan_line_x = box_loc_x1 + box_width + box_width)) and -- fourth level of 6
										((scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))

	elsif(distance(1) = 7) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 7
										((scan_line_y = box_loc_y) and (scan_line_x < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1) and -- rest of 7
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
									
	elsif(distance(1) = 8) then 
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top of 8
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										(((scan_line_x = box_loc_x1) and (scan_line_x = box_loc_x1 + box_width + box_width)) and -- second and fourth level of the 8
										((scan_line_y = box_loc_y + box_width) or (scan_line_y = box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width+ box_width+ box_width)) and -- third level of 8
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width)) and -- top of the 8
										((scan_line_y = box_loc_y + box_width+ box_width+ box_width+ box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width+ box_width+ box_width))))
								
	elsif(distance(1) = 9) then
		pixel_color <= box_color when (((scan_line_x >= box_loc_x1) or (scan_line_x < box_loc_x1 + box_width+ box_width)) and -- top level of 9 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width+ box_width)))
										or
										(((scan_line_x = box_loc_x1) or (scan_line_x = box_loc_x1 + box_width+ box_width)) and -- second level of 9 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width+ box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width+ box_width+ box_width)) and -- third level of 9
										((scan_line_y = box_loc_y + box_width+ box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width+ box_width) and -- fourth and fifth level of 9
										((scan_line_y >= box_loc_y + box_width+ box_width+ box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width+ box_width))) 
										
	else
		pixel_color <= "111111111111";
	end if;
	
end process;

tenths : process(clk)
begin
	
	if(box_width > "000100000") then
		box_width <= "000100000";
	end if;
	
	if(distance(0) = 0) then 
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top of the zero
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										(((scan_line_x = box_loc_x1) and (scan_line_x = box_loc_x1 + box_width + box_width)) and -- second, third and fourth level of the zero
										((scan_line_y = box_loc_y + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width)) and -- bottom of the zero
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(0) = 1) then
		pixel_color <= box_color when ((scan_line_x = box_loc_x1) and
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width)))
										
	elsif(distance(0) = 2) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 2
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width + box_width + box_width) and -- second level of 2
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 2
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1) and -- fourth level of 2
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- bottom level of 2
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(0) = 3) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 3
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width) and -- second level of 3
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 3
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width) and -- fourth level of 3
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- bottom level of 3
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
										
	elsif(distance(0) = 4) then
		pixel_color <= box_color when (((scan_line_x = box_loc_x1) or (scan_line_x = box_loc_x1 + box_width + box_width)) and -- top and second level of 4 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 4
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width) and -- fourth and fifth level of 4
										((scan_line_y >= box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width))) 
								
	elsif(distance(0) = 5) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 5
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1) and -- second level of 5
										(scan_line_y = box_loc_y + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- third level of 5
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width + box_width + box_width + box_width) and -- fourth level of 5
										(scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width+ box_width+ box_width)) and -- bottom level of 5
										((scan_line_y = box_loc_y + box_width + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))


	elsif(distance(0) = 6) then
		pixel_color <= box_color when ((scan_line_x = box_loc_x1) and -- top and second level of 6
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + (3 * box_width))) and --third level of 6
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))
										or
										(((scan_line_x = box_loc_x1) or (scan_line_x = box_loc_x1 + box_width + box_width)) and -- fourth level of 6
										((scan_line_y = box_loc_y + box_width + box_width + box_width) and (scan_line_y < box_loc_y + box_width + box_width + box_width)))

	elsif(distance(0) = 7) then
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top level of 7
										((scan_line_y = box_loc_y) and (scan_line_x < box_loc_y + box_width)))
										or
										((scan_line_x = box_loc_x1) and -- rest of 7
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width + box_width + box_width + box_width + box_width))))
									
	elsif(distance(0) = 8) then 
		pixel_color <= box_color when ((((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width + box_width)) and -- top of 8
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width)))
										or
										(((scan_line_x = box_loc_x1) and (scan_line_x = box_loc_x1 + box_width + box_width)) and -- second and fourth level of the 8
										((scan_line_y = box_loc_y + box_width) or (scan_line_y = box_loc_y + box_width + box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width+ box_width+ box_width)) and -- third level of 8
										((scan_line_y = box_loc_y + box_width + box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width + box_width)) and -- top of the 8
										((scan_line_y = box_loc_y + box_width+ box_width+ box_width+ box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width+ box_width+ box_width))))
								
	elsif(distance(0) = 9) then
		pixel_color <= box_color when (((scan_line_x >= box_loc_x1) or (scan_line_x < box_loc_x1 + box_width+ box_width)) and -- top level of 9 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width+ box_width)))
										or
										(((scan_line_x = box_loc_x1) or (scan_line_x = box_loc_x1 + box_width+ box_width)) and -- second level of 9 -- double check
										((scan_line_y >= box_loc_y) and (scan_line_y < box_loc_y + box_width+ box_width)))
										or
										(((scan_line_x >= box_loc_x1) and (scan_line_x < box_loc_x1 + box_width+ box_width+ box_width)) and -- third level of 9
										((scan_line_y = box_loc_y + box_width+ box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width)))
										or
										((scan_line_x = box_loc_x1 + box_width+ box_width) and -- fourth and fifth level of 9
										((scan_line_y >= box_loc_y + box_width+ box_width+ box_width) and (scan_line_y < box_loc_y + box_width+ box_width+ box_width+ box_width))) 
										
	else
		pixel_color <= "111111111111";
	end if;
	
end process;

red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);

box_loc_x_max <= "1010000000" - box_width - 1;
box_loc_y_max <= "0111100000" - box_width - 1;

end Behavioral;