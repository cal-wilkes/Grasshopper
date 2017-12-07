library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECODER is
     Port ( 
                signal amp: in integer;
                signal MEAS: out integer   
     );
end DECODER;

architecture Behavioral of DECODER is

begin

meas <= amp;

end Behavioral;
