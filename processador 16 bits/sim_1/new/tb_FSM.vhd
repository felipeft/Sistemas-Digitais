library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_FSM is
end tb_FSM;

architecture Behavioral of tb_FSM is
    -- in signal
    signal clk_signal     : STD_LOGIC; 
    signal rst_signal     : STD_LOGIC := '1';
    signal WaitEnd        : STD_LOGIC := '0';
    signal IR_data_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal flags_signal   : STD_LOGIC_VECTOR(15 downto 0);
    
    -- out signal 
    signal IO_sel         : STD_LOGIC;
    signal IO_en          : STD_LOGIC;
    signal IO_mode        : STD_LOGIC;
    signal Sp_load_signal : STD_LOGIC;
    signal Sp_sel_signal  : STD_LOGIC;
    signal Sp_en_signal   : STD_LOGIC;
    signal flag_ld_signal : STD_LOGIC;
    signal Jump_signal    : STD_LOGIC;
    signal IR_load_signal : STD_LOGIC;
    signal RAM_sel_signal : STD_LOGIC;
    signal RAM_we_signal  : STD_LOGIC;
    signal ROM_en_signal  : STD_LOGIC;
    signal PC_clr_signal  : STD_LOGIC;
    signal PC_inc_signal  : STD_LOGIC;
    signal RF_sel_signal  : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal   : STD_LOGIC;
    signal Rd_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal  : STD_LOGIC_VECTOR(3 downto 0);
    signal Immed_signal   : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    DUT_Controller : entity work.FSM
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            WaitEnd => WaitEnd,
            IR_data => IR_data_signal,
            flags   => flags_signal,
            IO_sel  => IO_sel,
            IO_en   => IO_en,
            IO_mode => IO_mode,
            flag_ld => flag_ld_signal,
            Jump    => Jump_signal,
            Sp_load => Sp_load_signal,
            Sp_sel  => Sp_sel_signal,
            Sp_en   => Sp_en_signal,
            IR_load => IR_load_signal,
            RAM_sel => RAM_sel_signal,
            RAM_we  => RAM_we_signal,
            ROM_en  => ROM_en_signal,
            PC_clr  => PC_clr_signal,
            PC_inc  => PC_inc_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            Immed   => Immed_signal
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
        flags_signal   <= x"0000";
        
        -- in r0		  -> 0xF001
        wait until IR_load_signal = '1';
        IR_data_signal <= x"F001";
        
        -- mov r1, r0	  -> 0x1100
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1100";
        
        -- Mov r2, #2     -> 0x1A02
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1A02";
        
        -- Mov r1, #32    -> 0x1920
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1920";
        
        -- Mov r2, r1     -> 0x1220
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1220";
        
        -- Nop            -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- Str [r2], #20  -> 0x2854
        wait until IR_load_signal = '1';
        IR_data_signal <= x"2854";
        
        -- Ldr r3 , [r2]  -> 0x3340
        wait until IR_load_signal = '1';
        IR_data_signal <= x"3340";
        
        -- Str [r2], r1   -> 0x2044
        wait until IR_load_signal = '1';
        IR_data_signal <= x"2044";
        
        -- Add r4, r3, r2 -> 0x4468
        wait until IR_load_signal = '1';
        IR_data_signal <= x"4468";
        
        -- Sub r4, r3, r2 -> 0x5C6A
        wait until IR_load_signal = '1';
        IR_data_signal <= x"5C6A";
        
        -- Mul r4, r3, r2 -> 0x6469
        wait until IR_load_signal = '1';
        IR_data_signal <= x"6469";
        
        -- And r4, r3, r2 -> 0x7C68
        wait until IR_load_signal = '1';
        IR_data_signal <= x"7C68";
        
        -- Or r4, r3, r2  -> 0x8468
        wait until IR_load_signal = '1';
        IR_data_signal <= x"8468";
        
        -- Not r4, r3     -> 0x9C68
        wait until IR_load_signal = '1';
        IR_data_signal <= x"9C68";
        
        -- Xor r4, r3, r2 -> 0xA468
        wait until IR_load_signal = '1';
        IR_data_signal <= x"A468";
        
        -- Shr r4, r3, #5 -> 0xB465
        wait until IR_load_signal = '1';
        IR_data_signal <= x"B465";
        
        -- Shl r4, r3, #5 -> 0xC465
        wait until IR_load_signal = '1';
        IR_data_signal <= x"C465";
        
        -- Ror r4, r3     -> 0xD460
        wait until IR_load_signal = '1';
        IR_data_signal <= x"D460";
        
        -- Rol r4, r3     -> 0xE460
        wait until IR_load_signal = '1';
        IR_data_signal <= x"E460";
        
        -- push r2	       -> 0x0009
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0009";
        WaitEnd <= '1';
        wait for 100 ps;
        WaitEnd <= '0';
        
        -- push r3	       -> 0x000D
        wait until IR_load_signal = '1';
        IR_data_signal <= x"000D";
        WaitEnd <= '1';
        wait for 100 ps;
        WaitEnd <= '0';
        
        -- pop r5 	       -> 0x0502
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0502";
        
        -- pop r6 	       -> 0x0602
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0602";
        
        -- mov r0, r5     -> 0x10A0
        wait until IR_load_signal = '1';
        IR_data_signal <= x"10A0";
        
        -- mov r0, r6     -> 0x10C0
        wait until IR_load_signal = '1';
        IR_data_signal <= x"10C0";
        
        -- mov r1, #10    -> 0x190A
        wait until IR_load_signal = '1';
        IR_data_signal <= x"190A";
        
        -- mov r2, #11    -> 0x1A0B
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1A0B";
        
        -- jmp #0002      -> 0x0802
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0808";
        
        -- nop            -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- cmp r2, r1     -> 0x0047
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0047";
        wait until flag_ld_signal = '1';
        flags_signal   <= x"0000";
        
        -- jeq #0006   	-> 0x0819
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0819";
        
        -- jgt #0004      -> 0x0812
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0812";
        
        -- jlt #0002   	-> 0x080B
        wait until IR_load_signal = '1';
        IR_data_signal <= x"080B";
        
        -- nop            -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- mov r2, #9     -> 0x1A09
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1A09";
        
        -- cmp r2, r1     -> 0x0047
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0047";
        wait until flag_ld_signal = '1';
        flags_signal   <= x"0040";
        
        -- jeq #0006   	-> 0x0819
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0819";
        
        -- jgt #0004      -> 0x0812
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0812";
        
        -- jlt #0002   	-> 0x080B
        wait until IR_load_signal = '1';
        IR_data_signal <= x"080B";
        
        -- nop            -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- mov r2, #10 	-> 0x1A0A
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1A0A";
        
        -- cmp r2, r1  	-> 0x0047
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0047";
        wait until flag_ld_signal = '1';
        flags_signal   <= x"0001";
        
        -- jeq #0006   	-> 0x0819
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0819";
        
        -- jgt #0004      -> 0x0812
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0812";
        
        -- jlt #0002   	-> 0x080B
        wait until IR_load_signal = '1';
        IR_data_signal <= x"080B";
        
        -- nop          -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- mov r1, #3	-> 0x1903
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1903";
        
        -- mov r2, #4	-> 0x1A04
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1A04";
        
        -- push r1		-> 0x0005
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0005";
        
        -- push r2		-> 0x0009
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0009";
        
        -- pop r3		-> 0x0302
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0302";
        
        -- pop r4		-> 0x0402
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0402";
        
        -- mov r5, r3	-> 0x1560
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1560";
        
        -- mov r6, r4	-> 0x1680
        wait until IR_load_signal = '1';
        IR_data_signal <= x"1680";
                
        -- out r5 		 -> 0xF0A2
        wait until IR_load_signal = '1';
        IR_data_signal <= x"F0A2";
        
        -- out r6		 -> 0xF0C2
        wait until IR_load_signal = '1';
        IR_data_signal <= x"F0C2";
        
        -- out #5F		 -> 0xFA1F
        wait until IR_load_signal = '1';
        IR_data_signal <= x"FA1F";
        
        -- in r7		 -> 0xF701
        wait until IR_load_signal = '1';
        IR_data_signal <= x"F701";
        
        -- nop 		     -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- nop		     -> 0x0000
        wait until IR_load_signal = '1';
        IR_data_signal <= x"0000";
        
        -- in r7		 -> 0xF701 
        wait until IR_load_signal = '1';
        IR_data_signal <= x"F701";
        
        -- halt		   -> 0xFFFF
        wait until IR_load_signal = '1';
        IR_data_signal <= x"FFFF";
        
    end process;

end Behavioral;
