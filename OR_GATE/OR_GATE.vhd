library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR_GATE is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           x : out STD_LOGIC);
end OR_GATE;

architecture Behavioral of OR_GATE is

begin
    x <= a or b;
end Behavioral;
