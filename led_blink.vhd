library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_blink is
    Port ( i_clock : in STD_LOGIC;
           i_enable : in STD_LOGIC;
           i_switch1 : in STD_LOGIC;
           i_switch2 : in STD_LOGIC;
           o_led : out STD_LOGIC);
end led_blink;

architecture Behavioral of led_blink is

  -- Constants to create the frequencies needed:
  -- Formula is: (25 MHz / 100 Hz * 50% duty cycle)
  -- Here we use 25 Mhz because that's what is used in the simulation
  -- So for 100 Hz: 25,000,000 / 100 * 0.5 = 125,000
  constant MAX_COUNTER_100HZ : natural := 125000;
  constant MAX_COUNTER_50HZ  : natural := 250000;
  constant MAX_COUNTER_10HZ  : natural := 1250000;
  constant MAX_COUNTER_1HZ   : natural := 12500000;
 
 
  -- These signals will be the counters that are incremented at each clock edge:
  signal COUNTER_100HZ : natural range 0 to MAX_COUNTER_100HZ;
  signal COUNTER_50HZ  : natural range 0 to MAX_COUNTER_50HZ;
  signal COUNTER_10HZ  : natural range 0 to MAX_COUNTER_10HZ;
  signal COUNTER_1HZ   : natural range 0 to MAX_COUNTER_1HZ;
   
  -- These signals will toggle the LED frequencies which the user choosed:
  signal TOGGLE_100HZ : std_logic := '0';
  signal TOGGLE_50HZ  : std_logic := '0';
  signal TOGGLE_10HZ  : std_logic := '0';
  signal TOGGLE_1HZ   : std_logic := '0';
 
  -- One bit select wire that is use to power on/off LED.
  signal w_LED_SELECT : std_logic;
   
begin
 
  -- All processes toggle a specific signal at a different frequency.
  -- They all run continuously even if the switches are
  -- not selecting their particular output.
   
  p_100_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if COUNTER_100HZ = MAX_COUNTER_100HZ - 1 then  -- -1, since counter starts at 0
        TOGGLE_100HZ <= not TOGGLE_100HZ;
        COUNTER_100HZ <= 0;
      else
        COUNTER_100HZ <= COUNTER_100HZ + 1;
      end if;
    end if;
  end process p_100_HZ;
  
  p_50_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if COUNTER_50HZ = MAX_COUNTER_50HZ - 1 then
        TOGGLE_50HZ <= not TOGGLE_50HZ;
        COUNTER_50HZ <= 0;
      else
        COUNTER_50HZ <= COUNTER_50HZ + 1;
      end if;
    end if;
  end process p_50_HZ;

  p_10_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if COUNTER_10HZ = MAX_COUNTER_10HZ - 1 then
        TOGGLE_10HZ <= not TOGGLE_10HZ;
        COUNTER_10HZ <= 0;
      else
        COUNTER_10HZ <= COUNTER_10HZ + 1;
      end if;
    end if;
  end process p_10_HZ;

  p_1_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if COUNTER_1HZ = MAX_COUNTER_1HZ - 1 then
        TOGGLE_1HZ <= not TOGGLE_1HZ;
        COUNTER_1HZ <= 0;
      else
        COUNTER_1HZ <= COUNTER_1HZ + 1;
      end if;
    end if;
  end process p_1_HZ;

  -- Create a multiplexor based on switch inputs
  w_LED_SELECT <=
    TOGGLE_100HZ when (i_switch1 = '0' and i_switch2 = '0') else
    TOGGLE_50HZ  when (i_switch1 = '0' and i_switch2 = '1') else
    TOGGLE_10HZ  when (i_switch1 = '1' and i_switch2 = '0') else
    TOGGLE_1HZ;


  -- Only allow o_led to drive when i_enable is high (and gate).
  o_led <= w_LED_SELECT and i_enable;


end Behavioral;
