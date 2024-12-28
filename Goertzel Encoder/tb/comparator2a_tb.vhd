library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Needed for unsigned comparisons

entity comparator2a_tb is
end comparator2a_tb;

architecture Behavioral of comparator2a_tb is
    signal clk, rst : STD_LOGIC := '0';
    signal input1, input2 : STD_LOGIC_VECTOR(15 downto 0);
    signal code_A, code_B, code_out : STD_LOGIC_VECTOR(2 downto 0);

    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.comparator2a
        port map (
            clk => clk,
            rst => rst,
            input1 => input1,
            input2 => input2,
            code_A => code_A,
            code_B => code_B,
            code_out => code_out
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
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

        -- Test cases
        input1 <= x"0001"; input2 <= x"0002"; code_A <= "001"; code_B <= "010"; wait for clk_period;  --input2 > input1
        input1 <= x"0012"; input2 <= x"0011"; code_A <= "100"; code_B <= "101"; wait for clk_period; --input1 > input2
        input1 <= x"0017"; input2 <= x"0017"; code_A <= "110"; code_B <= "111"; wait for clk_period; --input1 = input2
        input1 <= x"0012"; input2 <= x"0010"; code_A <= "011"; code_B <= "001"; wait for clk_period; --input1 > input2

        wait;
    end process;

end Behavioral;
