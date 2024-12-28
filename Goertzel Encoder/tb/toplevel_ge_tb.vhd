library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toplevel_ge_tb is
end toplevel_ge_tb;

architecture behavior of toplevel_ge_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component toplevel_ge is
        Port (
            clk            : in  STD_LOGIC;
            rst            : in  STD_LOGIC;
            corr_697       : in  STD_LOGIC_VECTOR(15 downto 0);
            corr_770       : in  STD_LOGIC_VECTOR(15 downto 0);
            corr_852       : in  STD_LOGIC_VECTOR(15 downto 0);
            corr_941       : in  STD_LOGIC_VECTOR(15 downto 0);
            corr_1209      : in  STD_LOGIC_VECTOR(15 downto 0);
            corr_1336      : in  STD_LOGIC_VECTOR(15 downto 0);
            corr_1477      : in  STD_LOGIC_VECTOR(15 downto 0);
            encode_out     : out STD_LOGIC_VECTOR(23 downto 0)
        );
    end component;

    -- Signals for the UUT
    signal clk           : STD_LOGIC := '0';
    signal rst           : STD_LOGIC := '0';
    signal corr_697      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_770      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_852      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_941      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_1209     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_1336     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal corr_1477     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal encode_out    : STD_LOGIC_VECTOR(23 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: toplevel_ge
        Port map (
            clk => clk,
            rst => rst,
            corr_697 => corr_697,
            corr_770 => corr_770,
            corr_852 => corr_852,
            corr_941 => corr_941,
            corr_1209 => corr_1209,
            corr_1336 => corr_1336,
            corr_1477 => corr_1477,
            encode_out => encode_out
        );

    -- Clock process
    clk_process :process
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- Reset the design
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 1)
        corr_697 <= "0000000000001111"; -- signal for 697 Hz
        corr_770 <= "0000000000000001"; -- no 770 Hz
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000000";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000100";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Test Case 4: Set frequencies to 697 and 1336 Hz (DTMF 2)
        corr_697 <= "0000000000001111"; -- signal for 697 Hz
        corr_770 <= "0000000000000010";
        corr_852 <= "0000000000000001";
        corr_941 <= "0000000000000011";
        corr_1209 <= "0000000000000111";
        corr_1336 <= "0000000000001111"; -- signal for 1336 Hz
        corr_1477 <= "0000000000000011";
        wait for 10 ns;

        -- Test Case 5: Set frequencies to 770 and 1209 Hz (DTMF 4)
        corr_697 <= "0000000000000010"; 
        corr_770 <= "0000000000001111"; -- signal for 770 Hz
        corr_852 <= "0000000000001000";
        corr_941 <= "0000000000000100";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000110";
        corr_1477 <= "0000000000001000";
        wait for 10 ns;

        -- Test Case 2: Set frequencies to 770 and 1336 Hz (DTMF 5)
        corr_697 <= "0000000000000011"; 
        corr_770 <= "0000000000001111"; -- signal for 770 Hz
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000001";
        corr_1209 <= "0000000000000110";
        corr_1336 <= "0000000000001111"; -- signal for 1336 Hz
        corr_1477 <= "0000000000000001";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 7)
        corr_697 <= "0000000000000010"; -- signal for 697 Hz
        corr_770 <= "0000000000000001"; -- no 770 Hz
        corr_852 <= "0000000000001111";
        corr_941 <= "0000000000000110";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000100";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Test Case 9: Set frequencies to 852 and 941 Hz (DTMF 8)
        corr_697 <= "0000000000000100"; 
        corr_770 <= "0000000000001100";
        corr_852 <= "0000000000001111"; -- signal for 852 Hz
        corr_941 <= "0000000000001100";
        corr_1209 <= "0000000000000100";
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001001";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF *)
        corr_697 <= "0000000000000100"; -- signal for 697 Hz
        corr_770 <= "0000000000000101"; -- no 770 Hz
        corr_852 <= "0000000000000110";
        corr_941 <= "0000000000001111";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000001100";
        corr_1477 <= "0000000000001011";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 0)
        corr_697 <= "0000000000000100"; -- signal for 697 Hz
        corr_770 <= "0000000000000101"; -- no 770 Hz
        corr_852 <= "0000000000000110";
        corr_941 <= "0000000000001111";
        corr_1209 <= "0000000000001100"; -- signal for 1209 Hz
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001010";
        wait for 10 ns;

        -- Test Case 8: Set frequencies to 770 and 1477 Hz (DTMF 6)
        -- corr_697 <= "0000000000000100"; 
        -- corr_770 <= "0000000000001111"; -- signal for 770 Hz
        -- corr_852 <= "0000000000000100";
        -- corr_941 <= "0000000000001100";
        -- corr_1209 <= "0000000000000001";
        -- corr_1336 <= "0000000000001001";
        -- corr_1477 <= "0000000000001111"; -- signal for 1477 Hz
        -- wait for 10 ns;

        -- Test Case 9: Set frequencies to 852 and 941 Hz (DTMF 8)
        corr_697 <= "0000000000000100"; 
        corr_770 <= "0000000000001100";
        corr_852 <= "0000000000001111"; -- signal for 852 Hz
        corr_941 <= "0000000000001100";
        corr_1209 <= "0000000000000100";
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001001";
        wait for 10 ns;

        -- Test Case 3: Set frequencies to 852 and 1477 Hz (DTMF 9)
        -- corr_697 <= "0000000000000001"; 
        -- corr_770 <= "0000000000000010";
        -- corr_852 <= "0000000000001111"; -- signal for 852 Hz
        -- corr_941 <= "0000000000000010";
        -- corr_1209 <= "0000000000000011";
        -- corr_1336 <= "0000000000000001";
        -- corr_1477 <= "0000000000001111"; -- signal for 1477 Hz
        -- wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 1)
        corr_697 <= "0000000000001111"; -- signal for 697 Hz
        corr_770 <= "0000000000000001"; -- no 770 Hz
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000000";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000100";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Test Case 4: Set frequencies to 697 and 1336 Hz (DTMF 2)
        corr_697 <= "0000000000001111"; -- signal for 697 Hz
        corr_770 <= "0000000000000010";
        corr_852 <= "0000000000000001";
        corr_941 <= "0000000000000011";
        corr_1209 <= "0000000000000111";
        corr_1336 <= "0000000000001111"; -- signal for 1336 Hz
        corr_1477 <= "0000000000000011";
        wait for 10 ns;

        -- Test Case 5: Set frequencies to 770 and 1209 Hz (DTMF 4)
        corr_697 <= "0000000000000010"; 
        corr_770 <= "0000000000001111"; -- signal for 770 Hz
        corr_852 <= "0000000000001000";
        corr_941 <= "0000000000000100";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000110";
        corr_1477 <= "0000000000001000";
        wait for 10 ns;

        -- Test Case 2: Set frequencies to 770 and 1336 Hz (DTMF 5)
        corr_697 <= "0000000000000011"; 
        corr_770 <= "0000000000001111"; -- signal for 770 Hz
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000001";
        corr_1209 <= "0000000000000110";
        corr_1336 <= "0000000000001111"; -- signal for 1336 Hz
        corr_1477 <= "0000000000000001";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 7)
        corr_697 <= "0000000000000010"; -- signal for 697 Hz
        corr_770 <= "0000000000000001"; -- no 770 Hz
        corr_852 <= "0000000000001111";
        corr_941 <= "0000000000000110";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000100";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Test Case 9: Set frequencies to 852 and 941 Hz (DTMF 8)
        corr_697 <= "0000000000000100"; 
        corr_770 <= "0000000000001100";
        corr_852 <= "0000000000001111"; -- signal for 852 Hz
        corr_941 <= "0000000000001100";
        corr_1209 <= "0000000000000100";
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001001";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF *)
        corr_697 <= "0000000000000100"; -- signal for 697 Hz
        corr_770 <= "0000000000000101"; -- no 770 Hz
        corr_852 <= "0000000000000110";
        corr_941 <= "0000000000001111";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000001100";
        corr_1477 <= "0000000000001011";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 0)
        corr_697 <= "0000000000000100"; -- signal for 697 Hz
        corr_770 <= "0000000000000101"; -- no 770 Hz
        corr_852 <= "0000000000000110";
        corr_941 <= "0000000000001111";
        corr_1209 <= "0000000000001100"; -- signal for 1209 Hz
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001010";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 1)
        corr_697 <= "0000000000001111"; -- signal for 697 Hz
        corr_770 <= "0000000000000001"; -- no 770 Hz
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000000";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000100";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Test Case 4: Set frequencies to 697 and 1336 Hz (DTMF 2)
        corr_697 <= "0000000000001111"; -- signal for 697 Hz
        corr_770 <= "0000000000000010";
        corr_852 <= "0000000000000001";
        corr_941 <= "0000000000000011";
        corr_1209 <= "0000000000000111";
        corr_1336 <= "0000000000001111"; -- signal for 1336 Hz
        corr_1477 <= "0000000000000011";
        wait for 10 ns;

        -- Test Case 5: Set frequencies to 770 and 1209 Hz (DTMF 4)
        corr_697 <= "0000000000000010"; 
        corr_770 <= "0000000000001111"; -- signal for 770 Hz
        corr_852 <= "0000000000001000";
        corr_941 <= "0000000000000100";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000110";
        corr_1477 <= "0000000000001000";
        wait for 10 ns;

        -- Test Case 2: Set frequencies to 770 and 1336 Hz (DTMF 5)
        corr_697 <= "0000000000000011"; 
        corr_770 <= "0000000000001111"; -- signal for 770 Hz
        corr_852 <= "0000000000000010";
        corr_941 <= "0000000000000001";
        corr_1209 <= "0000000000000110";
        corr_1336 <= "0000000000001111"; -- signal for 1336 Hz
        corr_1477 <= "0000000000000001";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 7)
        corr_697 <= "0000000000000010"; -- signal for 697 Hz
        corr_770 <= "0000000000000001"; -- no 770 Hz
        corr_852 <= "0000000000001111";
        corr_941 <= "0000000000000110";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000000100";
        corr_1477 <= "0000000000000010";
        wait for 10 ns;

        -- Test Case 9: Set frequencies to 852 and 941 Hz (DTMF 8)
        corr_697 <= "0000000000000100"; 
        corr_770 <= "0000000000001100";
        corr_852 <= "0000000000001111"; -- signal for 852 Hz
        corr_941 <= "0000000000001100";
        corr_1209 <= "0000000000000100";
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001001";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF *)
        corr_697 <= "0000000000000100"; -- signal for 697 Hz
        corr_770 <= "0000000000000101"; -- no 770 Hz
        corr_852 <= "0000000000000110";
        corr_941 <= "0000000000001111";
        corr_1209 <= "0000000000001111"; -- signal for 1209 Hz
        corr_1336 <= "0000000000001100";
        corr_1477 <= "0000000000001011";
        wait for 10 ns;

        -- Test Case 1: Set all frequencies to 697 and 1209 Hz (DTMF 0)
        corr_697 <= "0000000000000100"; -- signal for 697 Hz
        corr_770 <= "0000000000000101"; -- no 770 Hz
        corr_852 <= "0000000000000110";
        corr_941 <= "0000000000001111";
        corr_1209 <= "0000000000001100"; -- signal for 1209 Hz
        corr_1336 <= "0000000000001111";
        corr_1477 <= "0000000000001010";
        wait for 10 ns;

        
        -- Finish the simulation
        wait;
    end process;
end behavior;
