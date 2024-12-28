library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decision_tb is
end decision_tb;

architecture Behavioral of decision_tb is
    signal clk, rst : STD_LOGIC := '0';
    signal code_low, code_high : STD_LOGIC_VECTOR(2 downto 0);
    signal dtmf_code : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.decision
        port map (
            clk => clk,
            rst => rst,
            code_low => code_low,
            code_high => code_high,
            dtmf_code => dtmf_code
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the design
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

        -- Test cases -  covering all combinations
        code_low <= "001"; code_high <= "001"; wait for clk_period; --1
        code_low <= "001"; code_high <= "010"; wait for clk_period; --2
        code_low <= "010"; code_high <= "001"; wait for clk_period; --4
        code_low <= "010"; code_high <= "010"; wait for clk_period; --5
        code_low <= "011"; code_high <= "001"; wait for clk_period; --7
        code_low <= "011"; code_high <= "010"; wait for clk_period; --8
        code_low <= "100"; code_high <= "001"; wait for clk_period; --*
        code_low <= "100"; code_high <= "010"; wait for clk_period; --0

        -- Add test cases for invalid inputs (optional)
        code_low <= "111"; code_high <= "111"; wait for clk_period; --Invalid Input - Expecting "0000"
        code_low <= "000"; code_high <= "000"; wait for clk_period; --Invalid Input - Expecting "0000"


        wait;
    end process;

end Behavioral;
