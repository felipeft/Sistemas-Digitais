library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_mips.all;
use IEEE.std_logic_signed.all;

entity unidadeControle is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;              -- temos um registrador na UC (PC)
           uins : out microinstruction;     -- sinais de controle para o datapath
           instruction : in reg32;          -- entrada da instruçao que será decodificada
           i_address : out reg32);          -- endereço da instruçao, pode ser incrementado e pode ser mandado para a memoria de instrucoes
end unidadeControle;

architecture Behavioral of unidadeControle is
    signal incpc, pc : reg32;               -- pc e seu incrementador
    signal i: inst_type;                    -- instrução decodificada
begin
    -- proxima instrucao PC  
    rpc: entity work.registrador
                generic map(INIT_VALUE=>x"00400000")
                
                port map(
                    clk=>clk,
                    rst=>rst,
                    ce=>'1',
                    D=>incpc,
                    Q=>pc);
    
    incpc<=pc+4;
    
    i_address <= pc;
    
    -- apos obtermos o endereço da instrução, pegamos na memoria de instruçoes e decodificamos
    -- decodificacao de instrucoes
    uins.i <= i;                        -- i = instruçao decodificada
    
    -- instruçoes do tipo R como ADDU, SUBU começam zeradas com "000000" para preencher os campos da instruçao (OP|RT|RS|RD|shamt|funct)
    -- ja instruçoes I tem endereçamento imediato, entao busca diretamente do processador
    i <= ADDU when instruction(31 downto 26)="000000" and instruction(10 downto 0)= "00000100001" else
         SUBU when instruction(31 downto 26)="000000" and instruction(10 downto 0)= "00000100011" else 
         AAND when instruction(31 downto 26)="000000" and instruction(10 downto 0)= "00000100100" else
         OOR  when instruction(31 downto 26)="000000" and instruction(10 downto 0)= "00000100101" else
         XXOR when instruction(31 downto 26)="000000" and instruction(10 downto 0)= "00000100110" else
         NNOR when instruction(31 downto 26)="000000" and instruction(10 downto 0)= "00000100111" else
         ORI  when instruction(31 downto 26)="001101" else
         LW   when instruction(31 downto 26)="100011" else
         SW   when instruction(31 downto 26)="101011" else
         invalid_instruction;
         
    -- erro de instruçao invalida
    assert i/= invalid_instruction
        report "Instrucao_invalida"
        severity error;
    
    -- gerador de sinais de controle para acesso a memoria externa
    uins.ce     <= '1'  when i=SW   or i=LW else '0';   -- sinal de controle CE escrita
    uins.rw     <= '0'  when i=SW   else '1';           -- sinal de controle RW leitura
    uins.wreg   <= '0'  when i=SW   else '1';           -- sinal de controle de R/W no banco de registradores
    
    -- resumindo: (isso para instruçoes I ja que R carrega direto na memoria) 
    -- ce | rw |
    --  0     1| nao muda
    --  0     1| SW
    --  1     1| LW
end Behavioral;
