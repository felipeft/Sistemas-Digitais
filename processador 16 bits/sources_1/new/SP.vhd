 -- increment StackPointer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity AddSP is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end AddSP;
architecture Behavioral of AddSP is
begin
    C <= A + 2;
end Behavioral;

-- decrement StackPointer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity SubSP is
    Port (
        A : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end SubSP;
architecture Behavioral of SubSP is
begin
    C <= A - 2;
end Behavioral;

-- Op. com ponteiro de pilha
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SP is
    Port (
        sp_op          : in STD_LOGIC;
        sp_address     : in STD_LOGIC_VECTOR(15 downto 0);
        new_sp_address : out STD_LOGIC_VECTOR(15 downto 0)
    );
end SP;

architecture Behavioral of SP is
    signal add_out_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal sub_out_signal : STD_LOGIC_VECTOR(15 downto 0);

begin
    add_sp : entity work.AddSP
        Port map (
            A => sp_address,
            C => add_out_signal
        );
        
    sub_sp : entity work.SubSP
        Port map (
            A => sp_address,
            C => sub_out_signal
        );
        
    mux_sp : entity work.mux2x1
        Port map (
            I0   => add_out_signal,
            I1   => sub_out_signal,
            sel => sp_op,
            mux_out => new_sp_address
        );
        
end Behavioral;
