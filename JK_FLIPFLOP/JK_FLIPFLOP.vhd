library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JK_FLIPFLOP is
        Port ( j, k, clk : in STD_LOGIC;
               q, qn : out STD_LOGIC);
end JK_FLIPFLOP;

architecture Behavioral of JK_FLIPFLOP is
begin
    process(clk)
    variable data : STD_LOGIC;
    begin
        if(falling_edge(clk)) then
            if (j = '0' and k = '0') then
                data := data;
            elsif(j = '0' and k = '1') then
                data := '0';
            elsif(j = '1' and k = '0') then
                data := '1';
            elsif(j = '1' and k = '1') then
                data := not data;
            end if;
            q <= data;
            qn <= not data;
        end if;
    end process;  
end Behavioral;
