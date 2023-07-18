library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity In_Out is
    Port ( 
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        IO_mode : in STD_LOGIC;
        IO_en   : in STD_LOGIC;  
        read    : in STD_LOGIC_VECTOR (15 downto 0);
        write   : out STD_LOGIC_VECTOR (15 downto 0);
        IO_in   : in STD_LOGIC_VECTOR (15 downto 0);
        IO_out  : out STD_LOGIC_VECTOR (15 downto 0)
    );
end In_Out;

architecture Behavioral of In_Out is

begin
    process(rst, clk) begin
        if(rst = '0' and rising_edge(clk)) then
            if(IO_en = '1') then
                if(IO_mode = '1') then
                    write <= IO_in;
                else
                    IO_out <= read;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
