library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FULL_ADDER is
    port( a, b, c : in bit;
          sum, carry : out bit);
end FULL_ADDER;

architecture Behavioral of FULL_ADDER is
begin
    sum <= a xor b xor c;   -- a xor b = s// s xor c
    carry <= ((a and b) or (b and c) or (a and c));
end Behavioral;
