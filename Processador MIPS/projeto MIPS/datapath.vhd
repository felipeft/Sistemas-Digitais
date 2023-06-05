library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_mips.all;
use IEEE.std_logic_unsigned;

entity datapath is
    Port ( clk : in STD_LOGIC;      -- banco de registradores 
           rst : in STD_LOGIC;
           uins : in microinstruction;  -- sinais de controle para as instruçoes
           d_address : out reg32;       -- "resultado da ula"
           data : inout reg32;          -- saida ou entrada para a memoria de dados (RAM)
           instruction : in reg32);     -- saida da memoria de instruçoes (ROM)
end datapath;

architecture Behavioral of datapath is
    signal result, r1, r2, ext32, reg_dest, op2 : reg32;
    signal adD : std_logic_vector(4 downto 0);
    signal instR, zero : std_logic;
begin
    -- detector de instruções tipo R
    instR <= '1' when uins.i=ADDU or uins.i=SUBU or UINS.i=AAND or
                      uins.i=OOR or uins.i=XXOR or uins.i=NNOR else '0';
    
    -- MUX1: se instrução for do tipo R passa 15.. 11 pro adD (endereço do registrador que receberá os dados escritos)
    M1: adD <= instruction(15 downto 11) when instR='1' else instruction(20 downto 16);
    
    -- Banco de registradores
    REGS: entity work.bancoRegistradores
        port map(
            clk=>clk,
            rst=>rst,
            ce=>uins.wreg,                      -- sinal de leitura/escrita no banco de registradores (basicamente liga desliga)
            AdRP1=>instruction(25 downto 21),   -- endereço do primeiro reg
            AdRP2=>instruction(20 downto 16),   -- endereço do segundo reg
            adWP=>adD,                          -- endereço do reg que irá receber os dados escritos
            DataWP=>reg_dest,                   -- dados que serão escritos no reg de destino ^
            DataRP1=>R1,                        
            DataRP2=>R2);
            
    -- MUX2: 
    M2: ext32 <= x"FFFF" & instruction(15 downto 0) when (instruction(15) = '1'
                 and (uins.i=LW or uins.i=SW)) else
                 x"0000" & instruction(15 downto 0);    -- ori
                 
    -- MUX3: saida do mux só é R2 se a instruçao for do tipo R
    M3: op2 <= R2 when instR = '1' else ext32;
    
    -- ULA
    inst_ula: entity work.ula
              port map(
                    op1=>R1,
                    op2=>op2,   -- saida do MUX2
                    resultadoULA=>result,
                    zero=>zero,
                    op_ula=>uins.i     -- sinal de controle que indica qual instrução será executada
              );
    d_address <= result;    -- "result = d_address"
    
    -- MUX para data; se rw=0 e ce=1 entao data=R2
    MMem: data <= R2 when uins.rw='0' and uins.ce='1' else (others=> 'Z');
    
    -- MUX4: dataWP (dados que serao escritos no reg de destino) é = data se a instruçao for LW, caso contrario = resultadoULA                
    M4: reg_dest <= data when uins.i=LW else result;
end Behavioral;