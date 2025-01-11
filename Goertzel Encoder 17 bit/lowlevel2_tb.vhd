library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lowlevel2_tb is
-- Testbench does not have any ports
end lowlevel2_tb;

architecture Behavioral of lowlevel2_tb is

    -- Component Declaration of the Unit Under Test (UUT)
    component lowlevel2
        Port (
            clk, rst        : in  STD_LOGIC;
            in_valid    : in STD_LOGIC;
            out_ready   : in STD_LOGIC;
            out_valid   : out STD_LOGIC;
            corr_697        : in STD_LOGIC_VECTOR(16 downto 0);
            corr_770        : in STD_LOGIC_VECTOR(16 downto 0);
            corr_852        : in STD_LOGIC_VECTOR(16 downto 0);
            corr_941        : in STD_LOGIC_VECTOR(16 downto 0);
            codelow         : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal clk         : STD_LOGIC := '0';
    signal rst         : STD_LOGIC := '0';
    signal in_valid      : STD_LOGIC := '0';
    signal out_ready     : STD_LOGIC := '0';
    signal out_valid     : STD_LOGIC;
    signal corr_697    : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal corr_770    : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal corr_852    : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal corr_941    : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
    signal codelow     : STD_LOGIC_VECTOR(2 downto 0);

    -- Clock period definition
    constant clk_period : time := 20 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: lowlevel2
        Port map (
            clk => clk,
            rst => rst,
            in_valid        => in_valid,
            out_ready       => out_ready,
            out_valid       => out_valid,
            corr_697 => corr_697,
            corr_770 => corr_770,
            corr_852 => corr_852,
            corr_941 => corr_941,
            codelow => codelow
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset sequence
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        
        -- Test Case 1: corr_697 has the highest value
        corr_697 <= "00000000000001111";
        corr_770 <= "00000000000000001";
        corr_852 <= "00000000000000010";
        corr_941 <= "00000000000000000";
        in_valid <= '1';
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period; -- Wait for one clock cycle
        in_valid <= '0';
        wait for clk_period; -- Wait for another clock cycle
        out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        
        -- Test Case 2: corr_770 has the highest value
        corr_697 <= "00000000000000011";
        corr_770 <= "00000000000010010";
        corr_852 <= "00000000000000001";
        corr_941 <= "00000000000000011";
        in_valid <= '1';
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period; -- Wait for one clock cycle
        in_valid <= '0';
        wait for clk_period; -- Wait for another clock cycle
        out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        
        -- Test Case 3: corr_852 has the highest value
        corr_697 <= "00000000000000011";
        corr_770 <= "00000000000000010";
        corr_852 <= "00000000000001001";
        corr_941 <= "00000000000000011";
        in_valid <= '1';
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period; -- Wait for one clock cycle
        in_valid <= '0';
        wait for clk_period; -- Wait for another clock cycle
        out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        
        -- Test Case 4: corr_941 has the highest value
        corr_697 <= "00000000000000011";
        corr_770 <= "00000000000000010";
        corr_852 <= "00000000000000001";
        corr_941 <= "00000000000100011";
        in_valid <= '1';
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period; -- Wait for one clock cycle
        in_valid <= '0';
        wait for clk_period; -- Wait for another clock cycle
        out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        
        -- Test Case 2: corr_770 has the highest value
        corr_697 <= "00000000000000011";
        corr_770 <= "00000000000010010";
        corr_852 <= "00000000000000001";
        corr_941 <= "00000000000000011";
        in_valid <= '1';
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period; -- Wait for one clock cycle
        in_valid <= '0';
        wait for clk_period; -- Wait for another clock cycle
        out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        
        -- Test Case 3: corr_852 has the highest value
        corr_697 <= "00000000000000011";
        corr_770 <= "00000000000000010";
        corr_852 <= "00000000000001001";
        corr_941 <= "00000000000000011";
        in_valid <= '1';
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period; -- Wait for one clock cycle
        in_valid <= '0';
        wait for clk_period; -- Wait for another clock cycle
        out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        out_ready <= '0'; -- Reset out_ready to '0'
        wait for clk_period;
        

        -- End simulation
        wait;
    end process;

end Behavioral;
