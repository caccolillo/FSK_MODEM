library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Port (
        clk      : in  std_logic;
        tx_start : in  std_logic;
        data_in  : in  std_logic_vector(7 downto 0);
        tx_line  : out std_logic;
        busy     : out std_logic
    );
end uart_tx;

architecture Behavioral of uart_tx is
    constant CLK_FREQ   : integer := 100_000_000; -- Hz
    constant BAUD_RATE  : integer := 9600;
    constant BIT_PERIOD : integer := CLK_FREQ / BAUD_RATE;

    type tx_state_type is (IDLE, START_BIT, DATA_BITS, STOP_BIT);
    signal tx_state   : tx_state_type := IDLE;
    signal tx_counter : integer := 0;
    signal bit_index  : integer range 0 to 7 := 0;
    signal tx_buffer  : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_reg     : std_logic := '1';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            case tx_state is
                when IDLE =>
                    tx_reg <= '1';
                    busy <= '0';
                    if tx_start = '1' then
                        tx_buffer <= data_in;
                        tx_state <= START_BIT;
                        tx_counter <= 0;
                        busy <= '1';
                    end if;

                when START_BIT =>
                    tx_reg <= '0'; -- start bit
                    tx_counter <= tx_counter + 1;
                    if tx_counter = BIT_PERIOD then
                        tx_counter <= 0;
                        tx_state <= DATA_BITS;
                        bit_index <= 0;
                    end if;

                when DATA_BITS =>
                    tx_reg <= tx_buffer(bit_index);
                    tx_counter <= tx_counter + 1;
                    if tx_counter = BIT_PERIOD then
                        tx_counter <= 0;
                        bit_index <= bit_index + 1;
                        if bit_index = 7 then
                            tx_state <= STOP_BIT;
                        end if;
                    end if;

                when STOP_BIT =>
                    tx_reg <= '1'; -- stop bit
                    tx_counter <= tx_counter + 1;
                    if tx_counter = BIT_PERIOD then
                        tx_counter <= 0;
                        tx_state <= IDLE;
                    end if;
            end case;
        end if;
    end process;

    tx_line <= tx_reg;

end Behavioral;
