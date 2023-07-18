library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ControlUnit is
end tb_ControlUnit;

architecture Behavioral of tb_ControlUnit is
    
    -- in signals
    signal clk_signal     : STD_LOGIC;
    signal rst_signal     : STD_LOGIC := '1';
    signal WaitEnd_signal : STD_LOGIC := '0';
    signal dataOut_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_at_signal : STD_LOGIC_VECTOR(15 downto 0);
    
    -- out signals
    signal IO_sel_signal  : STD_LOGIC;
    signal IO_en_signal   : STD_LOGIC;
    signal IO_mode_signal : STD_LOGIC;
    signal Sp_en_signal   : STD_LOGIC;
    signal ROM_en_signal  : STD_LOGIC;
    signal RAM_sel_signal : STD_LOGIC;
    signal RAM_we_signal  : STD_LOGIC;
    signal RF_sel_signal  : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal   : STD_LOGIC;
    signal Rd_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal  : STD_LOGIC_VECTOR(3 downto 0);
    signal SP_out_signal  : STD_LOGIC_VECTOR(15 downto 0);
    signal address_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal   : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    DUT_ControlUnit : entity work.ControlUnit
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            WaitEnd => WaitEnd_signal,
            dout    => dataOut_signal,
            flag_at => flag_at_signal,
            IO_sel  => IO_sel_signal,
            IO_en   => IO_en_signal,
            IO_mode => IO_mode_signal,
            Sp_en   => Sp_en_signal,
            ROM_en  => ROM_en_signal,
            RAM_sel => RAM_sel_signal,
            RAM_we  => RAM_we_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ULA_op  => ALU_op_signal,
            Sp_out  => SP_out_signal,
            addr    => address_signal,
            immed   => immed_signal
        );
        
    
    DUT_MemoryRom : entity work.ROM
        Port map (
            addr    => address_signal,
            En      => ROM_en_signal,
            clk     => clk_signal,
            dout    => dataOut_signal
        );
    
    Clock_signal:
    process begin
        clk_signal <= '1';
        wait for 50 ps;
        clk_signal <= '0';
        wait for 50 ps;
    end process;
    
    Stimulus:
    process begin
        wait for 200 ps;
        rst_signal <= '0';
        flag_at_signal <= x"FFFF";
        
        wait for 13 ns;
    end process;
    
    Stack_signal:
    process(clk_signal) begin
        if(rising_edge(clk_signal)) then
            if(dataOut_signal = x"0047") then
                if(flag_at_signal = x"FFFF") then
                    flag_at_signal <= x"0000";
                elsif(flag_at_signal = x"0000") then
                    flag_at_signal <= x"0040";
                elsif(flag_at_signal = x"0040") then
                    flag_at_signal <= x"0001";
                end if;
                
            end if;
        end if;
    end process;

end Behavioral;
