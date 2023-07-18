library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

    entity CPU is
    Port ( 
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        read    : in STD_LOGIC_VECTOR (15 downto 0);
        write   : out STD_LOGIC_VECTOR (15 downto 0)
    );
end CPU;

architecture Behavioral of CPU is
    signal IO_signal        : STD_LOGIC_VECTOR (15 downto 0);
    signal IO_in_signal     : STD_LOGIC_VECTOR (15 downto 0);
    signal IO_out_signal    : STD_LOGIC_VECTOR (15 downto 0);
    
    -- Control Unit signal
    -- inSignals
    signal dataOut_signal_1 : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_at_signal   : STD_LOGIC_VECTOR(15 downto 0);
    -- outSignals
    signal IO_sel_signal    : STD_LOGIC;
    signal IO_en_signal     : STD_LOGIC;
    signal IO_mode_signal   : STD_LOGIC;
    signal WaitEnd_signal   : STD_LOGIC;
    signal Sp_en_signal     : STD_LOGIC;
    signal ROM_en_signal    : STD_LOGIC;
    signal RAM_sel_signal   : STD_LOGIC;
    signal RAM_we_signal    : STD_LOGIC;
    signal RF_sel_signal    : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal     : STD_LOGIC;
    signal Rd_sel_signal    : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal    : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal    : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal    : STD_LOGIC_VECTOR(3 downto 0);
    signal address_signal_1 : STD_LOGIC_VECTOR(15 downto 0);
    signal SP_out_signal    : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal     : STD_LOGIC_VECTOR(15 downto 0);
    
    -- DataPath signal
    -- inSignals
    signal dataOut_signal_2 : STD_LOGIC_VECTOR(15 downto 0);
    -- outSignals
    signal Rm_out_signal    : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_out_signal    : STD_LOGIC_VECTOR(15 downto 0);
    
    -- RAM signal 
    -- inSignals
    signal address_signal_2 : STD_LOGIC_VECTOR(15 downto 0);
    signal dataIn_signal    : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    IO_unit : entity work.In_Out
        Port map (
            clk     => clk,
            rst     => rst,
            IO_mode => IO_mode_signal,
            IO_en   => IO_en_signal,
            read    => read,
            write   => write,
            IO_in   => Rm_out_signal,
            IO_out  => IO_out_signal
        );
        
    Mux_IO : entity work.mux2x1
        Port map (
            I0   => immed_signal,
            I1   => IO_out_signal,
            sel => IO_sel_signal,
            Mux_out => IO_signal
        );
        
    ROM : entity work.ROM
        Port map (
            addr    => address_signal_1,
            En      => ROM_en_signal,
            clk     => clk,
            dout    => dataOut_signal_1
        );
        
    RAM : entity work.RAM
        Port map (
            addr => address_signal_2,
            din  => dataIn_signal,
            we   => RAM_we_signal,
            clk  => clk,
            dout => dataOut_signal_2
        );
        
    Mux_data_in : entity work.mux2x1
        Port map (
            I0      => Rn_out_signal,
            I1      => immed_signal,
            sel     => RAM_sel_signal,
            Mux_out => dataIn_signal
        );
    
    ControlUnit : entity work.ControlUnit
        Port map (
            clk     => clk,
            rst     => rst,
            WaitEnd => WaitEnd_signal,
            dout    => dataOut_signal_1,
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
            ula_op  => ALU_op_signal,
            addr    => address_signal_1,
            SP_out  => SP_out_signal,
            immed   => immed_signal
        );
        
    Mux_stack : entity work.mux2x1      -- mux para escolher se salva edereço pilha ou Rn
        Port map (
            I0      => Rm_out_signal,
            I1      => SP_out_signal,
            sel     => Sp_en_signal,
            Mux_out => address_signal_2
        );
    
    DataPath : entity work.Datapath
        Port map (
            clk     => clk,
            rst     => rst,
            dataOut => dataOut_signal_2,    -- sinal de saida do datapath
            immed   => IO_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            flags   => flag_at_signal,
            Rm_out  => Rm_out_signal,
            Rn_out  => Rn_out_signal 
        );

end Behavioral;
