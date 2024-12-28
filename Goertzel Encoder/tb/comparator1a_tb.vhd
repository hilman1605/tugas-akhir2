library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Needed for unsigned comparisons

entity comparator1a_tb is
end comparator1a_tb;

architecture behavioral of comparator1a_tb is
  signal clk, rst : std_logic := '0';
  signal input1, input2 : std_logic_vector(15 downto 0);
  signal output1a : std_logic_vector(15 downto 0);
  signal code : std_logic_vector(2 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: entity work.comparator1a
    port map (
      clk => clk,
      rst => rst,
      input1 => input1,
      input2 => input2,
      output1a => output1a,
      code => code
    );

  -- Clock process definitions
  clk_process :process
  begin
    clk <= '1';
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    -- Reset the design
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait for 10 ns;

    -- Test cases
    input1 <= x"0001"; input2 <= x"0002"; wait for 10 ns;  --input2 > input1
    input1 <= x"0003"; input2 <= x"0002"; wait for 10 ns;  --input1 > input2
    input1 <= x"0012"; input2 <= x"0012"; wait for 10 ns;  --input1 = input2
    input1 <= x"0183"; input2 <= x"0132"; wait for 10 ns;  --input1 > input2
    input1 <= x"0011"; input2 <= x"0111"; wait for 10 ns;  --input2 > input1
    
    wait;
  end process;

end behavioral;
