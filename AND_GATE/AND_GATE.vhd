library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_GATE is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           x : out STD_LOGIC);
end AND_GATE;

architecture Behavioral of AND_GATE is

begin
    x <= a and b;
end Behavioral;
