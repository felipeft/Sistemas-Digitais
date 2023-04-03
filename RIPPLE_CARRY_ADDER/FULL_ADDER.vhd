library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FULL_ADDER is
    port( a, b, cin : in std_logic;
          sum, cout : out std_logic);
end FULL_ADDER;

architecture Behavioral of FULL_ADDER is
begin
    sum <= a xor b xor cin;   -- a xor b = s// s xor cin
    cout <= ((a and b) or (b and cin) or (a and cin));
end Behavioral;
