library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity FSM is
    Port (
        clk     : in STD_LOGIC; 
        rst     : in STD_LOGIC;
        WaitEnd : in STD_LOGIC;                     -- indica o final do ciclo de "execução"
        IR_data : in STD_LOGIC_VECTOR(15 downto 0);
        flags   : in STD_LOGIC_VECTOR(15 downto 0);
        
        IO_sel  : out STD_LOGIC;
        IO_en   : out STD_LOGIC;
        IO_mode : out STD_LOGIC;
        flag_ld : out STD_LOGIC;
        Jump    : out STD_LOGIC;
        Sp_load : out STD_LOGIC;
        Sp_sel  : out STD_LOGIC;
        Sp_en   : out STD_LOGIC;
        IR_load : out STD_LOGIC;
        RAM_sel : out STD_LOGIC;
        RAM_we  : out STD_LOGIC;
        ROM_en  : out STD_LOGIC;
        PC_clr  : out STD_LOGIC;
        PC_inc  : out STD_LOGIC;
        RF_sel  : out STD_LOGIC_VECTOR(1 downto 0);
        Rd_wr   : out STD_LOGIC;
        Rd_sel  : out STD_LOGIC_VECTOR(2 downto 0);
        Rm_sel  : out STD_LOGIC_VECTOR(2 downto 0);
        Rn_sel  : out STD_LOGIC_VECTOR(2 downto 0);
        ALU_op  : out STD_LOGIC_VECTOR(3 downto 0);
        Immed   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end FSM;

architecture Behavioral of FSM is
    signal control : STD_LOGIC_VECTOR(47 downto 0);
    signal pipeline : STD_LOGIC := '0';
    signal clockSP_signal : STD_LOGIC := '0';     
begin
    process(IR_data, clk, rst, WaitEnd)  begin
        if(rst = '1') then
            control <= x"002000000000";
        else
            if(rising_edge(clk)) then
                if(IR_data = x"FFFF") then
                    control <= x"000000000000";     -- zera todos os sinais
                    pipeline <= '1';                -- exec
                else
                    if(clockSP_signal = '0') then
                        if(pipeline = '0') then
                             control <= x"001C00000000";
                             pipeline <= '1';
                        else
                        
                            control <= x"000000000000";
                            case IR_data(15 downto 12) is       -- tipo da instrucao
                                when "0000" =>                  
                                    if (IR_data(11) = '0') then
                                        case IR_data(1 downto 0) is
                                            when "00" =>        -- nop
                                                control <= x"000000000000";
                                                
                                            when "01" =>                -- push
                                                control(42) <= '1';     -- carrega ponteiro de pilha
                                                control(41) <= '1';     -- utiliza registrador de SP
                                                control(16) <= '1';     -- ativa escrita na ram
                                                control(6 downto 4) <= IR_data(4 downto 2); -- registrador n
                                                clockSP_signal <= '1';
                                                
                                            when "10" =>                        -- POP
                                                control(40) <= '1';             -- ativa ponteiro de pilha para leitura 
                                                control(15 downto 14) <= "01";  -- RF: register file recebe valor da RAM (pop)
                                                control(13 downto 11) <= IR_data(10 downto 8);  -- endereço do regD
                                                control(10) <= '1';             -- ativa operação de escrita no regD
                                                clockSP_signal <= '1';
                                                
                                            when "11" =>                        -- cmp
                                                control(39) <= '1';             -- flag ld
                                                control(15 downto 0) <= "110000" & IR_data(7 downto 2) & "0111";    -- saida ula, Rm, Rn e alu op
                                                
                                            when others =>
                                                control <= x"000000000000";
                                            
                                        end case;
                                    else    -- agora com imediato IR_data(10)
                                        control(36 downto 18) <= "1000000000" & IR_data(10 downto 2); -- ativa PC e passa valor do imediato
                                        case IR_data(1 downto 0) is
                                            when "00" =>            -- jump simples
                                                control(38) <= '1'; -- ativa flag para dar jump
                                                
                                            when "01" =>                                        -- jump se igual
                                                if (flags(0) = '0' and flags(6) = '1') then     -- quando nao for '<' e quando resultado for 0
                                                    control(38) <= '1';
                                                end if;
                                                
                                            when "10" =>                                    -- jump se menor
                                                if (flags(0) = '1' and flags(6) = '0') then -- quando for '<' e diferente de 0
                                                    control(38) <= '1';
                                                end if;
                                            
                                            when "11" =>                                    -- jump se maior
                                                if (flags(0) = '0' and flags(6) = '0') then -- quando nao for '<' e diferente de 0
                                                    control(38) <= '1';
                                                end if;
                                                
                                            when others =>
                                                control <= x"000000000000";
                                            
                                        end case;
                                    end if;
                                    
                                when "0001" =>
                                    control(33 downto 7) <=  x"00" & IR_data(7 downto 0) 
                                    & "00" & IR_data(11) & '0' & IR_data(10 downto 8) & '1' & IR_data(7 downto 5) ;
                                    -- Imediato extendido, sem RAM, I2 do mux, Rm sel
                                    
                                when "0010" =>
                                    control(33 downto 4) <= x"00" & IR_data(10 downto 8) & IR_data(4 downto 0) & IR_data(11) & '1' & "000000" & IR_data(7 downto 5) & IR_data(4 downto 2);
                                    
                                when "0011" =>
                                    control (15 downto 7) <= "01" & IR_data(10 downto 8) & '1' & IR_data(7 downto 5);
                                    
                                when "0100" =>  
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "0000";
                                    
                                when "0101" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "0001";
                                    
                                when "0110" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "1100";
                                    
                                when "0111" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "0010";
                                    
                                when "1000" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "0011";
                                    
                                when "1001" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "0100";
                                    
                                when "1010" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 2) & "0101";
                                    
                                when "1011" =>
                                    control(33 downto 0) <= (x"0000" + IR_data(4 downto 0)) & "0011" & IR_data(10 downto 8) & '1' & IR_data(7 downto 5) & "0001000";
                                    
                                when "1100" =>
                                    control(33 downto 0) <= (x"0000" + IR_data(4 downto 0)) & "0011" & IR_data(10 downto 8) & '1' & IR_data(7 downto 5) & "0001001";
                                    
                                when "1101" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 5) & "0001010";
                                    
                                when "1110" =>
                                    control(15 downto 0) <= "11" & IR_data(10 downto 8) & '1' & IR_data(7 downto 5) & "0001011";
                                
                                when "1111" => 
                                    if(IR_data(1 downto 0) = "01") then
                                        control(44 downto 43) <= "10";
                                        control(15 downto 14) <= "10"; 
                                        control(13 downto 11) <= IR_data(10 downto 8);
                                        control(10) <= '1';
                                    
                                    elsif(IR_data(1 downto 0) = "10" and IR_data(11) = '0') then
                                        control(44 downto 43) <= "11";
                                        control(9 downto 7) <= IR_data(7 downto 5);
                                        
                                    elsif(IR_data(11) = '1') then
                                        if(IR_data(10) = '0') then
                                            control(33 downto 18) <= x"0" & "000" & IR_data(10 downto 7) & IR_data(4 downto 0);
                                        else
                                            control(33 downto 18) <= x"F" & "111" & IR_data(10 downto 7) & IR_data(4 downto 0);
                                          end if;
                                        control(45 downto 43) <= "111";
                                        control(10) <= '1';
                                    
                                    end if;
                                
                                when others => 
                                    control <= x"000000000000";
                                    
                            end case;
                            pipeline <= '0';
                        end if;
                    else
                        if(WaitEnd = '0') then
                            control(42) <= '0';
                            control(41) <= '0';
                            control(40) <= '1';
                            clockSP_signal <= '0';
                        end if;
                        if(clockSP_signal = '1') then
                            control(42) <= '1';
                            control(40) <= '0';
                            clockSP_signal <= '0';
                        end if;
                    end if;
                end if;
            end if;     
        end if;
    
    end process;
    
    IO_sel  <= control(45);
    IO_en   <= control(44);
    IO_mode <= control(43);
    Sp_load <= control(42);
    Sp_sel  <= control(41);
    Sp_en   <= control(40);
    flag_ld <= control(39);
    Jump    <= control(38);
    PC_clr  <= control(37);
    PC_inc  <= control(36);
    ROM_en  <= control(35);
    IR_load <= control(34);
    Immed   <= control(33 downto 18);
    RAM_sel <= control(17);
    RAM_we  <= control(16);
    RF_sel  <= control(15 downto 14);
    Rd_sel  <= control(13 downto 11); 
    Rd_wr   <= control(10);
    Rm_sel  <= control(9 downto 7);
    Rn_sel  <= control(6 downto 4);
    ALU_op  <= control(3 downto 0);

end Behavioral;
