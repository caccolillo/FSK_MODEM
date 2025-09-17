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
    S_AXIS_DATA_0_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXIS_DATA_0_tvalid : in STD_LOGIC;
    aclk_0 : in STD_LOGIC;
    received_bit : out STD_LOGIC    
  );
  end component;
  
  

  component sinewave_generator is
    Port (
        clk               : in  std_logic;
        frequency_setting : in  std_logic_vector(7 downto 0); -- 8-bit frequency control
        sine_out          : out std_logic_vector(15 downto 0); -- 16-bit sine wave output
        cosine_out        : out std_logic_vector(15 downto 0) -- 16-bit sine wave output
    );
  end component;  

  -- Signals
  signal en_lfsr                                    : std_logic := '0';
  signal en_fsk                                     : std_logic := '0';
  signal clk                                        : std_logic := '0';
  signal rst                                        : std_logic := '1';
  signal start                                      : std_logic := '1';
  signal FSK_modulated_data                         : std_logic_vector(31 downto 0) := (others => '0');
  signal fsk_demodulated_data_out                   : std_logic_vector(0 to 0);
  signal lfsr_reg                                   : std_logic_vector(31 downto 0)   := (others => '1');  -- Non-zero seed
  signal fsk_modulated_data_out                     : std_logic_vector ( 15 downto 0 );
  signal frequency_setting                          : std_logic_vector(7 downto 0); -- 8-bit frequency control
  signal sine_out                                   : std_logic_vector(15 downto 0); -- 16-bit sine wave output
  signal cosine_out                                 : std_logic_vector(15 downto 0); -- 16-bit sine wave output
    
  -- Constants
  constant CLK_PERIOD                               : time := 10 ns; -- 100 MHz

begin


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

  en_lfsr_proc:process
  begin
    for i in 0 to 32000 loop  --64000 32000
      wait until rising_edge(clk); 
    end loop;
    en_lfsr <= '1';
    wait until rising_edge(clk); 
    en_lfsr <= '0';  
  end process;

  en_fsk_proc:process
  begin
    for i in 0 to 16 loop
      wait until rising_edge(clk); 
    end loop;
    en_fsk <= '1';
    wait until rising_edge(clk); 
    en_fsk <= '0';  
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
        lfsr_reg <= x"f1ff1ff1";  -- Reset to non-zero value
      elsif rising_edge(clk) then
        if(en_lfsr = '1')then
          -- Polynomial: x^32 + x^22 + x^2 + x^1 + 1 (tap positions: 32,22,2,1)
          -- Feedback is XOR of taps
          lfsr_reg <= lfsr_reg(30 downto 0) & (lfsr_reg(31) xor lfsr_reg(21) xor lfsr_reg(1) xor lfsr_reg(0));
        end if;                  
    end if;
  end process;  
    
  frequency_setting <= x"0c" when (lfsr_reg(0) = '1') else x"17";
    
  sinewave_generator_inst:sinewave_generator 
  Port map(
    clk                 => clk,
    frequency_setting   => frequency_setting,
    sine_out            => sine_out,
    cosine_out          => cosine_out
  );

  --FSK_modulated_data <= std_logic_vector(resize(unsigned(sine_out(15 downto 7)), 16)) & std_logic_vector(resize(unsigned(cosine_out(15 downto 7)), 16));
  FSK_modulated_data <= sine_out & cosine_out;
 
 
 
   -- UUT instantiation
  design_1_wrapper_inst:design_1_wrapper
    port map(
      S_AXIS_DATA_0_tdata => FSK_modulated_data,
      S_AXIS_DATA_0_tvalid => '1',
      aclk_0 => clk,
      received_bit => open
    );
 
    
end sim;