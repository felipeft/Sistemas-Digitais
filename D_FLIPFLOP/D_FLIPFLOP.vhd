library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FLIPFLOP is
    Port ( d, clk, r : in STD_LOGIC;
           q, qn : out STD_LOGIC);
end D_FLIPFLOP;

architecture Behavioral of D_FLIPFLOP is
begin
    process(clk, r)
    begin
        if r='1' then
            q <= '0';
            qn <= '1';            
        elsif falling_edge(clk) then
            q <= d;
            qn <= not d;
        end if;   
end process;

end Behavioral;
