library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity FSMcrack is
    Port ( clk     : in STD_LOGIC; 
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
           Immed   : out STD_LOGIC_VECTOR(15 downto 0));
end FSMcrack;

architecture Behavioral of FSMcrack is

-- estados da maquina
type state_type is (init, fetch, decode, 
                                 exec_nop, exec_halt, exec_mov, exec_load, exec_store, exec_ula, exec_pilha, exec_jump, exec_io);
                                 
-- "ponteiro" para o estado atual e o proximo estado a ser executado                                
signal current_state, next_state: state_type;

-- instrução lida
signal control : STD_LOGIC_VECTOR(47 downto 0);

begin
    process(clk,rst)
    begin
        if(rst = '1') then
            current_state <= init;
        elsif(rising_edge(clk)) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, clk, rst)  begin
        if(rst = '1') then
            control <= x"002000000000";
        else
            if(rising_edge(clk)) then
                if(IR_data = x"FFFF") then
                    next_state <= exec_halt;
                else
                    if(WaitEnd_signal = '0' and Waitstack = '0') then
                             control <= x"001C00000000";
                        else
    
    
                    




















    
    
    process(current_state, instruction)
    begin
        case current_state is
            when init =>
                ROM_en  <= '0';   
                PC_clr  <= '1';
                PC_inc  <= '0';  
                IR_load <= '0';  
                Immed   <= x"0000";
                RAM_sel <= '0'; 
                RAM_we  <= '0'; 
                RF_sel  <= "00"; 
                Rd_sel  <= "000"; 
                Rd_wr   <= '0'; 
                Rm_sel  <= "000"; 
                Rn_sel  <= "000"; 
                ula_op  <= "0000";                
                -- Após o término de um estado, vai pro proximo
                next_state <= fetch;
                               
            when fetch =>
                ROM_en  <= '1';   
                PC_clr  <= '0';
                PC_inc  <= '1';  
                IR_load <= '1';  
                Immed   <= x"0000";
                RAM_sel <= '0'; 
                RAM_we  <= '0'; 
                RF_sel  <= "00"; 
                Rd_sel  <= "000"; 
                Rd_wr   <= '0'; 
                Rm_sel  <= "000"; 
                Rn_sel  <= "000"; 
                ula_op  <= "0000"; 
                next_state <= decode;
                
            when decode =>
                ROM_en  <= '0';   
                PC_clr  <= '0';
                PC_inc  <= '0';  
                IR_load <= '0';  
                Immed   <= x"0000";
                RAM_sel <= '0'; 
                RAM_we  <= '0'; 
                RF_sel  <= "00"; 
                Rd_sel  <= "000"; 
                Rd_wr   <= '0'; 
                Rm_sel  <= "000"; 
                Rn_sel  <= "000"; 
                ula_op  <= "0000"; 
                if(instruction(15 downto 0) = x"0000") then
                    next_state <= exec_1;
                elsif(instruction(15 downto 0) = x"FFFF") then
                    next_state <= exec_halt;
                elsif(instruction(15 downto 12) = "0001") then
                    next_state <= exec_mov;
                elsif (instruction(15 downto 12) = "0010") then
                    next_state <= exec_store;
                elsif (instruction(15 downto 12) = "0011") then
                    next_state <= exec_load;
                elsif (instruction(15 downto 12) = "0100" or instruction(15 downto 12) = "0101" 
                    or instruction(15 downto 12) = "0110" or instruction(15 downto 12) = "0111"
                    or instruction(15 downto 12) = "1000" or instruction(15 downto 12) = "1001"
                    or instruction(15 downto 12) = "1010") then
                    next_state   <= exec_ula;
                end if;
                
            when exec_0000 =>
                if (IR_data(11) = '0') then
                    case IR_data(1 downto 0) is
                        when "00" =>
                            control <= x"000000000000";
                        when "01" =>
                            control(42) <= '1';
                            control(41) <= '1';
                            control(16) <= '1';
                            control(6 downto 4) <= IR_data(4 downto 2);
                                                
                         when "10" =>
                            control(40) <= '1';
                            control(15 downto 14) <= "01";
                            control(13 downto 11) <= IR_data(10 downto 8);
                            control(10) <= '1';
                                                
                         when "11" =>
                            control(39) <= '1';
                            control(15 downto 0) <= "110000" & IR_data(7 downto 2) & "0111";
                                                
                         when others =>
                            control <= x"000000000000";                                      
                    end case;  
                else 
                    control(36 downto 18) <= "1000000000" & IR_data(10 downto 2);
                     case IR_data(1 downto 0) is
                        when "00" =>
                            control(38) <= '1';
                                                
                        when "01" =>
                            if (flags(0) = '0' and flags(6) = '1') then
                                control(38) <= '1';
                            end if;
                        
                        when "10" =>
                            if (flags(0) = '1' and flags(6) = '0') then
                                control(38) <= '1';
                            end if;
                    
                        when "11" =>
                            if (flags(0) = '0' and flags(6) = '0') then
                                control(38) <= '1';
                            end if;
                                                
                        when others =>
                            control <= x"000000000000";
                                        
                    end case;
                end if;                
                          
                           
                next_state <= fetch;
            
            when exec_halt =>
                next_state <= exec_halt;
            
            when exec_mov =>
                immed <= x"00" & instruction(7 downto 0);
                RF_sel  <= instruction(11) & '0';           -- seletor do mux para operaçao com imediato (I2)
                Rd_sel  <= instruction(10 downto 8);        -- endereço reg destino
                Rd_wr   <= '1'; 
                Rm_sel  <= instruction(7 downto 5);         -- endereço reg origem       
                next_state <= fetch;            
                 
            when exec_load =>
                RF_sel  <= "01";                            -- mux para escolher I1
                Rd_sel  <= instruction(10 downto 8);        -- endereço reg destino
                Rd_wr   <= '1'; 
                Rm_sel  <= instruction(7 downto 5);         -- endereço reg origem       
                next_state <= fetch;  
                
            when exec_store =>
                Immed   <= x"00" & instruction(10 downto 8) & instruction(4 downto 0);
                RAM_sel <= instruction(11);
                RAM_we  <= '1';
                Rm_sel  <= instruction(7 downto 5);         -- endereço reg origem   
                Rn_sel  <= instruction(4 downto 2);    
                next_state <= fetch; 
                
           when exec_ula =>   
                RF_sel  <= "11"; 
                Rd_sel  <= instruction(10 downto 8); 
                Rd_wr   <= '1'; 
                Rm_sel  <= instruction(7 downto 5); 
                Rn_sel  <= instruction(4 downto 2); 
                ula_op  <= instruction(15 downto 12); 
                next_state <= fetch;
        end case;
    end process;
    
    instruction <= IR_data;
                                             
end Behavioral;
