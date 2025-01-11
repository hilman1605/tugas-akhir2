library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Needed for unsigned comparisons

entity comparator1a_tb is
end comparator1a_tb;

architecture behavioral of comparator1a_tb is
  signal clk, rst : std_logic := '0';
  signal in_valid      : STD_LOGIC := '0';
  signal out_ready     : STD_LOGIC := '0';
  signal out_valid     : STD_LOGIC;
  signal input1, input2 : std_logic_vector(16 downto 0);
  signal output1a : std_logic_vector(16 downto 0);
  signal code : std_logic_vector(2 downto 0);

  constant clk_period : time := 20 ns;


begin

  -- Instantiate the Unit Under Test (UUT)
  uut: entity work.comparator1a
    port map (
      clk => clk,
      rst => rst,
      in_valid        => in_valid,
      out_ready       => out_ready,
      out_valid       => out_valid,
      input1 => input1,
      input2 => input2,
      output1a => output1a,
      code => code
    );

  -- Clock process definitions
  clk_process :process
  begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    -- Reset the design
    rst <= '1';
    wait for clk_period/2;
    rst <= '0';
    wait for clk_period/2;


    input1 <= "00000000000001111";
    input2 <= "00000000000000001";
    -- corr_852 <= "00000000000000010";
    -- corr_941 <= "00000000000000000";
    in_valid <= '1';
    out_ready <= '0'; -- Reset out_ready to '0'
    wait for clk_period; -- Wait for one clock cycle
    in_valid <= '0';
    wait for clk_period; -- Wait for another clock cycle
    out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
    wait for clk_period;
    
    -- Test Case 2: input2 has the highest value
    input1 <= "00000000000000011";
    input2 <= "00000000000010010";
    -- corr_852 <= "00000000000000001";
    -- corr_941 <= "00000000000000011";
    in_valid <= '1';
    out_ready <= '0'; -- Reset out_ready to '0'
    wait for clk_period; -- Wait for one clock cycle
    in_valid <= '0';
    wait for clk_period; -- Wait for another clock cycle
    out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
    wait for clk_period;
    
    -- Test Case 3: -- corr_852 has the highest value
    input1 <= "00000000000000011";
    input2 <= "00000000000000010";
    -- corr_852 <= "00000000000001001";
    -- corr_941 <= "00000000000000011";
    in_valid <= '1';
    out_ready <= '0'; -- Reset out_ready to '0'
    wait for clk_period; -- Wait for one clock cycle
    in_valid <= '0';
    wait for clk_period; -- Wait for another clock cycle
    out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
    wait for clk_period;

    -- Test Case 4: -- corr_941 has the highest value
    input1 <= "00000000000000011";
    input2 <= "00000000000000010";
    -- corr_852 <= "00000000000000001";
    -- corr_941 <= "00000000000100011";
    in_valid <= '1';
    out_ready <= '0'; -- Reset out_ready to '0'
    wait for clk_period; -- Wait for one clock cycle
    in_valid <= '0';
    wait for clk_period; -- Wait for another clock cycle
    out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
    wait for clk_period;

    -- Test Case 2: input2 has the highest value
    input1 <= "00000000000000011";
    input2 <= "00000000000010010";
    -- corr_852 <= "00000000000000001";
    -- corr_941 <= "00000000000000011";
    in_valid <= '1';
    out_ready <= '0'; -- Reset out_ready to '0'
    wait for clk_period; -- Wait for one clock cycle
    in_valid <= '0';
    wait for clk_period; -- Wait for another clock cycle
    out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
    wait for clk_period;
    
    -- Test Case 3: -- corr_852 has the highest value
    input1 <= "00000000000000011";
    input2 <= "00000000000000010";
    -- corr_852 <= "00000000000001001";
    -- corr_941 <= "00000000000000011";
    in_valid <= '1';
    out_ready <= '0'; -- Reset out_ready to '0'
    wait for clk_period; -- Wait for one clock cycle
    in_valid <= '0';
    wait for clk_period; -- Wait for another clock cycle
    out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
    wait for clk_period;

    
    wait;
  end process;

end behavioral;
