library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ALU is
--  Port ( );
end tb_ALU;

architecture Behavioral of tb_ALU is
    signal A_signal       : STD_LOGIC_VECTOR(15 downto 0);
    signal B_signal       : STD_LOGIC_VECTOR(15 downto 0);
    signal op_signal      : STD_LOGIC_VECTOR(3 downto 0);
    signal flags_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal Alu_out_signal : STD_LOGIC_VECTOR(15 downto 0);
begin
    DUT_Alu : entity work.ALU
        Port map (
            A       => A_signal,
            B       => B_signal,
            op      => op_signal,
            flags   => flags_signal,
            Alu_out => Alu_out_signal
        );
    
    process begin
        A_signal <= x"0005";
        B_signal <= x"0002";
        
        op_signal <= "0000";
        wait for 5 ns;
        
        op_signal <= "0001";
        wait for 5 ns;
        
        op_signal <= "0010";
        wait for 5 ns;
        
        op_signal <= "0011";
        wait for 5 ns;
        
        op_signal <= "0100";
        wait for 5 ns;
        
        op_signal <= "0101";
        wait for 5 ns;
        
        op_signal <= "1100";
        wait for 5 ns;
        
        A_signal <= x"F00F";
        
        op_signal <= "1000";
        wait for 5 ns;
        
        op_signal <= "1001";
        wait for 5 ns;
        
        A_signal <= x"C003";
        
        op_signal <= "1010";
        wait for 5 ns;
        
        op_signal <= "1011";
        wait for 5 ns;
        
        A_signal <= x"000F";
        B_signal <= x"000E";
        
        op_signal <= "0111";
        wait for 5 ns;
        
        A_signal <= x"000E";
        B_signal <= x"000E";
        
        op_signal <= "0111";
        wait for 5 ns;
        
        A_signal <= x"FFFF";
        B_signal <= x"0001";
        wait for 5 ns;
        
    end process;

end Behavioral;
