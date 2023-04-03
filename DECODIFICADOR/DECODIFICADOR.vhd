library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECODIFICADOR is
    Port ( ab : in std_logic_vector(1 downto 0);
           x0, x1, x2, x3 : out std_logic);
end DECODIFICADOR;

architecture Behavioral of DECODIFICADOR is
begin
    x0 <= '1' when(ab = "00") else '0';
    x1 <= '1' when(ab = "01") else '0';
    x2 <= '1' when(ab = "10") else '0';
    x3 <= '1' when(ab = "11") else '0';
end Behavioral;
