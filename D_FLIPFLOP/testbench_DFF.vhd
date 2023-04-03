library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_DFF is
end testbench_DFF;

architecture Behavioral of testbench_DFF is

component D_FLIPFLOP is
    Port ( d, clk, r : in STD_LOGIC;
           q, qn : out STD_LOGIC);
end component D_FLIPFLOP;

signal d, clk, r, q, qn : std_logic;
begin
    DUT: D_FLIPFLOP port map(d, clk, r, q, qn);
    process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;
    process
    begin
        d <= '0'; wait for 12 ns; 
        d <= '1'; wait for 12 ns;
    end process;
    r <= '1' after 0 ns, '0' after 5 ns;
end Behavioral;
