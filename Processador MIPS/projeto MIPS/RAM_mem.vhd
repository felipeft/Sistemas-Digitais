library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.pkg_mips.all;

entity RAM_mem is
      generic( START_ADDRESS: reg32 := (others=>'0') );
      port(
        ce_n, we_n, oe_n, bw: in std_logic;
        address: in reg32;
        data: inout reg32);    
end RAM_mem;

architecture RAM_mem of RAM_mem is 
    signal RAM : memory;
    signal int_address: reg32;
    alias low_address: reg16 is int_address(15 downto 0);
begin

    int_address <= address - START_ADDRESS;
    
    process(ce_n, we_n, low_address)
        begin
            if ce_n='0' and oe_n='0' and
            CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address)<=MEMORY_SIZE-3 then
                data(31 downto 24) <= RAM(CONV_INTEGER(low_address+3));
                data(23 downto 16) <= RAM(CONV_INTEGER(low_address+2));
                data(15 downto 8) <= RAM(CONV_INTEGER(low_address+1));
                data(7 downto 0) <= RAM(CONV_INTEGER(low_address ));
            else
                data(31 downto 24) <= (others => 'Z');
                data(23 downto 16) <= (others => 'Z');
                data(15 downto 8) <= (others => 'Z');
                data(7 downto 0) <= (others => 'Z');
            end if;
        end process;               
end RAM_mem;