library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity highlevel2_tb is
-- Testbench tidak memiliki port input/output
end highlevel2_tb;

architecture Behavioral of highlevel2_tb is

    -- Component declaration of the DUT (Design Under Test)
    component highlevel2 is
        Port (
            clk, rst        : in  STD_LOGIC;
            corr_1209       : in STD_LOGIC_VECTOR(15 downto 0);
            corr_1336       : in STD_LOGIC_VECTOR(15 downto 0);
            corr_1477       : in STD_LOGIC_VECTOR(15 downto 0);
            codehigh        : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals to connect to the DUT
    signal clk         : STD_LOGIC := '0';
    signal rst         : STD_LOGIC := '0';
    signal corr_1209   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_1336   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_1477   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal codehigh    : STD_LOGIC_VECTOR(2 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the DUT
    uut: highlevel2
        port map (
            clk         => clk,
            rst         => rst,
            corr_1209   => corr_1209,
            corr_1336   => corr_1336,
            corr_1477   => corr_1477,
            codehigh    => codehigh
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '1';
            wait for clk_period / 2;
            clk <= '0';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';
        
        -- Apply test stimulus
        corr_1209 <= X"000A"; -- Example input 1209 Hz correlation
        corr_1336 <= X"000F"; -- Example input 1336 Hz correlation
        corr_1477 <= X"0005"; -- Example input 1477 Hz correlation
        wait for 10 ns;

        corr_1209 <= X"0003";
        corr_1336 <= X"0008";
        corr_1477 <= X"000A";
        wait for 10 ns;

        corr_1209 <= X"0010";
        corr_1336 <= X"0006";
        corr_1477 <= X"000C";
        wait for 10 ns;

        -- Finish simulation
        wait;
    end process;

end Behavioral;
