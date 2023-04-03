library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_SIMPLE_LATCH is

end testbench_SIMPLE_LATCH;

architecture Behavioral of testbench_SIMPLE_LATCH is
    component SIMPLE_LATCH
        Port ( s : in STD_LOGIC;
           r : in STD_LOGIC;
           q : out STD_LOGIC);
    end component;
    signal s, r : std_logic;
    signal q: std_logic;
    constant interval : time := 100ns;
    
begin
DUT : SIMPLE_LATCH port map(s, r, q);
    process
        begin
            -- testes:
            s <= '0';
            r <= '0';
            wait for interval;
            s <= '1';
            r <= '0';
            wait for interval;
            s <= '0';
            r <= '1';
            wait for interval;
            s <= '1';
            r <= '1';
            wait for interval;
    end process;

end Behavioral;
