LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY shift_add_tb IS
END shift_add_tb;

ARCHITECTURE behavior OF shift_add_tb IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT shift_add
    PORT(
        clk      : IN  std_logic;
        reset    : IN  std_logic;
        input3   : IN  std_logic_vector(3 downto 0);
        output32 : OUT std_logic_vector(23 downto 0)
    );
    END COMPONENT;
    
    -- Inputs
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal input3  : std_logic_vector(3 downto 0) := (others => '0');
    
    -- Outputs
    signal output32 : std_logic_vector(23 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;
 
BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: shift_add PORT MAP (
        clk      => clk,
        reset    => reset,
        input3   => input3,
        output32 => output32
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
        -- hold reset state for 100 ns.
        reset <= '1';
        wait for clk_period;  
        reset <= '0';
        wait for clk_period;

        -- Input stimulus
        input3 <= "1001"; -- Example input: 2 with valid data flag
        wait for 10 ns;

        input3 <= "1010"; -- Example input: 4 with valid data flag
        wait for 10 ns;

        input3 <= "1011"; -- Example input: 5 with valid data flag
        wait for 10 ns;

        input3 <= "1100"; -- Example input: 7 with valid data flag
        wait for 10 ns;

        input3 <= "1101"; -- Example input: 8 with valid data flag
        wait for 10 ns;

        input3 <= "1000"; -- Example input: 1 with valid data flag
        wait for 10 ns;

        input3 <= "1010"; -- Example input: 4 with valid data flag
        wait for 10 ns;

        input3 <= "1110"; -- Example input: * with valid data flag
        wait for 10 ns;

        input3 <= "1111"; -- Example input: 0 with valid data flag
        wait for 10 ns;

        input3 <= "1000"; -- Example input: 8 with valid data flag
        wait for 10 ns;

        input3 <= "0001"; -- Example input: 8 with valid data flag
        wait for 10 ns;

        input3 <= "1001"; -- Example input: 2 with valid data flag
        wait for 10 ns;

        input3 <= "1010"; -- Example input: 4 with valid data flag
        wait for 10 ns;

        input3 <= "1011"; -- Example input: 5 with valid data flag
        wait for 10 ns;

        input3 <= "1100"; -- Example input: 7 with valid data flag
        wait for 10 ns;

        input3 <= "1101"; -- Example input: 8 with valid data flag
        wait for 10 ns;

        input3 <= "1000"; -- Example input: 1 with valid data flag
        wait for 10 ns;

        input3 <= "1010"; -- Example input: 4 with valid data flag
        wait for 10 ns;

        input3 <= "1000"; -- Example input: 1 with valid data flag
        wait for 10 ns;

        input3 <= "1010"; -- Example input: 4 with valid data flag
        wait for 10 ns;

        -- Check outputs or add more inputs as needed
        wait;
    end process;
END behavior;
