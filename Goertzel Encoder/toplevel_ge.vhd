library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toplevel_ge is
    Port (
        clk, rst        : in  STD_LOGIC;                    -- Reset signal
        corr_697        : in STD_LOGIC_VECTOR(15 downto 0);
        corr_770        : in STD_LOGIC_VECTOR(15 downto 0);
        corr_852        : in STD_LOGIC_VECTOR(15 downto 0);
        corr_941        : in STD_LOGIC_VECTOR(15 downto 0);
        corr_1209       : in STD_LOGIC_VECTOR(15 downto 0);
        corr_1336       : in STD_LOGIC_VECTOR(15 downto 0);
        corr_1477       : in STD_LOGIC_VECTOR(15 downto 0);
        encode_out      : out STD_LOGIC_VECTOR(23 downto 0)
    );
end toplevel_ge;

architecture Behavioral of toplevel_ge is
    
    -- Signal Out tiap blok
    signal out_low1, out_low2, out_high         : STD_LOGIC_VECTOR(15 downto 0);
    signal codel1_out, codel2_out, codeh_out    : STD_LOGIC_VECTOR(2 downto 0);
    signal codelow, codehigh                    : STD_LOGIC_VECTOR(2 downto 0);    
    signal code_dtmf                            : STD_LOGIC_VECTOR(3 downto 0);  
    
    -- Signal valid setiap block


    -- Componen Declarations
    component comparator1a is
        Port (
        clk, rst            : in STD_LOGIC;
        input1              : in STD_LOGIC_VECTOR(15 downto 0);
        input2              : in STD_LOGIC_VECTOR(15 downto 0);
        output1a            : out STD_LOGIC_VECTOR(15 downto 0);
        code                : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component comparator1b is
        Port (
        clk, rst            : in STD_LOGIC;
        input1              : in STD_LOGIC_VECTOR(15 downto 0);
        input2              : in STD_LOGIC_VECTOR(15 downto 0);
        output1b            : out STD_LOGIC_VECTOR(15 downto 0);
        code                : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
    
    component comparator2a is
        Port (
        clk, rst        : in STD_LOGIC;
        input1          : in STD_LOGIC_VECTOR(15 downto 0);
        input2          : in STD_LOGIC_VECTOR(15 downto 0);
        code_A          : in STD_LOGIC_VECTOR (2 downto 0);
        code_B          : in STD_LOGIC_VECTOR (2 downto 0);
        code_out        : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component comparator2b is
        Port (
        clk, rst        : in STD_LOGIC;
        input1          : in STD_LOGIC_VECTOR(15 downto 0); -- Sinyal Input dari comparator 1A untuk 1209 dan 1336 Hz
        input2          : in STD_LOGIC_VECTOR(15 downto 0); -- Sinyal Input dari power 1477 Hz
        code_A          : in STD_LOGIC_VECTOR (2 downto 0);
        code_out        : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    component decision is
        Port (
        clk, rst        : in STD_LOGIC;
        code_low        : in STD_LOGIC_VECTOR (2 downto 0);
        code_high       : in STD_LOGIC_VECTOR (2 downto 0);
        dtmf_code       : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    
    component shift_add is
        Port (
        clk, reset                : in  STD_LOGIC;                    -- Reset signal
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
            input1  => corr_697,
            input2  => corr_770,
            output1a=> out_low1,
            code    => codel1_out
        );
    
    comp_low2 : component comparator1b
        port map(
            clk     => clk ,
            rst     => rst ,
            input1  => corr_852,
            input2  => corr_941,
            output1b=> out_low2,
            code    => codel2_out
        );

    comp_high : component comparator1a
        port map(
            clk     => clk ,
            rst     => rst ,
            input1  => corr_1209,
            input2  => corr_1336,
            output1a=> out_high,
            code    => codeh_out
        );
    
    complow_lv2 : component comparator2a
        port map(
            clk     => clk ,
            rst     => rst ,
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
            input1  => out_high,
            input2  => corr_1477,
            code_A  => codeh_out,
            code_out=> codehigh
        );

    dec_DTMF : component decision
        port map(
            clk         => clk,
            rst         => rst,
            code_low    => codelow,
            code_high   => codehigh,
            dtmf_code   => code_dtmf
        );
    
    encoder : component shift_add
        port map(
            clk         => clk,
            reset         => rst,
            input3      => code_dtmf,
            output32    => encode_out
        );
end Behavioral;