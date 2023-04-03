library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_PROJECT is
    port ( a0, a1, a2, a3: in std_logic_vector(3 downto 0);
           s : in std_logic_vector(1 downto 0);
           x : out std_logic_vector(3 downto 0));
end MUX_PROJECT;

architecture Behavioral of MUX_PROJECT is
begin
    with s select
    x <= a0 when "00",
    a1 when "01",
    a2 when "10",
    a3 when others;
end Behavioral;