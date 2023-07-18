library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A       : in STD_LOGIC_VECTOR(15 downto 0);
        B       : in STD_LOGIC_VECTOR(15 downto 0);
        op      : in STD_LOGIC_VECTOR(3 downto 0);
        flags   : out STD_LOGIC_VECTOR(15 downto 0);    -- flags para o resultado
        ALU_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end ALU;

architecture Behavioral of Alu is
    signal ResultX  : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal flag     : STD_LOGIC_VECTOR(15 downto 0) := x"0000";

begin
    process(A, B, op) begin
        case op is
            when "0000" => -- ADD operation
                ResultX <= unsigned(A) + unsigned(B);
                
            when "0001" => -- SUB operation
                ResultX <= unsigned(A) - unsigned(B);
                
            when "0010" => -- AND operation
                ResultX <= A and B;
                
            when "0011" => -- OR operation
                ResultX <= A or B;
                
            when "0100" => -- NOT operation
                ResultX <= not A;
                
            when "0101" => -- XOR operation
                ResultX <= A xor B;
                
            when "0110" => -- SLT operation
            when "0111" => -- CMP operation
                ResultX <= unsigned(A) - unsigned(B);
            
            when "1000" => -- SHR operation
                if (A(15) /= '1') then ResultX <= shr(A, B);
                end if;
                
            when "1001" => -- SHL operation
                if (A(15) /= '1') then
                    ResultX <= shl(A, B);
                end if;
                
            when "1010" => -- ROR operation
                ResultX <= A(0) & A(15 downto 1);
                
            when "1011" => -- ROL operation
                ResultX <= A(14 downto 0) & A(15);
                
            when "1100" => -- MUL operation
                ResultX <=  unsigned(A(7 downto 0)) * unsigned(B(7 downto 0));
                
            when "1101" =>
            when "1110" =>
            when "1111" =>
            when others =>
                ResultX <= x"0000";
                
        end case;
    end process;
    
    -- flag numero negativo
    flag(7) <= '1' when ResultX(15) = '1' else
               '0';
    
    -- flag numero 0
    flag(6) <= '1' when ResultX = x"0000" else
               '0';
    
    -- flag de carry
    flag(0) <= '1' when (A < B) else
               '0';
    
    Alu_out <= ResultX;
    flags   <= flag;
    
end Behavioral;