library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity led_blink_tb is

end led_blink_tb;

architecture Behavioral of led_blink_tb is

  -- 25 MHz oscillator = 40 nanoseconds period
  constant c_CLOCK_PERIOD : time := 40 ns; 
 
  signal r_CLOCK     : std_logic := '0';
  signal r_ENABLE    : std_logic := '0';
  signal r_SWITCH_1  : std_logic := '0';
  signal r_SWITCH_2  : std_logic := '0';
  signal w_LED_DRIVE : std_logic; 
 
  -- Component declaration for the Unit Under Test (UUT)
  -- List port of led_blink source
  component led_blink is
    port (
      i_clock     : in  std_logic;
      i_enable    : in  std_logic;
      i_switch1  : in  std_logic;
      i_switch2  : in  std_logic;
      o_led : out std_logic);
  end component led_blink;
   
begin
 
  -- Instantiate the Unit Under Test (UUT)
  -- Map ports to signals so that the program can use them
  UUT : led_blink
    port map (
      i_clock     => r_CLOCK,
      i_enable    => r_ENABLE,
      i_switch1  => r_SWITCH_1,
      i_switch2  => r_SWITCH_2,
      o_led => w_LED_DRIVE
      );
 
  -- Clock waveform generation (rising edge)
  p_CLK_GEN : process is
  begin
    wait for c_CLOCK_PERIOD/2;
    r_CLOCK <= not r_CLOCK;
  end process p_CLK_GEN; 
   
  process                               -- main testing
  begin
    r_ENABLE <= '1'; -- enable LED
 
    -- 100Hz test
    r_SWITCH_1 <= '0';
    r_SWITCH_2 <= '0';
    wait for 0.2 sec;
 
    -- 50 Hz test
    r_SWITCH_1 <= '0';
    r_SWITCH_2 <= '1';
    wait for 0.2 sec;
 
    -- 10 Hz test
    r_SWITCH_1 <= '1';
    r_SWITCH_2 <= '0';
    wait for 0.5 sec;
 
    -- 1 Hz test
    r_SWITCH_1 <= '1';
    r_SWITCH_2 <= '1';
    wait for 2 sec;
     
  end process;


end Behavioral;
