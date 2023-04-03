library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HALF_ADDER is
    port (a, b : in bit; 
    sum, carry: out bit); 
end HALF_ADDER;

architecture Behavioral of HALF_ADDER is
begin
    sum <= a xor b;
    carry <= a and b;
end Behavioral;
