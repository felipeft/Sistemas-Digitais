library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity testbench_ALU is
end testbench_ALU;

architecture Behavioral of testbench_ALU is
    component ALU 
    port( a: in signed(3 downto 0);
          b: in signed(3 downto 0);
          s: in std_logic_vector(2 downto 0);
          x: out signed(3 downto 0)
    );
    end component;
    
    signal a: signed(3 downto 0) := (others => '0');
    signal b: signed(3 downto 0) := (others => '0');
    signal s: std_logic_vector(2 downto 0) := (others => '0');
    
    signal x: signed(3 downto 0);
BEGIN

    DUT: ALU port map(a,b,s,x);
    
    process
    begin
        a <= "1001";
        b <= "1111";
        
        s <= "000";
        wait for 100 ns;
        
        s <= "001";       
        wait for 100 ns;
        
        s <= "010";        
        wait for 100 ns;
        
        s <= "011";   
        wait for 100 ns;
        
        s <= "100";
        wait for 100 ns;
    
        s <= "101";
        wait for 100 ns;
        
        s <= "110";    
        wait for 100 ns;

        s <= "111";
        wait for 100 ns;
    end process;
end Behavioral;