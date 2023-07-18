library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM2 is
    Port ( addr : in STD_LOGIC_VECTOR(15 downto 0);
           en : in STD_LOGIC;
           clk : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR(15 downto 0));
end ROM2;

architecture Behavioral of ROM2 is
    type memory is array(0 to 127) of std_logic_vector(7 downto 0);
    signal ROM_DATA : memory := (   -- matriz de instruções
        x"F0", x"01", x"11", x"00", -- 00
        x"1A", x"02", x"19", x"20",
        x"12", x"20", x"00", x"00",
        x"28", x"54", x"33", x"40",
        x"20", x"44", x"44", x"68",
        x"5C", x"6A", x"64", x"69",
        x"7C", x"68", x"84", x"68",
        x"9C", x"68", x"A4", x"68",
        x"B4", x"65", x"C4", x"65",
        x"D4", x"60", x"E4", x"60",
        x"00", x"09", x"00", x"0D", -- 10
        x"05", x"02", x"06", x"02",
        x"10", x"A0", x"10", x"C0",
        x"19", x"0A", x"1A", x"0B",
        x"08", x"08", x"00", x"00",
        x"00", x"47", x"08", x"19",
        x"08", x"12", x"08", x"0B",
        x"00", x"00", x"1A", x"09",
        x"00", x"47", x"08", x"19",
        x"08", x"12", x"08", x"0B",
        x"00", x"00", x"1A", x"0A", -- 20
        x"00", x"47", x"08", x"19",
        x"08", x"12", x"08", x"0B",
        x"00", x"00", x"19", x"03",
        x"1A", x"04", x"00", x"05",
        x"00", x"09", x"03", x"02", 
        x"04", x"02", x"15", x"60",
        x"16", x"80", x"F0", x"A2",
        x"F0", x"C2", x"FA", x"1F",
        x"F7", x"01", x"00", x"00",
        x"00", x"00", x"F7", x"01", -- 30
        x"FF", x"FF", x"00", x"00");
   
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
