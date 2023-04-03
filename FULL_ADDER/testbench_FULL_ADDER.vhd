library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_FULL_ADDER is
end testbench_FULL_ADDER;

architecture Behavioral of testbench_FULL_ADDER is
    component FULL_ADDER
        port( a, b, c : in bit;
              sum, carry : out bit);
    end component;
    signal a, b, c : bit;
    signal sum, carry : bit;
    constant interval : time:= 100ns;
begin
DUT : FULL_ADDER port map(a, b, c, sum, carry);
    process
        begin
            -- testes:
            a <= '0';
            b <= '0';
            wait for interval;
            a <= '1';
            b <= '0';
            wait for interval;
            a <= '0';
            b <= '1';
            wait for interval;
            a <= '1';
            b <= '1';
            wait for interval;
    end process;

end Behavioral;
