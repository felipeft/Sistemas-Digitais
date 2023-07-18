library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
    Port (
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        WaitEnd : in STD_LOGIC;
        dout    : in STD_LOGIC_VECTOR(15 downto 0);
        flag_at : in STD_LOGIC_VECTOR(15 downto 0);
        
        IO_sel  : out STD_LOGIC;
        IO_en   : out STD_LOGIC;
        IO_mode : out STD_LOGIC;
        Sp_en   : out STD_LOGIC;
        ROM_en  : out STD_LOGIC;
        RAM_sel : out STD_LOGIC;
        RAM_we  : out STD_LOGIC;
        RF_sel  : out STD_LOGIC_VECTOR(1 downto 0);
        Rd_wr   : out STD_LOGIC;
        Rd_sel  : out STD_LOGIC_VECTOR(2 downto 0);
        Rm_sel  : out STD_LOGIC_VECTOR(2 downto 0);
        Rn_sel  : out STD_LOGIC_VECTOR(2 downto 0);
        ula_op  : out STD_LOGIC_VECTOR(3 downto 0);
        addr    : out STD_LOGIC_VECTOR(15 downto 0);
        SP_out  : out STD_LOGIC_VECTOR(15 downto 0);
        immed   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
    signal IR_data_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_signal    : STD_LOGIC_VECTOR(15 downto 0);
    signal IR_load_signal : STD_LOGIC;
    signal PC_ctr_signal  : STD_LOGIC;
    signal PC_en_signal   : STD_LOGIC;
    signal PC_out         : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal newAddress_sig : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_ld_signal : STD_LOGIC;
    signal Jump_signal    : STD_LOGIC;
    signal SP_in_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal SP_out_signal  : STD_LOGIC_VECTOR(15 downto 0);
    signal SP_ctl_signal  : STD_LOGIC;
    signal SP_sel_signal  : STD_LOGIC;
begin

    PC : entity work.Registrador    -- PC
        Port map (
            D   => newAddress_sig,
            ld  => PC_ctr_signal,
            clk => clk,
            rst => PC_en_signal,
            Q   => PC_out
        );
        
    PcComplement : entity work.PC   -- incrementador PC
        Port map (
            Jump_ctl    => Jump_signal,
            immed       => immed_signal,
            addr        => PC_out,
            new_addr    => newAddress_sig
        );
        
    addr <= PC_out;
        
    IR : entity work.Registrador   -- IR
        Port map (
            D   => dout,
            ld  => IR_load_signal,
            clk => clk,
            rst => rst,
            Q   => IR_data_signal
        );
        
    FSM : entity work.FSM
        Port map (
            clk     => clk,
            rst     => rst,
            WaitEnd => WaitEnd,
            IR_data => IR_data_signal,
            flags   => flag_signal,
            IO_sel  => IO_sel,
            IO_en   => IO_en,
            IO_mode => IO_mode,
            flag_ld => flag_ld_signal,
            Jump    => Jump_signal,
            Sp_load => SP_ctl_signal,
            Sp_sel  => SP_sel_signal,
            Sp_en   => Sp_en,
            IR_load => IR_load_signal,
            RAM_sel => RAM_sel,
            RAM_we  => RAM_we,
            ROM_en  => ROM_en,
            PC_clr  => PC_en_signal,
            PC_inc  => PC_ctr_signal,
            RF_sel  => RF_sel,
            Rd_wr   => Rd_wr,
            Rd_sel  => Rd_sel,
            Rm_sel  => Rm_sel,
            Rn_sel  => Rn_sel,
            ALU_op  => ula_op,
            Immed   => immed_signal
        );
        
    immed <= immed_signal;
        
    FlagRegister : entity work.Registrador
        Port map (
            D   => flag_at,
            ld  => flag_ld_signal,
            clk => clk,
            rst => rst,
            Q   => flag_signal
        );
        
    SP : entity work.Registrador   -- Registrador ponteiro de pilha
        Generic Map ( valor => x"0040" )
        Port map ( 
            D   => SP_in_signal,
            ld  => SP_ctl_signal,
            clk => clk,
            rst => rst,
            Q   => SP_out_signal
        );
        
    SPComplement : entity work.SP     -- incrementador de ponteiro de pilha
        Port map (
            sp_op          => SP_sel_signal,
            sp_address     => SP_out_signal,
            new_sp_address => SP_in_signal
        );
        
    SP_out <= SP_out_signal;

end Behavioral;
