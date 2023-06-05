library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_mips.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ula is
    Port ( op_ula : in inst_type;   -- uins.i (diz qual tipo de operaçao vai ser feito entre op1 e op2 (pode ser ADDU, SUBU e etc))
           op1 : in reg32;
           op2 : in reg32;
           resultadoULA : out reg32;
           zero : out STD_LOGIC);       -- flag para resultado 0
end ula;

architecture Behavioral of ula is
    signal int_ula : reg32;
begin
    resultadoULA <= int_ula;
    int_ula <= op1 - op2       when op_ula = SUBU else                  -- quando op_ula for de SUB faça op1 - op2
               op1 and op2     when op_ula = AAND else
               op1 or op2      when op_ula = OOR  or op_ula = ORI else
               op1 xor op2     when op_ula = XXOR else
               op1 nor op2     when op_ula = NNOR else
               op1 + op2;
    
    zero <= '1' when int_ula = x"00000000" else '0';                    -- flag de zero é setada quando resultado é 0
end Behavioral;
