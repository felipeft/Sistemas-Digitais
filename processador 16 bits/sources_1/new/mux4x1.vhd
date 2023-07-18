library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1 is
    Port ( 
        I0      : in STD_LOGIC_VECTOR (15 downto 0);
        I1      : in STD_LOGIC_VECTOR (15 downto 0);
        I2      : in STD_LOGIC_VECTOR (15 downto 0);
        I3      : in STD_LOGIC_VECTOR (15 downto 0);
        sel     : in STD_LOGIC_VECTOR (1 downto 0);
        Mux_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end mux4x1;

architecture Behavioral of mux4x1 is

begin
    Mux_out <= I0 when sel = "00" else
               I1 when sel = "01" else
               I2 when sel = "10" else
               I3;

end Behavioral;
