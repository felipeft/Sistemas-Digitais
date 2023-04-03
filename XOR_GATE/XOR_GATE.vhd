library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR_GATE is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           x : out STD_LOGIC);
end XOR_GATE;

architecture Behavioral of XOR_GATE is

begin
    x <= a xor b;
end Behavioral;