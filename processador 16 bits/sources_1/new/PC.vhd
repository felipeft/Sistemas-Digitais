-- increment PC
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity AddPC is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end AddPC;
architecture Behavioral of AddPC is
begin
    C <= A + 2;     -- soma entrada do pc + 2 e joga na saída
end Behavioral;

-- extensor do sinal
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity extenderSignal is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);   
        B : out STD_LOGIC_VECTOR (15 downto 0)
    );
end extenderSignal;
architecture Behavioral of extenderSignal is
begin
    B <= "0000000" & A(8 downto 0) when A(8) = '0' else -- caso seja positivo imediato extende x"0000"
         "1111111" & A(8 downto 0);
end Behavioral;

-- soma generica entre dois vetores
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Add is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);
        B : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Add;
architecture Behavioral of Add is
begin
    C <= A + B;
end Behavioral;

-- operacoes no PC
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PC is
    Port (
        Jump_ctl : in STD_LOGIC;
        immed    : in STD_LOGIC_VECTOR(15 downto 0);
        addr     : in STD_LOGIC_VECTOR(15 downto 0);
        new_addr : out STD_LOGIC_VECTOR(15 downto 0)
    );
end PC;
architecture Behavioral of PC is
    signal immed_ext   : STD_LOGIC_VECTOR(15 downto 0);
    signal Add1_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Add2_signal : STD_LOGIC_VECTOR(15 downto 0);
    
begin      
    extenderSignal : entity work.extenderSignal
        Port map (
            A => immed,
            B => immed_ext
        );
          
    addPC : entity work.addPC
        Port map (
            A => addr,
            C => Add1_signal
        );
        
    AddJUMP : entity work.Add
        Port map (
            A => addr,
            B => immed_ext,
            C => Add2_signal
        );
        
    MuxJUMP : entity work.mux2x1
        Port map (
            I0   => Add1_signal,
            I1   => Add2_signal,
            sel => Jump_ctl,
            mux_out => new_addr
        );
        
end Behavioral;