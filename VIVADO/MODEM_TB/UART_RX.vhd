library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_rx is
    Port (
        clk       : in  std_logic;
        rx_line   : in  std_logic;
        rx_data   : out std_logic_vector(7 downto 0);
        rx_valid  : out std_logic
    );
end uart_rx;

architecture Behavioral of uart_rx is
    constant CLK_FREQ    : integer := 100_000_000; -- Hz
    constant BAUD_RATE   : integer := 9600;
    constant BIT_PERIOD  : integer := CLK_FREQ / BAUD_RATE;
    constant SAMPLE_POINT: integer := BIT_PERIOD / 2;

    type rx_state_type is (IDLE, START_BIT, DATA_BITS, STOP_BIT);
    signal rx_state    : rx_state_type := IDLE;
    signal bit_index   : integer range 0 to 7 := 0;
    signal rx_shift    : std_logic_vector(7 downto 0) := (others => '0');
    signal rx_counter  : integer := 0;
    signal rx_valid_reg: std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            rx_valid_reg <= '0';
            case rx_state is
                when IDLE =>
                    if rx_line = '0' then  -- detect start bit
                        rx_state <= START_BIT;
                        rx_counter <= 0;
                    end if;

                when START_BIT =>
                    rx_counter <= rx_counter + 1;
                    if rx_counter = SAMPLE_POINT then
                        rx_counter <= 0;
                        rx_state <= DATA_BITS;
                        bit_index <= 0;
                    end if;

                when DATA_BITS =>
                    rx_counter <= rx_counter + 1;
                    if rx_counter = BIT_PERIOD then
                        rx_counter <= 0;
                        rx_shift(bit_index) <= rx_line;
                        bit_index <= bit_index + 1;
                        if bit_index = 7 then
                            rx_state <= STOP_BIT;
                        end if;
                    end if;

                when STOP_BIT =>
                    rx_counter <= rx_counter + 1;
                    if rx_counter = BIT_PERIOD then
                        rx_counter <= 0;
                        rx_data <= rx_shift;
                        rx_valid_reg <= '1';
                        rx_state <= IDLE;
                    end if;
            end case;
        end if;
    end process;

    rx_valid <= rx_valid_reg;

end Behavioral;
