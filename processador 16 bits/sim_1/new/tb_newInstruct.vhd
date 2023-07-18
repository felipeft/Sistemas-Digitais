library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_newInstruct  is
end tb_newInstruct;

architecture Behavioral of tb_newInstruct is
    -- sinais de fora do sistema
    signal clk_signal   : STD_LOGIC := '0';
    signal rst_signal   : STD_LOGIC := '1';
    signal read_signal  : STD_LOGIC_VECTOR(15 downto 0);
    signal write_signal : STD_LOGIC_VECTOR(15 downto 0);
    
    -- sinais de dentro do sistema
    signal IO_sel_signal   : STD_LOGIC;
    signal IO_en_signal    : STD_LOGIC;
    signal IO_mode_signal  : STD_LOGIC;        
    signal Sp_en_signal    : STD_LOGIC := '0';                    
    signal ROM_en_signal   : STD_LOGIC := '0';                    
    signal RAM_sel_signal  : STD_LOGIC := '0';                    
    signal RAM_we_signal   : STD_LOGIC := '0'; 
    signal WaitEnd_signal  : STD_LOGIC;                   
    signal RF_sel_signal   : STD_LOGIC_VECTOR(1 downto 0); 
    signal Rd_wr_signal    : STD_LOGIC;                    
    signal Rd_sel_signal   : STD_LOGIC_VECTOR(2 downto 0); 
    signal Rm_sel_signal   : STD_LOGIC_VECTOR(2 downto 0); 
    signal Rn_sel_signal   : STD_LOGIC_VECTOR(2 downto 0); 
    signal ALU_op_signal   : STD_LOGIC_VECTOR(3 downto 0);
    signal dataOut1_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal dataOut2_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal address1_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal address2_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_signal     : STD_LOGIC_VECTOR(15 downto 0);  
    signal SP_out_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal    : STD_LOGIC_VECTOR(15 downto 0);
    signal Rm_out_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_out_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal DataIn_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal IO_out_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal IO_signal       : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    DUT_IO_unit : entity work.In_Out
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            IO_mode => IO_mode_signal,
            IO_en   => IO_en_signal,
            read    => read_signal,
            write   => write_signal,
            IO_in   => Rm_out_signal,
            IO_out  => IO_out_signal
        );
        
    DUT_Mux3 : entity work.mux2x1
        Port map (
            I0      => immed_signal,
            I1      => IO_out_signal,
            sel     => IO_sel_signal,
            Mux_out => IO_signal
        );
        
    DUT_MemoryRom : entity work.ROM
        Port map (
            addr    => address1_signal,
            En      => ROM_en_signal,
            clk     => clk_signal,
            dout    => dataOut1_signal
        );
        
    DUT_ControlUnit : entity work.ControlUnit
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            WaitEnd => WaitEnd_signal,
            dout    => dataOut1_signal,
            flag_at => flag_signal,
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
            ula_op  => ALU_op_signal,
            Sp_out  => SP_out_signal,
            addr    => address1_signal,
            immed   => immed_signal
        );
        
    DUT_Mux1: entity work.mux2x1
        Port map (
            I0      => Rn_out_signal,
            I1      => Immed_signal,
            sel     => RAM_sel_signal,
            Mux_out => DataIn_signal
        );
        
    DUT_Mux2 : entity work.mux2x1
        Port map (
            I0      => Rm_out_signal,
            I1      => SP_out_signal,
            sel     => Sp_en_signal,
            Mux_out => address2_signal
        );
        
    DUT_MemoryRam : entity work.RAM
        Port map (
            clk  => clk_signal,
            addr => address2_signal,
            din  => dataIn_signal,
            we   => RAM_we_signal,
            dout => dataOut2_signal
        );
        
    DUT_DataPath : entity work.Datapath
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            dataOut => dataOut2_signal,
            immed   => IO_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            flags   => flag_signal,
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
    
    write_process:
    process begin
        read_signal <= x"0002";
        wait for 2 ns;
        read_signal <= x"0004";
        wait for 2 ns;
        read_signal <= x"0006";
        wait for 2 ns;
        read_signal <= x"0008";
        wait for 2 ns;
        read_signal <= x"000a";
        wait for 2 ns;
        read_signal <= x"000c";
        wait for 2 ns;
        read_signal <= x"000e";
        wait for 2 ns;
        read_signal <= x"0010";
        wait for 2 ns;
    end process;
    
    Stimulus:
    process begin
        wait for 4 ns;
        rst_signal <= '0';    
        address1_signal <= x"0009";
        wait for 100 ns;
    end process;

end Behavioral;
