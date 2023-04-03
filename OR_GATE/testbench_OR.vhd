library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_OR is

end testbench_OR;

architecture Behavioral of testbench_OR is
    component OR_GATE
        Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           x : out STD_LOGIC);
    end component;
    signal a, b, x: std_logic;
    constant intervalo : time := 100 ns;
    begin
    DUT: OR_GATE port map(a=>a,b=>b,x=>x);
    estimulos: process
        begin
            a <= '0';
            b <= '0';
            wait for intervalo;
            a <= '0';
            b <= '1';
            wait for intervalo;
            a <= '1';
            b <= '0';
            wait for intervalo;
            a <= '1';
            b <= '1';
            wait for intervalo;
    end process;

end Behavioral;
