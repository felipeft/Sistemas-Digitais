library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COMPARADOR_DE_4_BITS is
    port (
        a, b : in std_logic_vector(3 downto 0);
        gt, eq, lt : out std_logic);
end COMPARADOR_DE_4_BITS;

architecture Behavioral of COMPARADOR_DE_4_BITS is
begin
    gt <= '1' when (a > b) else '0';
    eq <= '1' when (a = b) else '0';
    lt <= '1' when (a < b) else '0';
end Behavioral;
