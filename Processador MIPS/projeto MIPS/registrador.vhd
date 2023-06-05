library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_mips.all;

entity registrador is
    generic(INIT_VALUE : reg32 := (others=>'0'));
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;   -- sinal de controle
           D : in reg32;        -- entrada
           Q : out reg32);      -- saida
end registrador;

architecture Behavioral of registrador is

begin
    process(rst,clk)
    begin
        if(rst='1')then
            Q <= INIT_VALUE(31 downto 0);   -- saida recebe valor inicial
        elsif(clk'event and clk='1')then    -- caso rst=0 o clk esteja em borda de subida
            if(ce='1') then                 -- controle de escrita for 1
                Q<=D;                       -- saida recebe entrada
             end if;
        end if;
    end process;
end Behavioral;
