library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Datapath is
--  Port ( );
end tb_Datapath;

architecture Behavioral of tb_Datapath is
    signal clk_signal     : STD_LOGIC;
    signal rst_signal     : STD_LOGIC := '1';
    signal dataOut_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal RF_sel_signal  : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal   : STD_LOGIC;
    signal Rd_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal  : STD_LOGIC_VECTOR(3 downto 0);
    
    signal flags_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal Rm_out_signal  : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_out_signal  : STD_LOGIC_VECTOR(15 downto 0);

begin
    DUT_DataPath : entity work.Datapath
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            dataOut => dataOut_signal,
            immed   => immed_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            flags   => flags_signal,
            Rm_out  => Rm_out_signal,
            Rn_out  => Rn_out_signal
        );
    
    Clock_signal:
    process begin
        clk_signal <= '1';
        wait for 1 ns;
        clk_signal <= '0';
        wait for 1 ns;
    end process;
    
    Stimulus:
    process begin
        wait for 4 ns;
        rst_signal <= '0';
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0002";
        RF_sel_signal <= "10";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "000";
        Rm_sel_signal <= "000";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0006";
        RF_sel_signal <= "10";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "000";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0001";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0010";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0011";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "1100";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0101";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0100";
        wait for 4 ns;
        
        dataOut_signal <= x"F00F";
        immed_signal <= x"0000";
        RF_sel_signal <= "01";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0002";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "1000";
        wait for 2 ns;
        
        dataOut_signal <= x"F00F";
        immed_signal <= x"0000";
        RF_sel_signal <= "01";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0002";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "1001";
        wait for 2 ns;
        
        dataOut_signal <= x"C003";
        immed_signal <= x"0000";
        RF_sel_signal <= "01";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "000";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "1010";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "000";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "1011";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"000E";
        RF_sel_signal <= "10";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "100";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"000E";
        RF_sel_signal <= "10";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "000";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "00";
        Rd_wr_signal <= '1';
        Rd_sel_signal <= "001";
        Rm_sel_signal <= "100";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0000";
        wait for 2 ns;
        
        dataOut_signal <= x"0000";
        immed_signal <= x"0000";
        RF_sel_signal <= "11";
        Rd_wr_signal <= '0';
        Rd_sel_signal <= "010";
        Rm_sel_signal <= "001";
        Rn_sel_signal <= "000";
        ALU_op_signal <= "0111";
        wait for 2 ns;
        
    end process;

end Behavioral;
