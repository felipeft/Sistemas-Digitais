library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2x1 is
    Port ( 
        I0      : in STD_LOGIC_VECTOR (15 downto 0);
        I1      : in STD_LOGIC_VECTOR (15 downto 0);
        sel     : in STD_LOGIC;
        mux_out : out STD_LOGIC_VECTOR (15 downto 0)
 );
end mux2x1;

architecture Behavioral of mux2x1 is

begin
    mux_out <= I0 when sel = '0' else
               I1;

end Behavioral;
