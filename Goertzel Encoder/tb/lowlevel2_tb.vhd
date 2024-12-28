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
            corr_697        : in STD_LOGIC_VECTOR(15 downto 0);
            corr_770        : in STD_LOGIC_VECTOR(15 downto 0);
            corr_852        : in STD_LOGIC_VECTOR(15 downto 0);
            corr_941        : in STD_LOGIC_VECTOR(15 downto 0);
            codelow         : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal clk         : STD_LOGIC := '0';
    signal rst         : STD_LOGIC := '0';
    signal corr_697    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_770    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_852    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_941    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal codelow     : STD_LOGIC_VECTOR(2 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: lowlevel2
        Port map (
            clk => clk,
            rst => rst,
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
        wait for 20 ns;
        rst <= '0';
        
        -- Test Case 1: corr_697 has the highest value
        corr_697 <= x"000F";
        corr_770 <= x"0008";
        corr_852 <= x"0004";
        corr_941 <= x"0002";
        wait for 10 ns;
        
        -- Test Case 2: corr_770 has the highest value
        corr_697 <= x"0003";
        corr_770 <= x"0010";
        corr_852 <= x"0005";
        corr_941 <= x"0001";
        wait for 10 ns;
        
        -- Test Case 3: corr_852 has the highest value
        corr_697 <= x"0002";
        corr_770 <= x"0003";
        corr_852 <= x"0015";
        corr_941 <= x"0007";
        wait for 10 ns;

        -- Test Case 4: corr_941 has the highest value
        corr_697 <= x"0001";
        corr_770 <= x"0003";
        corr_852 <= x"0005";
        corr_941 <= x"0020";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
