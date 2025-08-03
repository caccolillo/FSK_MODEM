library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tb is
end uart_tb;

architecture Behavioral of uart_tb is
    constant CLK_PERIOD : time := 10 ns;  -- 100 MHz

    signal clk       : std_logic := '0';
    signal tx_start  : std_logic := '0';
    signal tx_data   : std_logic_vector(7 downto 0) := x"55"; -- test pattern
    signal tx_line   : std_logic;
    signal rx_data   : std_logic_vector(7 downto 0);
    signal rx_valid  : std_logic;
    signal busy      : std_logic;

begin

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- DUT Instantiation (TX)
    uart_tx_inst : entity work.uart_tx
        port map (
            clk      => clk,
            tx_start => tx_start,
            data_in  => tx_data,
            tx_line  => tx_line,
            busy     => busy
        );

    -- DUT Instantiation (RX)
    uart_rx_inst : entity work.uart_rx
        port map (
            clk      => clk,
            rx_line  => tx_line,
            rx_data  => rx_data,
            rx_valid => rx_valid
        );

    -- Stimulus
    stimulus : process
    begin
        wait for 100 ns;
        tx_start <= '1';
        wait for CLK_PERIOD;
        tx_start <= '0';

        -- Wait long enough for transmission to complete (approx 10 bits @ 9600 baud = ~1.04ms)
        wait for 1.5 ms;


        wait;
    end process;

end Behavioral;
