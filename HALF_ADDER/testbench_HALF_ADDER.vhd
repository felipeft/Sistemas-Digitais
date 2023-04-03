library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_HALF_ADDER is

end testbench_HALF_ADDER;

architecture Behavioral of testbench_HALF_ADDER is
    component HALF_ADDER
        port (a, b : in bit; 
        sum, carry: out bit); 
    end component;
    signal a, b : bit;
    signal sum, carry : bit;
    constant interval : time := 100ns;
    
begin
DUT : HALF_ADDER port map(a, b, sum , carry);
    process
        begin
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
