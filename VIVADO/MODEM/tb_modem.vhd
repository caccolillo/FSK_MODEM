library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std.all;

entity tb_design_1_wrapper is
end tb_design_1_wrapper;

architecture sim of tb_design_1_wrapper is

  -- Component Declaration
  component design_1_wrapper
    port (
      FSK_modulated_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
      clk : in STD_LOGIC;
      fsk_binary_modulating_data_in : in STD_LOGIC;
      fsk_demodulated_data_out : out STD_LOGIC_VECTOR ( 0 to 0 );
      fsk_modulated_data_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
      rst : in STD_LOGIC;
      start : in STD_LOGIC
    );
  end component;

  -- Signals
  signal en                          : std_logic := '0';
  signal clk                         : std_logic := '0';
  signal rst                         : std_logic := '1';
  signal start                       : std_logic := '1';
  signal FSK_modulated_data          : std_logic_vector(31 downto 0) := (others => '0');
  signal fsk_demodulated_data_out    : std_logic_vector(0 to 0);
  signal lfsr_reg : std_logic_vector(31 downto 0) := (others => '1');  -- Non-zero seed
  signal fsk_modulated_data_out : STD_LOGIC_VECTOR ( 15 downto 0 );

  -- Constants
  constant CLK_PERIOD       : time := 10 ns; -- 100 MHz

begin

  -- DUT Instantiation
  uut: design_1_wrapper
    port map (
      FSK_modulated_data            => FSK_modulated_data,
      fsk_demodulated_data_out      => fsk_demodulated_data_out,
      clk                           => clk,
      rst                           => rst,
      start                         => start,
      fsk_binary_modulating_data_in => lfsr_reg(0),
      fsk_modulated_data_out        => fsk_modulated_data_out
    );

--FSK_modulated_data <= std_logic_vector(resize(signed(fsk_modulated_data_out), 32));
FSK_modulated_data <= std_logic_vector(resize(unsigned(fsk_modulated_data_out(15 downto 3)), 32));

  -- Clock generation (100 MHz)
  clk_process : process
  begin
    while true loop
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  en_proc:process
  begin
    for i in 0 to 80000 loop
      wait until rising_edge(clk); 
    end loop;
    en <= '1';
    wait until rising_edge(clk); 
    en <= '0';  
  end process;


  -- Stimulus process
  stim_proc : process
    variable cycle_count       : integer := 0;
    variable start_cycle_count : integer := 0;
    variable start_count       : integer := 0;
    variable square_state      : boolean := false;
  begin
    wait for CLK_PERIOD * 1; -- allow some initial delay

    -- Reset active for first 50 clock cycles
    wait for CLK_PERIOD * 50;
    rst <= '0';

    wait for CLK_PERIOD;

    wait; -- End simulation
  end process;


    process(clk, rst)
    begin
        if rst = '1' then
            lfsr_reg <= x"00001000";  -- Reset to non-zero value
        elsif rising_edge(clk) then
          if(en = '1')then
                -- Polynomial: x^32 + x^22 + x^2 + x^1 + 1 (tap positions: 32,22,2,1)
                -- Feedback is XOR of taps
                lfsr_reg <= lfsr_reg(30 downto 0) & 
                            (lfsr_reg(31) xor lfsr_reg(21) xor lfsr_reg(1) xor lfsr_reg(0));
          end if;                  
        end if;
    end process;

end sim;
