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
    signal tx_start_0 : std_logic;
    signal fsk_demodulated_data_out : std_logic_vector(0 DOWNTO 0);
    signal start      : std_logic:='0';


  component design_1_wrapper is
    port (
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      start : in STD_LOGIC;
      FSK_modulated_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
      fsk_modulated_data_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
      tx_start_0 : in STD_LOGIC;
      busy_0 : out STD_LOGIC;
      data_in_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
      rx_valid_0 : out STD_LOGIC;
      rx_data_0 : out STD_LOGIC_VECTOR ( 7 downto 0 )
    );   
  end component;

  component design_1_wrapper_0
    PORT (
      FSK_modulated_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      clk : IN STD_LOGIC;
      fsk_binary_modulating_data_in : IN STD_LOGIC;
      fsk_demodulated_data_out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      fsk_modulated_data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      rst : IN STD_LOGIC;
      start : IN STD_LOGIC 
    );
  end component;

  signal fsk_modulated_data_out : std_logic_vector ( 15 downto 0 );
  signal FSK_modulated_data     : std_logic_vector(31 downto 0) := (others => '0');  
  signal rst                    : std_logic := '1';
  
  
  
begin

  FSK_modulated_data <= std_logic_vector(resize(unsigned(fsk_modulated_data_out(15 downto 3)), 32));



  design_1_wrapper_inst : design_1_wrapper_0
  PORT MAP (
    FSK_modulated_data => FSK_modulated_data,
    clk => clk,
    fsk_binary_modulating_data_in => tx_line,
    fsk_demodulated_data_out => fsk_demodulated_data_out,
    fsk_modulated_data_out => fsk_modulated_data_out,
    rst => rst,
    start => start
  );

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
      rx_line  => fsk_demodulated_data_out(0),
      rx_data  => rx_data,
      rx_valid => rx_valid
    );

  -- Stimulus
  stimulus : process
  begin
    
    wait for CLK_PERIOD * 1; -- allow some initial delay

    -- Reset active for first 50 clock cycles
    wait for CLK_PERIOD * 50;
    rst <= '0';

    wait for CLK_PERIOD;    
    
    
    wait for 100 ns;
    tx_start <= '1';
    wait for CLK_PERIOD;
    tx_start <= '0';
    wait for CLK_PERIOD;
    start <= '1';
    
    -- Wait long enough for transmission to complete (approx 10 bits @ 9600 baud = ~1.04ms)
    wait for 1.5 ms;


    wait;
  end process;

end Behavioral;



