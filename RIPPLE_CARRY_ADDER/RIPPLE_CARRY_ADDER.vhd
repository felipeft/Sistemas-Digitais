library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RIPPLE_CARRY_ADDER is
    port( a, b : in std_logic_vector(3 downto 0);
          sum : out std_logic_vector(3 downto 0);   --vetor que recebe o resultado
          cout : out std_logic);
end RIPPLE_CARRY_ADDER;

architecture Behavioral of RIPPLE_CARRY_ADDER is
    component FULL_ADDER is
        port( a, b, cin : in std_logic;
          sum, cout : out std_logic);
    end component;
    
    signal C1, C2, C3 : std_logic;
begin
    A1 : FULL_ADDER port map(a(0), b(0), '0', sum(0), C1); 
    A2 : FULL_ADDER port map(a(1), b(1), '0', sum(1), C2); 
    A3 : FULL_ADDER port map(a(2), b(2), '0', sum(2), C3); 
    A4 : FULL_ADDER port map(a(3), b(3), '0', sum(3), Cout); 
end Behavioral;
