library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lowlevel2 is
    Port (
        clk, rst        : in  STD_LOGIC;                    -- Reset signal
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        
        corr_697        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_770        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_852        : in STD_LOGIC_VECTOR(16 downto 0);
        corr_941        : in STD_LOGIC_VECTOR(16 downto 0);
        codelow         : out STD_LOGIC_VECTOR(2 downto 0)
    );
end lowlevel2;

architecture Behavioral of lowlevel2 is
    
    -- Signal Out tiap blok
    signal r2r1, v2v1al, v2v1bl                 : STD_LOGIC;
    signal out_low1, out_low2                   : STD_LOGIC_VECTOR(16 downto 0);
    signal codel1_out, codel2_out               : STD_LOGIC_VECTOR(2 downto 0);
    
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
    
    component comparator2a is
        Port (
            clk, rst          : in STD_LOGIC;
            in_valid1    : in STD_LOGIC;
            in_valid2    : in STD_LOGIC;
            out_ready   : in STD_LOGIC;
            in_ready    : out STD_LOGIC;
            out_valid   : out STD_LOGIC;
            input1            : in STD_LOGIC_VECTOR(16 downto 0);
            input2            : in STD_LOGIC_VECTOR(16 downto 0);
            code_A            : in STD_LOGIC_VECTOR (2 downto 0);
            code_B            : in STD_LOGIC_VECTOR (2 downto 0);
            code_out          : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    
begin
    -- Instance of comparator for frequency 697 and 770 Hz
    comp_low1 : component comparator1a
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid        => in_valid,
            out_ready       => r2r1,
            out_valid       => v2v1al,
            input1  => corr_697,
            input2  => corr_770,
            output1a=> out_low1,
            code    => codel1_out
        );
    
    comp_low2 : component comparator1b
        port map(
            clk     => clk,
            rst     => rst,
            in_valid        => in_valid,
            out_ready       => r2r1,
            out_valid       => v2v1bl,
            input1  => corr_852,
            input2  => corr_941,
            output1b=> out_low2,
            code    => codel2_out
        );

    complow_lv2 : component comparator2a
        port map(
            clk     => clk ,
            rst     => rst ,
            in_valid1        => v2v1al,
            in_valid2        => v2v1bl,
            out_ready       => out_ready,
            in_ready        => r2r1,
            out_valid       => out_valid,
            input1  => out_low1,
            input2  => out_low2,
            code_A  => codel1_out,
            code_B  => codel2_out,
            code_out=> codelow
        );
end Behavioral;