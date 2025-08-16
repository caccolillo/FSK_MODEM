library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity find_peak is
    port (
        clk      		: in  std_logic;  --clock signal
        empty_0    		: in  std_logic;  --when 1 the data input data fifo is empty, stop search until next m_axis_data_tlast_0 = 1 
        M_AXIS_DATA_0 		: in  std_logic_vector(31 downto 0); --signed 32 bit integer input data where to search the maximum positive value
        m_axis_data_tlast_0 	: in  std_logic; --when rising edge signals starting the maximum value index search
        max_index 		: out std_logic_vector(31 downto 0); --position of the maximum  positive value search to be updated when empty_0 goes 1 
        rd_en_0		: out  std_logic -- used to read the next value from the FIFO
    );
end entity;

architecture rtl of find_peak is

    -- Internal signals
    signal sample          : signed(31 downto 0);
    signal current_index   : unsigned(31 downto 0) := (others => '0');
    signal max_value       : signed(31 downto 0) := (others => '0');
    signal max_index_reg   : unsigned(31 downto 0) := (others => '0');
    signal searching       : std_logic := '0';
    signal last_tlast      : std_logic := '0';
begin    
    process(clk)
    begin
        if rising_edge(clk) then
            -- default no read
            rd_en_0 <= '0';

            -- detect rising edge of m_axis_data_tlast_0: start a new search
            if (m_axis_data_tlast_0 = '1' and last_tlast = '0') then
                searching      <= '1';
                current_index  <= (others => '0');
                max_value      <= (others => '0');
                max_index_reg  <= (others => '0');
            end if;
            last_tlast <= m_axis_data_tlast_0;

            if searching = '1' then
                if empty_0 = '0' then
                    -- request next sample
                    rd_en_0 <= '1';
                    -- convert input to signed
                    sample <= signed(M_AXIS_DATA_0);

                    -- compare if positive
                    if sample > max_value and sample > to_signed(0,32) then
                        max_value     <= sample;
                        max_index_reg <= current_index;
                    end if;

                    -- increment index
                    current_index <= current_index + 1;
                else
                    -- FIFO empty -> finish search and update output
                    searching  <= '0';
                    max_index  <= std_logic_vector(max_index_reg);
                end if;
            end if;

        end if;
    end process;

end architecture;

