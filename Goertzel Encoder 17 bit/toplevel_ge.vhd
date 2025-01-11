library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toplevel_ge is
    Port (
        clk, rst        : in  STD_LOGIC;                    -- Reset signal
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        corr_697        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_770        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_852        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_941        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_1209       : in STD_LOGIC_VECTOR(16 downto 0);
        corr_1336       : in STD_LOGIC_VECTOR(16 downto 0);
        corr_1477       : in STD_LOGIC_VECTOR(16 downto 0);
        encode_out      : out STD_LOGIC_VECTOR(23 downto 0)
    );
end toplevel_ge;

architecture Behavioral of toplevel_ge is
    signal r2r1l, v2v1al, v2v1bl                : STD_LOGIC;
    signal r2r1h, v2v1ah, v2v1bh                         : STD_LOGIC;
    signal r2r2, v2v2h, v2v2l                   : STD_LOGIC;
    signal r2r3, v2v3                           : STD_LOGIC;
    -- Signal Out tiap blok
    signal out_low1, out_low2, out_high, out_1477: STD_LOGIC_VECTOR(16 downto 0);
    signal codel1_out, codel2_out, codeh_out    : STD_LOGIC_VECTOR(2 downto 0);
    signal codelow, codehigh                    : STD_LOGIC_VECTOR(2 downto 0);    
    signal code_dtmf                            : STD_LOGIC_VECTOR(3 downto 0);  
    
    -- Signal valid setiap block


    -- Componen Declarations
    component comparator1a is
        Port (
        clk, rst            : in STD_LOGIC;
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        input1              : in STD_LOGIC_VECTOR(16 downto 0);
        input2              : in STD_LOGIC_VECTOR(16 downto 0);
        output1a            : out STD_LOGIC_VECTOR(16 downto 0);
        code                : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component comparator1b is
        Port (
        clk, rst            : in STD_LOGIC;
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        input1              : in STD_LOGIC_VECTOR(16 downto 0);
        input2              : in STD_LOGIC_VECTOR(16 downto 0);
        output1b            : out STD_LOGIC_VECTOR(16 downto 0);
        code                : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component delay1477 is
        Port (
        clk, rst    : in STD_LOGIC;
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        input1477   : in STD_LOGIC_VECTOR(16 downto 0);
        output1477  : out STD_LOGIC_VECTOR(16 downto 0)
        );
    end component;
    
    component comparator2a is
        Port (
        clk, rst        : in STD_LOGIC;
        in_valid1       : in STD_LOGIC;
        in_valid2       : in STD_LOGIC;
        out_ready       : in STD_LOGIC;
        in_ready        : out STD_LOGIC;
        out_valid       : out STD_LOGIC;
        input1          : in STD_LOGIC_VECTOR(16 downto 0);
        input2          : in STD_LOGIC_VECTOR(16 downto 0);
        code_A          : in STD_LOGIC_VECTOR (2 downto 0);
        code_B          : in STD_LOGIC_VECTOR (2 downto 0);
        code_out        : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component comparator2b is
        Port (
        clk, rst        : in STD_LOGIC;
        in_valid1a      : in STD_LOGIC;
        in_valid1477    : in STD_LOGIC;
        out_ready       : in STD_LOGIC;
        in_ready        : out STD_LOGIC;
        out_valid       : out STD_LOGIC;
        input1          : in STD_LOGIC_VECTOR(16 downto 0); -- Sinyal Input dari comparator 1A untuk 1209 dan 1336 Hz
        input2          : in STD_LOGIC_VECTOR(16 downto 0); -- Sinyal Input dari power 1477 Hz
        code_A          : in STD_LOGIC_VECTOR (2 downto 0);
        code_out        : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component decision is
        Port (
        clk, rst        : in STD_LOGIC;
        in_valid_low    : in STD_LOGIC;
        in_valid_high   : in STD_LOGIC;
        out_ready       : in STD_LOGIC;
        in_ready        : out STD_LOGIC;
        out_valid       : out STD_LOGIC;
        code_low        : in STD_LOGIC_VECTOR (2 downto 0);
        code_high       : in STD_LOGIC_VECTOR (2 downto 0);
        dtmf_code       : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    
    component shift_add is
        Port (
        clk, reset                : in  STD_LOGIC;
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        in_ready    : out STD_LOGIC;
        out_valid   : out STD_LOGIC;                    -- Reset signal
        input3                  : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input
        output32                : out STD_LOGIC_VECTOR(23 downto 0)   -- 8-bit output
        );
    end component;

begin
    -- Instance of comparator for frequency 697 and 770 Hz
    comp_low1 : component comparator1a
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid        => in_valid,
            out_ready       => r2r1l,
            out_valid       => v2v1al,
            input1  => corr_697,
            input2  => corr_770,
            output1a=> out_low1,
            code    => codel1_out
        );
    
    comp_low2 : component comparator1b
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid        => in_valid,
            out_ready       => r2r1l,
            out_valid       => v2v1bl,
            input1          => corr_852,
            input2          => corr_941,
            output1b=> out_low2,
            code    => codel2_out
        );

    comp_high1 : component comparator1a
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid        => in_valid,
            out_ready       => r2r1h,
            out_valid       => v2v1ah,
            input1  => corr_1209,
            input2  => corr_1336,
            output1a=> out_high,
            code    => codeh_out
        );
    
    comp_high2 : component delay1477
        port map(
            clk     => clk,
            rst     => rst,
            in_valid        => in_valid,
            out_ready       => r2r1h,
            out_valid       => v2v1bh,
            input1477       => corr_1477,
            output1477      => out_1477
        );
    complow_lv2 : component comparator2a
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid1        => v2v1al,
            in_valid2        => v2v1bl,
            out_ready       => r2r2,
            in_ready        => r2r1l,
            out_valid       => v2v2l,
            input1  => out_low1,
            input2  => out_low2,
            code_A  => codel1_out,
            code_B  => codel2_out,
            code_out=> codelow
        );
    
    comphigh_lv2 : component comparator2b
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid1a      => v2v1ah,
            in_valid1477    => v2v1bh,
            out_ready       => r2r2,
            in_ready        => r2r1h,
            out_valid       => v2v2h,
            input1  => out_high,
            input2  => out_1477,
            code_A  => codeh_out,
            code_out=> codehigh
        );

    dec_DTMF : component decision
        port map(
            clk         => clk,
            rst         => rst,
            in_valid_low    => v2v2l,
            in_valid_high   => v2v2h,
            out_ready       => r2r3,
            in_ready        => r2r2,
            out_valid       => v2v3,
            code_low    => codelow,
            code_high   => codehigh,
            dtmf_code   => code_dtmf
        );
    
    encoder : component shift_add
        port map(
            clk         => clk,
            reset         => rst,
            in_valid        => v2v3,
            out_ready       => out_ready,
            in_ready        => r2r3,
            out_valid       => out_valid,
            input3      => code_dtmf,
            output32    => encode_out
        );
end Behavioral;