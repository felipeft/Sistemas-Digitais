library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SIMPLE_LATCH is
    Port ( s : in STD_LOGIC;
           r : in STD_LOGIC;
           q : out STD_LOGIC);
end SIMPLE_LATCH;

architecture Behavioral of SIMPLE_LATCH is
    signal dat : std_logic;
begin
    dat <= s when(r = '1') else dat;
    q <= dat;

end Behavioral;
