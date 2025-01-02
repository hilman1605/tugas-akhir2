library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;

entity toplevel_accuv1 is
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
end toplevel_accuv1;

architecture Behavioral of toplevel_accuv1 is
    signal address_signal : std_logic_vector(9 downto 0);
    -- I/O signal
    signal r2r            : STD_LOGIC;
    signal v2v            : STD_LOGIC;

    -- Dari LUT Cos ke Multiplier
    signal sine_697       : std_logic_vector(15 downto 0);
    signal sine_941       : std_logic_vector(15 downto 0);
    signal sine_1477      : std_logic_vector(15 downto 0);

    -- Dari LUT Cos ke Multipleir
    signal cosine_697       : std_logic_vector(15 downto 0);
    signal cosine_941       : std_logic_vector(15 downto 0);
    signal cosine_1477      : std_logic_vector(15 downto 0);

    -- Dari multiplier ke accumulator
    signal multout_sin697    : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
    signal multout_sin941    : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
    signal multout_sin1477   : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
    signal multout_cos697    : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
    signal multout_cos941    : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
    signal multout_cos1477   : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);

    -- component declarations
    component Framingv2 is
        generic(
            data_INT_BITS: natural := 2;
            data_FRAC_BITS: natural := 14;
            acc_INT_BITS: natural := 5;
            acc_FRAC_BITS: natural := 11
        );
        Port ( 
            clk, reset : in STD_LOGIC;
            
            in_valid    : in STD_LOGIC;
            out_ready   : in STD_LOGIC;
            in_ready    : out STD_LOGIC;
            out_valid   : out STD_LOGIC;
            -- Bus Data Input
            multsin697  : in SFIXED((data_INT_BITS-1) downto -data_FRAC_BITS);
            multsin941  : in SFIXED((data_INT_BITS-1) downto -data_FRAC_BITS);
            multsin1477 : in SFIXED((data_INT_BITS-1) downto -data_FRAC_BITS);
            multcos697  : in SFIXED((data_INT_BITS-1) downto -data_FRAC_BITS);
            multcos941  : in SFIXED((data_INT_BITS-1) downto -data_FRAC_BITS);
            multcos1477 : in SFIXED((data_INT_BITS-1) downto -data_FRAC_BITS);
            
            acc_sin697  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS); 
            acc_sin941  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS); 
            acc_sin1477 : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS);
            acc_cos697  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS); 
            acc_cos941  : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS); 
            acc_cos1477 : out SFIXED((acc_INT_BITS-1) downto -acc_FRAC_BITS) 
        );
    end component;

    component multv6 is
        generic(
            dataA_INT_BITS: natural := 2;
            dataA_FRAC_BITS: natural := 14;
            mult_INT_BITS: natural := 2;
            mult_FRAC_BITS: natural := 14
        );
        Port ( 
            clk, reset  : in STD_LOGIC;

            in_valid    : in STD_LOGIC;
            out_ready   : in STD_LOGIC;
            in_ready    : out STD_LOGIC;
            out_valid   : out STD_LOGIC;

            -- Bus Data Input
            dataA       : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);
            sin697      : in std_logic_vector(15 downto 0);
            sin941      : in std_logic_vector(15 downto 0);
            sin1477     : in std_logic_vector(15 downto 0);
            cos697      : in std_logic_vector(15 downto 0);
            cos941      : in std_logic_vector(15 downto 0);
            cos1477     : in std_logic_vector(15 downto 0);

            -- Bus Data Output
            multsin_697 : out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
            multsin_941 : out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
            multsin_1477: out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
            multcos_697 : out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
            multcos_941 : out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
            multcos_1477: out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);
            address     : out STD_LOGIC_VECTOR(9 downto 0)
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

    component lutcos_block is
        Port (
            address      : in  std_logic_vector(9 downto 0);                    -- 640 alamat
            cosine_697     : out std_logic_vector(15 downto 0);  -- Format: 1.0.15
            cosine_941     : out std_logic_vector(15 downto 0);  -- Format: 1.0.15
            cosine_1477    : out std_logic_vector(15 downto 0)  -- Format: 1.0.15
        );
    end component;

begin
    framing   : component Framingv2
        generic map(
            data_INT_BITS => 2,
            data_FRAC_BITS => 14,
            acc_INT_BITS => 5,
            acc_FRAC_BITS => 11
        )
        port map(
            clk         => clk,
            reset       => reset,
            in_valid    => v2v,
            out_ready   => r2r,
            in_ready    => in_ready,
            out_valid   => out_valid,

            -- Input Frame Sin
            multsin697  => multout_sin697,
            multsin941  => multout_sin941,
            multsin1477 => multout_sin1477,

            -- Input Frame Cos
            multcos697  => multout_cos697,
            multcos941  => multout_cos941,
            multcos1477 => multout_cos1477,

            -- Output Frame Sin
            acc_sin697  => accout_sin697,
            acc_sin941  => accout_sin941,
            acc_sin1477 => accout_sin1477,
            -- Output Frame Cos
            acc_cos697  => accout_cos697,
            acc_cos941  => accout_cos941,
            acc_cos1477 => accout_cos1477

        );
    mult_unit : component multv6
        generic map (
            dataA_INT_BITS  => 2,
            dataA_FRAC_BITS => 14,
            mult_INT_BITS   => 2,
            mult_FRAC_BITS  => 14
        )
        port map (
            clk             => clk,
            reset           => reset,
            -- Port IO Bus Multiplier
            in_valid        => in_valid,
            out_ready       => out_ready,
            in_ready        => r2r,
            out_valid       => v2v,

            -- Input Multiplier
            dataA           => dataA,
            -- Input Multiplier Sin
            sin697          => sine_697,
            sin941          => sine_941,
            sin1477         => sine_1477,
            -- Input Multiplier Cos
            cos697          => cosine_697,
            cos941          => cosine_941,
            cos1477         => cosine_1477,

            -- Output Multiplier Sin
            multsin_697     => multout_sin697,
            multsin_941     => multout_sin941,
            multsin_1477    => multout_sin1477,
            -- Output Multiplier Cos
            multcos_697     => multout_cos697,
            multcos_941     => multout_cos941,
            multcos_1477    => multout_cos1477,
            address         => address_signal
        );
    lutsin_unit: component lutsin_block
        port map (
            address      => address_signal,
            sine_697     => sine_697,
            sine_941     => sine_941,
            sine_1477    => sine_1477
        );
    lutcos_unit: component lutcos_block
        port map (
            address      => address_signal,
            cosine_697   => cosine_697,
            cosine_941   => cosine_941,
            cosine_1477  => cosine_1477
        );
end Behavioral;