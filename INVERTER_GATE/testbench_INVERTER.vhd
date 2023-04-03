library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_INVERTER is
    
end testbench_INVERTER;

architecture Behavioral of testbench_INVERTER is
    component INVERTER_GATE
        Port ( a : in STD_LOGIC;
               x : out STD_LOGIC);
    end component;
    signal a, x: std_logic;
    constant intervalo : time := 100 ns;

begin
    DUT: INVERTER_GATE port map(a=>a,x=>x);
    
    estimmulos: process
    begin
        a <= '0';
        wait for intervalo;
        a <= '1';
        wait for intervalo;
    end process;

end Behavioral;
