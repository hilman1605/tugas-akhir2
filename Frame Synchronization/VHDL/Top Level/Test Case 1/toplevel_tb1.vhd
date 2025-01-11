library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;
use std.textio.all;

entity toplevel_tb1 is
end toplevel_tb1;

architecture tb of toplevel_tb1 is
    constant clk_hz : integer := 50e6;
    constant clk_period : time := 1 sec / clk_hz; -- Clock of 20 ns period

    constant sample_clk_hz : integer := 32e3;
    constant sample_clk_period : time := 1 sec / sample_clk_hz; -- Sample Clock

    -- Instance of the design under test
    component toplevelv1
        generic(
            dataA_INT_BITS:     natural := 2;
            dataA_FRAC_BITS:    natural := 14;
            mult_INT_BITS:      natural := 2;
            mult_FRAC_BITS:     natural := 14;
            acc_INT_BITS:       natural := 6;
            acc_FRAC_BITS:      natural := 10;
            power_INT_BITS:     natural := 10;
            power_FRAC_BITS:    natural := 6;
            batch_INT_BITS:     natural := 14;
            batch_FRAC_BITS:    natural := 2
        );
        Port ( 
            clk, reset  : in STD_LOGIC;
            in_valid    : in STD_LOGIC;
            out_ready   : in STD_LOGIC;
            in_ready    : out STD_LOGIC;
            out_valid   : out STD_LOGIC;
            dataA       : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);
            en_goertzel : out std_logic;
            flag_sig    : out std_logic;
            batch_697   : out SFIXED((13) downto -2);
            batch_941   : out SFIXED((13) downto -2);
            batch_1477  : out SFIXED((13) downto -2);
            counter     : out integer range 0 to 10000
        );
    end component;

    signal clk, reset           : STD_LOGIC := '1';
    signal sample_clk   : std_logic := '1';
    signal in_ready, out_valid  : STD_LOGIC;
    signal in_valid, out_ready  : STD_LOGIC := '0';
    signal dataA : SFIXED((1) downto -14);
    signal batch_697, batch_941, batch_1477 : SFIXED((13) downto -2);
    signal en_goertzel, flag_sig : STD_LOGIC := '0';
    signal counter : integer range 0 to 10000 := 0;
    
   


begin
    -- Instance of the design under test
    DUT: component toplevelv1
        port map(
            clk         => clk,
            reset       => reset,
            in_valid    => in_valid,
            out_ready   => out_ready,
            in_ready    => in_ready,
            out_valid   => out_valid,
            dataA       => dataA,
            batch_697   => batch_697,
            batch_941   => batch_941,
            batch_1477  => batch_1477,
            counter     => counter,
            flag_sig    => flag_sig,
            en_goertzel => en_goertzel
        );

    -- Clock process definitions
    clk <= not clk after clk_period / 2;
    sample_clk <= not sample_clk after sample_clk_period/2;

    process
    begin 
        reset <= '0' after 3 ns;
        wait;
    end process;

    DATA_READ: process
        file data_file    : text open read_mode is "test_case1.txt";
        variable x_var    : real := 0.0;
        variable line_in  : line;
        variable counter  : integer := 0;
    begin
        while not endfile(data_file) loop
            readline(data_file, line_in);
            read(line_in, x_var);
            dataA <= to_sfixed(x_var, dataA);
            in_valid <= '1';
            wait for clk_period; -- Wait for one clock cycle
            in_valid <= '0';
            wait for clk_period; -- Wait for another clock cycle
            out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
            wait for clk_period; -- This ensures dataA and in_valid are updated every 2 cycles
            out_ready <= '0'; -- Reset out_ready to '0'
            wait for sample_clk_period;
        end loop;
    end process;
end tb;
