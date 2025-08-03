library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
    Port (
        A     : in  std_logic_vector(15 downto 0);  -- Input A
        B     : in  std_logic_vector(15 downto 0);  -- Input B
        Sel   : in  std_logic;                      -- Select line
        Y     : out std_logic_vector(15 downto 0)   -- Output
    );
end mux2to1;

architecture Behavioral of mux2to1 is
begin
    process(A, B, Sel)
    begin
        if Sel = '0' then
            Y <= A;
        else
            Y <= B;
        end if;
    end process;
end Behavioral;

