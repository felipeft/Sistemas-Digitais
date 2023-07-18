library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port ( addr : in STD_LOGIC_VECTOR(15 downto 0);
           en : in STD_LOGIC;
           clk : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR(15 downto 0));
end ROM;

architecture Behavioral of ROM is
    type memory is array(0 to 127) of std_logic_vector(7 downto 0);
    signal ROM_DATA : memory := (   -- matriz de instruções
        x"19", x"07",   -- mov reg1, 7
        x"1A", x"05",   -- mov reg2, 5
        x"43", x"28",   -- add reg1, reg2 salva em r3
        x"F0", x"62",   -- out reg3
        x"00", x"05",   -- push reg1
        x"00", x"09",   -- push reg2
        x"00", x"0D",   -- push reg3
        x"F4", x"01",   -- in data no reg 4
        --x"08", x"08",   -- jump imediato 2
        x"00", x"2B",   -- cmp reg 1 reg 2
        x"01", x"02",   -- pop reg1
        x"02", x"02",   -- pop reg2         
        x"03", x"02",   -- pop reg3
        others => x"00");
   
begin
    
    ReadProcess: 
    process(clk) begin
        if (rising_edge(clk)) then
            if (en = '1') then
                dout(7 downto 0) <= ROM_DATA(to_integer(unsigned(addr)) + 1);    --saida da rom recebe o dado de endereço addr 
                dout(15 downto 8) <= ROM_DATA(to_integer(unsigned(addr)));          
            end if;
        end if;
    end process;

end Behavioral;
