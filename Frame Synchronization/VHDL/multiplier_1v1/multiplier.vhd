library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

entity multiplier is
    generic(
        dataA_INT_BITS: natural := 2;
        dataA_FRAC_BITS: natural := 14;
        out_INT_BITS: natural := 2;
        out_FRAC_BITS: natural := 14
    );
    Port (
        clk, reset, start : in STD_LOGIC;
        ready : out STD_LOGIC;
        dataA : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);
        mult_out : out SFIXED((out_INT_BITS-1) downto -out_FRAC_BITS)
    );
end multiplier;

architecture Behavioral of multiplier is
    -- Signal Declarations
    signal tempdata                 : std_logic_vector(15 downto 0);
    signal sin697, sin941, sin1477  : std_logic_vector(15 downto 0);
    signal mult_ready               : STD_LOGIC;
    signal tempaddress              : std_logic_vector (9 downto 0);
    
    -- Component Declarations
    component multiplier_block is
        generic(
            dataA_INT_BITS  : natural := 2;
            dataA_FRAC_BITS : natural := 14;
            mult_INT_BITS   : natural := 2;
            mult_FRAC_BITS  : natural := 14
        );
        Port (
            clk, reset, start : in STD_LOGIC;
            ready : out STD_LOGIC;
            dataA : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);
            dataB : in std_logic_vector(15 downto 0);
            mult  : out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS)
        );
    end component;

    component control_block is
        Port (
            clk, reset, ready               : in STD_LOGIC;
            sine_697, sine_941, sine_1477   : in std_logic_vector(15 downto 0);
            sin_out                         : out std_logic_vector(15 downto 0);
            address                         : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    component lutsin_block is
        Port (
            address      : in  std_logic_vector(9 downto 0);                    -- 640 alamat
            sine_697     : out std_logic_vector(15 downto 0);  -- Format: 1.0.15
            sine_941     : out std_logic_vector(15 downto 0);  -- Format: 1.0.15
            sine_1477    : out std_logic_vector(15 downto 0)  -- Format: 1.0.15
        );
    end component;

begin
    -- Instance of Multiplier
    mult_inst : component multiplier_block
        generic map (
            dataA_INT_BITS  => 2,
            dataA_FRAC_BITS => 14,
            mult_INT_BITS   => 2,
            mult_FRAC_BITS  => 14
        )
        port map (
            clk     => clk,
            reset   => reset,
            start   => start,
            ready   => mult_ready,
            dataA   => dataA,
            dataB   => tempdata,
            mult    => mult_out
        );

    -- Instance of Multiplexer
    mux_inst : component control_block
        port map (
            clk     => clk,
            reset   => reset,
            ready   => mult_ready,  
            sine_697    => sin697,
            sine_941    => sin941,
            sine_1477   => sin1477,
				sin_out  => tempdata,
            address => tempaddress
        );
    
    -- Instance of lookuptable
    lut_inst : component lutsin_block
        port map(
            address     => tempaddress,
            sine_697    => sin697,
            sine_941    => sin941,
            sine_1477   => sin1477
        );
end Behavioral;
