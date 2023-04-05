library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbech_JKFF is
end testbech_JKFF;

architecture Behavioral of testbech_JKFF is
component JK_FLIPFLOP
    Port ( j, k, clk : in STD_LOGIC;
           q, qn : out STD_LOGIC);
end component;
signal j, k, clk, q, qn : STD_LOGIC;
begin
    DUT : JK_FLIPFLOP port map(j, k, clk, q, qn);
    process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;
    process
    begin
        j <= '0';
        k <= '0';
        wait for 12 ns;
        j <= '1';
        k <= '0';
        wait for 12 ns;
        j <= '0';
        k <= '1';
        wait for 10 ns;
        j <= '1';
        k <= '1';
        wait for 10 ns;
    end process;
end Behavioral;
