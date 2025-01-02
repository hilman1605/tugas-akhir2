library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;
use std.textio.all;

entity toplevel_accu_tb1 is
-- Testbench entities do not have ports.
end toplevel_accu_tb1;

architecture tb of toplevel_accu_tb1 is

    constant clk_hz : integer := 50e6;
    constant clk_period : time := 1 sec / clk_hz; -- Clock of 20 ns period

    constant sample_clk_hz : integer := 32e3;
    constant sample_clk_period : time := 1 sec / sample_clk_hz; -- Sample Clock

    -- Instance of the design under test
    component toplevel_accuv1
        generic(
            dataA_INT_BITS: natural := 2;
            dataA_FRAC_BITS: natural := 14;
            mult_INT_BITS: natural := 2;
            mult_FRAC_BITS: natural := 14;
            acc_INT_BITS: natural := 5;
            acc_FRAC_BITS: natural := 11
        );
        Port ( 
            clk, reset  : in STD_LOGIC;
            in_valid    : in STD_LOGIC;
            out_ready   : in STD_LOGIC;
            in_ready    : out STD_LOGIC;
            out_valid   : out STD_LOGIC;
            -- Bus Data
            dataA       : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);
            accout_sin697  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS);
            accout_sin941  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS);
            accout_sin1477 : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS);
            accout_cos697  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS);
            accout_cos941  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS);
            accout_cos1477 : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS)
        );
    end component;

    signal clk          : STD_LOGIC := '1';
    signal reset        : STD_LOGIC := '1';
    signal in_ready, out_valid : STD_LOGIC;
    signal in_valid     : STD_LOGIC := '0';
    signal out_ready    : STD_LOGIC := '0';
    signal dataA        : SFIXED((1) downto -14);
    signal accout_sin697, accout_sin941, accout_sin1477 : SFIXED((4) downto -11);
    signal accout_cos697, accout_cos941, accout_cos1477 : SFIXED((4) downto -11);
    
begin
    -- Instance of the design under test
    DUT: component toplevel_accuv1
        port map(
            clk         => clk,
            reset       => reset,
            in_valid    => in_valid,
            out_ready   => out_ready,
            in_ready    => in_ready,
            out_valid   => out_valid,
            dataA       => dataA,
            accout_sin697 => accout_sin697,
            accout_sin941 => accout_sin941,
            accout_sin1477=> accout_sin1477,
            accout_cos697 => accout_cos697,
            accout_cos941 => accout_cos941,
            accout_cos1477=> accout_cos1477
        );

    -- Clock process definitions
    clk <= not clk after clk_period / 2;

    process
    begin 
        reset <= '0' after 3 ns;
        wait;
    end process;

    DATA_READ: process
        file data_file    : text open read_mode is "dtmf_signal.txt";
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
            out_ready <= '0'; -- Reset out_ready to '0'
            wait for clk_period; -- Wait for another clock cycle
            out_ready <= '1'; -- Set out_ready after two clock cycles from in_valid
            wait for clk_period; -- This ensures dataA and in_valid are updated every 2 cycles
        end loop;
    end process;

end tb;