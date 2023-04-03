library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_RIPPLE is
end testbench_RIPPLE;

architecture Behavioral of testbench_RIPPLE is
    component RIPPLE_CARRY_ADDER
        port( a, b : in std_logic_vector(3 downto 0);
              sum : out std_logic_vector(3 downto 0);
              cout : out std_logic);
    end component;
    signal a_tb, b_tb, sum_tb : std_logic_vector(3 downto 0);
    signal cout_tb : std_logic;
begin
    DUT : RIPPLE_CARRY_ADDER port map(a_tb, b_tb, sum_tb, cout_tb);
    process
        begin
        a_tb <= "0001";
        b_tb <= "0000";
        wait for 100ns;
        a_tb <= "0111";
        b_tb <= "1000";
        wait for 100ns;
        a_tb <= "1001";
        b_tb <= "1001";
        wait for 100ns;
    end process;


end Behavioral;
