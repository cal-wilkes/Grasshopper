library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_stripes_dff is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           next_pixel : in  STD_LOGIC;
		   mode: in STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (3 downto 0);
           G : out  STD_LOGIC_VECTOR (3 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0));
end vga_stripes_dff;

architecture Behavioral of vga_stripes_dff is

type colors is (WHITE, YELLOW, CYAN, GREEN, MAGENTA, RED, BLUE, BLACK);
signal colorstate: colors;
signal count_pixels : integer;
-- This supports the number of states:
signal q, d: STD_LOGIC_VECTOR(7 downto 0);

begin
	-- Count pixels
	PixelCount: process(pixel_clk, reset)
	begin
	    if (reset = '1') then
            count_pixels <= 0;
            -- Enter reset state of your FSM here (this only affects Q, not D).
            -- ADDED:
            q <= "00000001";
		elsif (rising_edge(pixel_clk)) then
			if (next_pixel = '1') then
				if (count_pixels < 79) then -- This value determines the stripe width
					count_pixels <= count_pixels + 1;
				else 
					count_pixels <= 0;
					-- We need to transition to the next state.
					-- So all the DFFs need to propogate their input to their output
					-- ADDED:
					q <= d;
				end if;
			end if;
		end if;
	end process PixelCount;

	-- Connect DFF input logic here (what determines d(0) for example):
	-- Refer to the table which you should have created in the prelab
	-- ADDED:
    d(0) <= q(7);
    d(1) <= q(0);
    d(2) <= q(1);
    d(3) <= q(2);
    d(4) <= q(3);
    d(5) <= (q(4) and (not mode)) or (q(6) and mode);
    d(6) <= (q(5) and (not mode)) or (q(4) and mode);
    d(7) <= (q(6) and (not mode)) or (q(5) and mode);
	
	
	-- Convert states to a color
	StatesDecode: process(q) begin
		case q is
			when "00000001" => colorstate <= WHITE;
            when "00000010" => colorstate <= YELLOW;
            -- Some other decodes here
            --ADDED:
            when "00000100" => colorstate <= CYAN;
            when "00001000" => colorstate <= GREEN;
            when "00010000" => colorstate <= MAGENTA;
            when "00100000" => colorstate <= RED;
            when "01000000" => colorstate <= BLUE;
            when "10000000" => colorstate <= BLACK;
            -- end ADDED
			when others => colorstate <= BLACK;
		end case;
	end process StatesDecode;

	-- Convert names to actual values
	ColorDecode: process(colorstate) begin
		case colorstate is
			when WHITE => 	R <= "1111"; G <= "1111"; B <= "1111";
			when YELLOW =>  R <= "1111"; G <= "1111"; B <= "0000";
			when CYAN => 	R <= "0000"; G <= "1111"; B <= "1111";
			when GREEN => 	R <= "0000"; G <= "1111"; B <= "0000";
			when MAGENTA=>  R <= "1111"; G <= "0000"; B <= "1111";
			when RED => 	R <= "1111"; G <= "0000"; B <= "0000";
			when BLUE => 	R <= "0000"; G <= "0000"; B <= "1111";
			when BLACK => 	R <= "0000"; G <= "0000"; B <= "0000";
		end case;
	end process ColorDecode;


end Behavioral;

