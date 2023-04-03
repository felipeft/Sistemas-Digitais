library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
  Port (a: in signed(3 downto 0);
        b: in signed(3 downto 0);
        s: in std_logic_vector(2 downto 0);
        x: out signed(3 downto 0));
end ALU;

architecture Behavioral of ALU is
begin
    process (a, b, s)
    begin
        case s is 
            when "000" => x <= a + b; 
    
            when "001" => x <= a - b;
        
            when "010" => x <= a + 1;
        
            when "011" => x <= a - 1;
        
            when "100" => x <= a and b;
        
            when "101" => x <= a or b;
        
            when "110" => x <= not a;
        
            when "111" => x <= a xor b;
        
            when others => NULL;
        end case;
    end process;
end Behavioral;