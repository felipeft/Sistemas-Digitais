library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BancoReg is
    Port (
        clk    : in STD_LOGIC;
        rst    : in STD_LOGIC;
        Rd_wr  : in STD_LOGIC;
        Rd_sel : in STD_LOGIC_VECTOR(2 downto 0);   -- escolher registrador de destino
        Rm_sel : in STD_LOGIC_VECTOR(2 downto 0);
        Rn_sel : in STD_LOGIC_VECTOR(2 downto 0);
        Rd     : in STD_LOGIC_VECTOR(15 downto 0);  -- dado do endereço de destino
        Rm     : out STD_LOGIC_VECTOR(15 downto 0);
        Rn     : out STD_LOGIC_VECTOR(15 downto 0)
    );
end BancoReg;

architecture Behavioral of BancoReg is
    type BancoReg is array(0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
    signal Reg     : BancoReg;
    signal control : STD_LOGIC_VECTOR(7 downto 0);      -- vetor de controle para apontar quais registradores serão utillizados

begin
    g1 : for i in 0 to 7 generate
        control(i) <= '1' when Rd_wr = '1' and Rd_sel = i else '0';
        
        Rp : entity work.Registrador(Behavioral)
            port map (
                D   => Rd,
                clk => clk,
                rst => rst,
                ld  => control(i),
                Q   => Reg(i)
            );
        
    end generate;
    
    Rm <= Reg(conv_integer(unsigned(Rm_sel)));
    Rn <= Reg(conv_integer(unsigned(Rn_sel)));
    
end Behavioral;
