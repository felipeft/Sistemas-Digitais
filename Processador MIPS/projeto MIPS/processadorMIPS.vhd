library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_mips.all;

entity processadorMIPS is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce, rw : out STD_LOGIC;
           i_address : out reg32;
           d_address : out reg32;
           data : inout reg32;
           instruction : in reg32);
end processadorMIPS;

architecture Behavioral of processadorMIPS is
    signal uins : microinstruction;
begin
    dp: entity work.datapath
    port map(
            clk=>clk,
            rst=>rst,
            instruction=>instruction,
            d_address=>d_address,
            uins=>uins,
            data=>data
    );
    uc: entity work.unidadeControle
    port map(
            clk=>clk,
            rst=>rst,
            uins=>uins,
            i_address=>i_address,
            instruction=>instruction
    );
    ce <= uins.ce;
    rw <= uins.rw;
end Behavioral;
