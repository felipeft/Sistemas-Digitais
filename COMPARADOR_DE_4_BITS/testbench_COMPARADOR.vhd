library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_COMPARADOR is

end testbench_COMPARADOR;

architecture Behavioral of testbench_COMPARADOR is
    component COMPARADOR_DE_4_BITS
    port (
        a, b : in std_logic_vector(3 downto 0);
        gt, eq, lt : out std_logic);
    end component;
    
    signal a : std_logic_vector(3 downto 0);
    signal b : std_logic_vector(3 downto 0);
    signal gt : std_logic;
    signal eq : std_logic;
    signal lt : std_logic;
    constant interval :time := 100 ns;
begin
DUT : COMPARADOR_DE_4_BITS port map(a,b,gt,eq,lt);

    process
        begin
        -- testes com vetores pré determinados:
        a <= "1000";
        b <= "0000";
        wait for interval;
        a <= "0000";
        b <= "1000";
        wait for interval;
        a <= "0010";
        b <= "0000";
        wait for interval;
        a <= "0100";
        b <= "0001";
        wait for interval;
        a <= "0101";
        b <= "0101";
        wait for interval;
    end process;

end Behavioral;
