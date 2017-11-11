library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lookup is
	port (  clk: in std_logic;
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
end lookup;


architecture behavioral of lookup is

type matrix is array(0 to 13, 0 to 17) of std_logic;
--type vec is array (13 downto 0) of std_logic;
--type matrix is array(17 downto 0) of vec;

signal pixel_colour: std_logic_vector(11 downto 0);

signal i_ones: matrix;
signal i_tens: matrix;
signal i_tenths: matrix;

signal draw: matrix; -- the number thats being drawn
constant size: integer:= 3;
signal counter: integer := size;				   

-- to access the various matrices for each number							   		
signal index_x: integer := 0;
signal x_counter: integer:= 0;
signal y_counter: integer:= 0;

signal box_loc_x: integer:= 0;
signal box_loc_y: integer := 0;							   							
							   
signal nine: matrix:= 	   (('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0'),	
							('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0'),
							('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0'),
							('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'));
							   
signal eight: matrix:= 		(
								('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0'),	
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0')
								);
								
signal seven: matrix:= 		(
								('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),		
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','1','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0')
								);
								
signal six: matrix:= 		  (
							  ('0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0'),	
							  ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0')
							  );
							  
signal five: matrix:= 	   (
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),		
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0'),
							   ('0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0'),
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0')
							   );
							   
signal four: matrix:= 	   (
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),	
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','1','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','1','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							   ('0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0')
							    );	
							   
signal three: matrix:= 		(
								('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),	
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							    ('0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0')
								);	
								
signal two: matrix:= 		  (
							  ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),	
							  ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							  ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0')
							   );	
							  
signal one: matrix:= 		  (
							  ('0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0'),		
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0'),
							  ('0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0')
							   );
							  
signal zero: matrix:= 	   (
							   ('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0'),		
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','0','0','0','0','0','1','1','0','0','0','0','0'),
							   ('0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0'),
							   ('0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0')
							   );							   
begin						
							   
pixel: process(scan_line_x, scan_line_y)
begin
	-- need some way to take the numbers and feed those values into i_tens, i_ones, i_tenths, maybe with a case statement
	-- needs to take tens, ones, tenths (the inputs) and find a way to feed them into i_tens, i_ones, i_tenths and fills in those matrices with the lookup table values
	-- the rest should be handled with the display
	if(tens = '0')then
		i_tens <= zero;
	elsif(tens = '1')then
		i_tens <= one;
	elsif(tens = '2')then
		i_tens <= two;
	elsif(tens = '3')then
		i_tens <= three;
	elsif(tens = '4')then
		i_tens <= four;
	elsif(tens = '5')then
		i_tens <= five;
	elsif(tens = '6')then
		i_tens <= six;
	elsif(tens = '7')then
		i_tens <= seven;		
	elsif(tens = '8')then
		i_tens <= eigth;
	else
		i_tens <= nine;
	end if;
	
	if(ones = '0')then
		i_ones <= zero;
	elsif(ones = '1')then
		i_ones <= one;
	elsif(ones = '2')then
		i_ones <= two;
	elsif(ones = '3')then
		i_ones <= three;
	elsif(ones = '4')then
		i_ones <= four;
	elsif(ones = '5')then
		i_ones <= five;
	elsif(ones = '6')then
		i_ones <= six;
	elsif(ones = '7')then
		i_ones <= seven;		
	elsif(ones = '8')then
		i_ones <= eigth;
	else
		i_ones <= nine;
	end if;
	
	if(tenths = '0')then
		i_tenths <= zero;
	elsif(tenths = '1')then
		i_tenths <= one;
	elsif(tenths = '2')then
		i_tenths <= two;
	elsif(tenths = '3')then
		i_tenths <= three;
	elsif(tenths = '4')then
		i_tenths <= four;
	elsif(tenths = '5')then
		i_tenths <= five;
	elsif(tenths = '6')then
		i_tenths <= six;
	elsif(tenths = '7')then
		i_tenths <= seven;		
	elsif(tenths = '8')then
		i_tenths <= eigth;
	else
		i_tenths <= nine;
	end if;
	
	
	--getting the first digit		
	if(reset = '1') then
	   x_counter <= 0;
	   y_counter <= 0;
	   counter <= 0;
	   
	else -- total width is at 480 for now
        if(scan_line_x < "00111100000") then
            x_counter <= x_counter + 1;
        -- less than the width
            if(counter = size - 1) then
                    counter <= 0;
                    index_x <= index_x+1;
                else
                    counter <= counter + 1;
            end if;
            
        else
            -- if scan_line_x equals total width then increment y_counter
            x_counter <= 0;
            index_x <= 0;
            counter <= 0;
            if(scan_line_y < "1010000000") then 
                y_counter <= y_counter + 1;
            else
                y_counter <= 0;
            end if;
        end if;
        
        --reset the index_x after going to next digit
        if(x_counter = box_loc_x + (34*size) - 1) then
               index_x <= 0;
        elsif(x_counter = box_loc_x) then
              index_x <= 0;
        elsif(x_counter = box_loc_x + (17*size) - 1) then
              index_x <= 0;
        elsif(x_counter = box_loc_x + (51*size) - 1) then
              index_x <= 0;  
        elsif(x_counter = box_loc_x + (68*size) - 1) then
              index_x <= 0;
        elsif(x_counter = box_loc_x + (85*size) - 1) then
              index_x <= 0;
        elsif(x_counter >= (box_loc_x + (102 * size) - 1)) then
              index_x <= 0;
        end if;
        
        --first digit
        if(x_counter >= box_loc_x and x_counter < (box_loc_x + (17* size))) then
            draw <= i_tens;
        
        --second digit
        elsif(x_counter >= (box_loc_x + (17*size)) and x_counter < (box_loc_x + (34* size))) then
            draw <= i_ones;

        -- third digit      
        elsif(x_counter >= (box_loc_x + (51*size)) and x_counter < (box_loc_x + (68* size))) then
            draw <= i_tenths;				
		end if;
		
		end if;
		
red <= pixel_colour(11 downto 8);
green <= pixel_colour(7 downto 4);
blue <= pixel_colour(3 downto 0);
			
end process;


end behavioral;