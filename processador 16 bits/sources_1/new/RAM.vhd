library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port ( 
        clk    : in STD_LOGIC;
        we     : in STD_LOGIC;
        din    : in STD_LOGIC_VECTOR (15 downto 0);
        addr   : in STD_LOGIC_VECTOR (15 downto 0);
        dout   : out STD_LOGIC_VECTOR (15 downto 0)
    );
end RAM;

architecture Behavioral of RAM is
    type RAM is array(0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    signal RAM_data : RAM := (
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 0
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 10
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 20
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 30
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00"
    );
    
begin
    WriteProcess:           -- escreve dado de entrada em um dos indices da matriz RAM_data
    process(clk,addr) begin
        if(rising_edge(clk)) then
            if(we = '1') then  
                RAM_data(to_integer(unsigned(addr))) <= din(7 downto 0);
                RAM_data(to_integer(unsigned(addr + 1))) <= din(15 downto 8);
            end if;
        end if;
    end process;
    
    ReadProcess:            -- coloca o dado de determinado endereço em dout
    process(clk, addr) begin
        if(rising_edge(clk)) then
            dout(7 downto 0) <= RAM_data(to_integer(unsigned(addr)));
            dout(15 downto 8) <= RAM_data(to_integer(unsigned(addr)));
        end if;
    end process;

end Behavioral;
