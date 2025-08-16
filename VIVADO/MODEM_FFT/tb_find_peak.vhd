library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_find_peak is
end entity;

architecture sim of tb_find_peak is

    -- DUT ports
    signal clk               : std_logic := '0';
    signal empty_0           : std_logic := '1';
    signal M_AXIS_DATA_0     : std_logic_vector(31 downto 0) := (others => '0');
    signal m_axis_data_tlast_0 : std_logic := '0';
    signal max_index         : std_logic_vector(31 downto 0);
    signal rd_en_0           : std_logic;

    -- test data
    type data_array is array (natural range <>) of integer;
    constant test_samples : data_array := ( -10, 25, 7, -3, 50, 12, 49, -1, 0 );
    constant expected_max_index : integer := 4; -- index of value 50

    -- state
    signal sample_index : integer := 0;

begin

    -- Instantiate DUT
    uut: entity work.find_peak
        port map (
            clk                 => clk,
            empty_0             => empty_0,
            M_AXIS_DATA_0       => M_AXIS_DATA_0,
            m_axis_data_tlast_0 => m_axis_data_tlast_0,
            max_index           => max_index,
            rd_en_0             => rd_en_0
        );

    -- clock generator
    clk <= not clk after 5 ns;  -- 100 MHz

    -- stimulus process
    stim_proc: process
    begin
        wait for 20 ns;

        -- Start search
        m_axis_data_tlast_0 <= '1';
        wait for 10 ns;
        m_axis_data_tlast_0 <= '0';

        -- Feed samples
        for i in 0 to test_samples'length-1 loop
            empty_0 <= '0'; -- FIFO not empty
            M_AXIS_DATA_0 <= std_logic_vector(to_signed(test_samples(i),32));
            wait for 10 ns; -- one clock per sample
            sample_index <= i;
        end loop;

        -- End of FIFO
        empty_0 <= '1';
        wait for 20 ns;

        -- Check result
        report "Max index found: " & integer'image(to_integer(unsigned(max_index)))
            severity note;

        if to_integer(unsigned(max_index)) = expected_max_index then
            report "TEST PASSED" severity note;
        else
            report "TEST FAILED" severity error;
        end if;
 
        report "TEST ENDED" severity failure;

        wait;
    end process;

end architecture;

