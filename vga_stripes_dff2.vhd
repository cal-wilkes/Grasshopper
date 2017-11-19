library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_stripes_dff2 is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           next_pixel : in  STD_LOGIC;
		   mode: in STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (3 downto 0);
           G : out  STD_LOGIC_VECTOR (3 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0));
end vga_stripes_dff2;

architecture Behavioral of vga_stripes_dff2 is

  type colors is (WHITE, YELLOW, CYAN, GREEN, MAGENTA, RED, BLUE, BLACK);
  signal colorstate: colors;
  signal count_pixels : integer;
  -- This supports the number of states:
  --signal q, d: STD_LOGIC_VECTOR(7 downto 0);
    
  type StateType is (S0,S1,S2,S3,S4,S5,S6,S7);
  signal CurrentState,NextState: StateType;

begin
  
  COMB: process(mode,CurrentState)
    begin
      case CurrentState is
        when S0 =>
          colorstate <= WHITE;
          NextState <= S1;
        when S1 =>
          colorstate <= YELLOW;
          NextState <= S2;
        when S2 =>
          colorstate <= CYAN;
          NextState <= S3;
        when S3 =>
          colorstate <= GREEN;
          NextState <= S4;
        when S4 =>
          colorstate <= MAGENTA;
          if (mode = '0') then
            NextState <= S5;
          else
            NextState <= S6;
          end if;
        when S5 =>
          colorstate <= RED;
          if (mode = '0') then
            NextState <= S6;
          else
            NextState <= S7;
          end if;
        when S6 =>
          colorstate <= BLUE;
          if (mode = '0') then
            NextState <= S7;
          else
            NextState <= S5;
          end if;            
        when S7 =>
          colorstate <= BLACK;
          NextState <= S0;
        when others =>
          colorstate <= WHITE;
          NextState <= S0; 
      end case;
    end process COMB;
        
  SEQ: process(pixel_clk, reset)
    begin
      if(reset = '1') then
        count_pixels <= 0;
        CurrentState <= S0;
      elsif rising_edge(pixel_clk) then
  			if (next_pixel = '1') then
  				if (count_pixels < 79) then -- This value determines the stripe width
  					count_pixels <= count_pixels + 1;
  				else -- count_pixels is 80
  					count_pixels <= 0;
  					CurrentState <= NextState; -- changes state every 80 pixel
  				end if;
  			end if;
      end if;
    end process SEQ;
    
--  SEQ: process(pixel_clk, reset)
--    begin
--      if(reset = '1') then
--        CurrentState <= S0;
--      elsif rising_edge(pixel_clk) then
--        CurrentState <= NextState;
--      end if;
--    end process SEQ;    
    
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

