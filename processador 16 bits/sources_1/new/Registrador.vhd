library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registrador is
    Generic (
        valor : STD_LOGIC_VECTOR(15 downto 0) := x"0000"
    );
    Port ( 
        D : in STD_LOGIC_VECTOR (15 downto 0);
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        ld : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Registrador;

architecture Behavioral of Registrador is

begin
    process(clk,rst) begin
        if(rst = '1') then
            Q <= valor;
        else
            if(rising_edge(clk)) then
                if(ld = '1') then
                    Q <= D;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
