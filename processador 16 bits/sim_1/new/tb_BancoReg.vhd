library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_BancoReg is
end tb_BancoReg;

architecture Behavioral of tb_BancoReg is
    signal clk_signal    : STD_LOGIC;
    signal rst_signal    : STD_LOGIC := '1';
    signal Rd_wr_signal  : STD_LOGIC;
    signal Rd_sel_signal : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal : STD_LOGIC_VECTOR(2 downto 0);
    signal Rd_signal     : STD_LOGIC_VECTOR(15 downto 0);
    signal Rm_signal     : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_signal     : STD_LOGIC_VECTOR(15 downto 0);

begin
    DUT_BancoReg : entity work.BancoReg
        Port map (
            clk    => clk_signal,
            rst    => rst_signal,
            Rd_wr  => Rd_wr_signal,
            Rd_sel => Rd_sel_signal,
            Rm_sel => Rm_sel_signal,
            Rn_sel => Rn_sel_signal,
            Rd     => Rd_signal,
            Rm     => Rm_signal,
            Rn     => Rn_signal
        );
    
    Clock_signal:
    process begin
        wait for 1 ns;
        clk_signal <= '1';
        wait for 1 ns;
        clk_signal <= '0';
    end process;
    
    Stimulus:
    process begin
        rst_signal <= '0';
                
        Rd_signal <= x"0000";
        Rd_sel_signal <= "000";
        Rm_sel_signal <= "000";
        Rn_sel_signal <= "001";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
        Rd_signal <= x"0001";
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "010";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
        Rd_signal <= x"0002";
        Rd_sel_signal <= "010";
        Rm_sel_signal <= "010";
        Rn_sel_signal <= "011";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
        Rd_signal <= x"0003";
        Rd_sel_signal <= "011";
        Rm_sel_signal <= "011";
        Rn_sel_signal <= "100";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
        Rd_signal <= x"0004";
        Rd_sel_signal <= "100";
        Rm_sel_signal <= "100";
        Rn_sel_signal <= "101";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
        Rd_signal <= x"0005";
        Rd_sel_signal <= "101";
        Rm_sel_signal <= "101";
        Rn_sel_signal <= "110";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
         Rd_signal <= x"0006";
        Rd_sel_signal <= "110";
        Rm_sel_signal <= "110";
        Rn_sel_signal <= "111";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
        
        Rd_signal <= x"0007";
        Rd_sel_signal <= "111";
        Rm_sel_signal <= "111";
        Rn_sel_signal <= "000";
        Rd_wr_signal <= '1';
        wait for 2 ns;
        
    end process;

end Behavioral;
