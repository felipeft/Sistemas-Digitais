library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NAND_GATE is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           x : out STD_LOGIC);
end NAND_GATE;

architecture Behavioral of NAND_GATE is

begin
    x <= a nand b;
end Behavioral;