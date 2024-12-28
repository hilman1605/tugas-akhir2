LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY topdecision_tb IS
END topdecision_tb;

ARCHITECTURE behavior OF topdecision_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT topdecision
    PORT(
        clk : IN  std_logic;
        rst : IN  std_logic;
        corr_697 : IN  std_logic_vector(15 downto 0);
        corr_770 : IN  std_logic_vector(15 downto 0);
        corr_852 : IN  std_logic_vector(15 downto 0);
        corr_941 : IN  std_logic_vector(15 downto 0);
        corr_1209 : IN  std_logic_vector(15 downto 0);
        corr_1336 : IN  std_logic_vector(15 downto 0);
        corr_1477 : IN  std_logic_vector(15 downto 0);
        code_dtmf : OUT  std_logic_vector(3 downto 0)
    );
    END COMPONENT;

    --Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal corr_697 : std_logic_vector(15 downto 0) := (others => '0');
    signal corr_770 : std_logic_vector(15 downto 0) := (others => '0');
    signal corr_852 : std_logic_vector(15 downto 0) := (others => '0');
    signal corr_941 : std_logic_vector(15 downto 0) := (others => '0');
    signal corr_1209 : std_logic_vector(15 downto 0) := (others => '0');
    signal corr_1336 : std_logic_vector(15 downto 0) := (others => '0');
    signal corr_1477 : std_logic_vector(15 downto 0) := (others => '0');

    --Outputs
    signal code_dtmf : std_logic_vector(3 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: topdecision PORT MAP (
        clk => clk,
        rst => rst,
        corr_697 => corr_697,
        corr_770 => corr_770,
        corr_852 => corr_852,
        corr_941 => corr_941,
        corr_1209 => corr_1209,
        corr_1336 => corr_1336,
        corr_1477 => corr_1477,
        code_dtmf => code_dtmf
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
        -- hold reset state for 10 ns.
        rst <= '1';
        wait for 10 ns;  
        rst <= '0';
        
        -- Initialize Inputs
        corr_697 <= (others => '0');
        corr_770 <= (others => '0');
        corr_852 <= (others => '0');
        corr_941 <= (others => '0');
        corr_1209 <= (others => '0');
        corr_1336 <= (others => '0');
        corr_1477 <= (others => '0');

        -- Wait for global reset to finish
        wait for 10 ns;

        -- Stimulate inputs for different DTMF tones
        -- Simulating DTMF Tone '1'
        corr_697 <= "0000000000001001";
        corr_770 <= "0000000000000011";
        corr_852 <= "0000000000000011";
        corr_941 <= "0000000000000001";
        corr_1209 <= "0000000000001001";
        corr_1336 <= "0000000000000011";
        corr_1477 <= "0000000000000011";
        wait for 10 ns;

        -- Simulating DTMF Tone '2'
        corr_697 <= "0000000000001101";
        corr_770 <= "0000000000000001";
        corr_852 <= "0000000000000001";
        corr_941 <= "0000000000000011";
        corr_1209 <= "0000000000000011";
        corr_1336 <= "0000000000001001";
        corr_1477 <= "0000000000000111";
        wait for 10 ns;

        -- Simulating DTMF Tone '3'
        corr_697 <= "0000000001000011";
        corr_770 <= "0000000000000001";
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000111";
        corr_1209 <= "0000000000000111";
        corr_1336 <= "0000000000000101";
        corr_1477 <= "0000000000001001";
        wait for 10 ns;

        -- Simulating DTMF Tone '4'
        corr_697 <= "0000000000000011";
        corr_770 <= "0000000000001001";
        corr_852 <= "0000000000000001";
        corr_941 <= "0000000000000101";
        corr_1209 <= "0000000000001001";
        corr_1336 <= "0000000000000001";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Simulating DTMF Tone '5'
        corr_697 <= "0000000000000001";
        corr_770 <= "0000000000001011";
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000001";
        corr_1209 <= "0000000000000011";
        corr_1336 <= "0000000000001001";
        corr_1477 <= "0000000000000001";
        wait for 10 ns;

        -- Simulating DTMF Tone '6'
        corr_697 <= "0000000000000011";
        corr_770 <= "0000000010000111";
        corr_852 <= "0000000000001001";
        corr_941 <= "0000000000000101";
        corr_1209 <= "0000000000000111";
        corr_1336 <= "0000000000000001";
        corr_1477 <= "0000000000001001";
        wait for 10 ns;

        -- Simulating DTMF Tone '7'
        corr_697 <= "0000000000001001";
        corr_770 <= "0000000000000001";
        corr_852 <= "0000100000000011";
        corr_941 <= "0000000000000111";
        corr_1209 <= "0001000000000001";
        corr_1336 <= "0000000000001001";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Simulating DTMF Tone '8'
        corr_697 <= "0000000000000011";
        corr_770 <= "0000000000001001";
        corr_852 <= "0000010000000001";
        corr_941 <= "0000000000000011";
        corr_1209 <= "0000000000000001";
        corr_1336 <= "0000000000001101";
        corr_1477 <= "0000000000000110";
        wait for 10 ns;

        -- Simulating DTMF Tone '9'
        corr_697 <= "0000000000000001";
        corr_770 <= "0000000000000010";
        corr_852 <= "0000010000001001";
        corr_941 <= "0000000000000010";
        corr_1209 <= "0000000000000011";
        corr_1336 <= "0000000000001001";
        corr_1477 <= "0000100000000010";
        wait for 10 ns;

        -- Simulating DTMF Tone '*'
        corr_697 <= "0000000000000011";
        corr_770 <= "0000000000000110";
        corr_852 <= "0000010000001001";
        corr_941 <= "0010000000000010";
        corr_1209 <= "0000100000000001";
        corr_1336 <= "0000000000001011";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Simulating DTMF Tone '0'
        corr_697 <= "0000000000000001";
        corr_770 <= "0000000000000010";
        corr_852 <= "0000010000001011";
        corr_941 <= "0001000000000010";
        corr_1209 <= "0000000000000001";
        corr_1336 <= "0001000000001001";
        corr_1477 <= "0000000000000011";
        wait for 10 ns;

        -- Simulating DTMF Tone '#'
        corr_697 <= "0000000000000011";
        corr_770 <= "0000000000000110";
        corr_852 <= "0000000000001001";
        corr_941 <= "0000010000000010";
        corr_1209 <= "0000000000000011";
        corr_1336 <= "0000000000001001";
        corr_1477 <= "0000100000000010";
        wait for 10 ns;

        -- Complete the simulation
        wait;
    end process;


END behavior;