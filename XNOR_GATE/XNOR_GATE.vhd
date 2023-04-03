library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XNOR_GATE is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           x : out STD_LOGIC);
end XNOR_GATE;

architecture Behavioral of XNOR_GATE is

begin
    x <= a xnor b;
end Behavioral;
