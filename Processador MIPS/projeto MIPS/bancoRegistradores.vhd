library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.pkg_mips.all;

entity bancoRegistradores is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           AdRP1 : in std_logic_vector(4 downto 0);     -- endere�o 1� registrador
           AdRP2 : in std_logic_vector(4 downto 0);     -- endere�o 2� registrador
           AdWP : in std_logic_vector(4 downto 0);      -- endere�o registrador que receber� os dados escritos (nao mistura dados)
           DataWP : in reg32;                           -- dados que ser�o escritos no registrador 'WP"
           DataRP1 : out reg32;                         -- dado 1� registrador
           DataRP2 : out reg32);                        -- dado 2� registrador
end bancoRegistradores;

architecture Behavioral of bancoRegistradores is
    type banco_reg is array(0 to 31) of reg32;  -- array para enumerar todos os registradores
    signal reg : banco_reg;                     -- reg � um sinal do tipo banco_reg
    signal wen : reg32;                         -- variavel de 32 bits que ir� percorrer pelo array de registradores (funcionar� como "array" de controle)
begin
    
    g1: for i in 0 to 31 generate               -- la�o for que percorre o array
        
        wen(i) <= '1' when i/=0 and adWP = i and ce = '1' else '0';     -- posi�ao i do wen recebe 1 se for diferente de 0;
                                                                        -- se  controle de escrita = 1
        
        g2:if i=29 generate
        
            r29: entity work.registrador                                -- registrador 29 � destinado para ponteiro de pilha
            generic map(INIT_VALUE => x"10010800")
            port map(clk => clk,
                 rst => rst,
                 ce => wen(i),                                          -- wen recebe 1 se foi escrito no registrador, senao = 0 
                 d => dataWP,                                           -- entrada do banco de reg recebe entrada do reg indicado
                 Q => reg(i));                                          -- saida do registrador indicado no banco de reg vai ser o mesmo 
            
            end generate;
        
        g3:if i/=29 generate
        
        rn: entity work.registrador
            port map(clk => clk,
                     rst => rst,
                     ce => wen(i),
                     D => dataWP,
                     Q => reg(i));
                     
        end generate; 
           
    end generate;
    
    -- saidas do banco de registradores
    DataRP1 <= reg(conv_integer(AdRP1));    -- dado do primeiro registrador � o mesmo do array reg com indice do endere�o do primeiro reg (convertido para int)
    DataRP2 <= reg(conv_integer(AdRP2));    -- mesmo aqui
    
end Behavioral;
