library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_DECODIFICADOR is

end testbench_DECODIFICADOR;

architecture Behavioral of testbench_DECODIFICADOR is
    component DECODIFICADOR
        Port ( ab : in std_logic_vector(0 to 1);
               x0, x1, x2, x3 : out std_logic);
    end component;
    
    signal ab : std_logic_vector(0 to 1);
    signal x0, x1, x2, x3 : std_logic;
    constant interval : time := 100ns;
begin
DUT : DECODIFICADOR port map(ab, x0, x1, x2, x3);
    process
        begin
            --testes:
            ab <= "00";
            wait for interval;
            ab <= "01";
            wait for interval;
            ab <= "10";
            wait for interval;
            ab <= "11";
            wait for interval;

    end process;
end Behavioral;
