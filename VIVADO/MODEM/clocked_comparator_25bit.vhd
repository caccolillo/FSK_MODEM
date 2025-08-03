library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clocked_comparator_25bit is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic; -- optional reset
        A        : in  std_logic_vector(24 downto 0);
        B        : in  std_logic_vector(24 downto 0);
        A_gt_B   : out std_logic
    );
end entity;

architecture rtl of clocked_comparator_25bit is
    signal A_signed, B_signed : signed(24 downto 0);
    signal result             : std_logic := '0';
begin

    -- Convert inputs to signed
    A_signed <= signed(A);
    B_signed <= signed(B);

    -- Clocked process
    process(clk, reset)
    begin
        if reset = '1' then
            result <= '0';
        elsif rising_edge(clk) then
            if A_signed > B_signed then
                result <= '1';
            else
                result <= '0';
            end if;
        end if;
    end process;

    -- Output assignment
    A_gt_B <= result;

end architecture;

