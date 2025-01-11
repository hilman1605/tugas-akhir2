library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity highlevel2 is
    Port (
        clk, rst        : in  STD_LOGIC;                    -- Reset signal
        corr_1209       : in STD_LOGIC_VECTOR(15 downto 0);
        corr_1336       : in STD_LOGIC_VECTOR(15 downto 0);
        corr_1477       : in STD_LOGIC_VECTOR(15 downto 0);
        codehigh         : out STD_LOGIC_VECTOR(2 downto 0)
    );
end highlevel2;

architecture Behavioral of highlevel2 is
    
    -- Signal Out tiap blok
    signal out_high            : STD_LOGIC_VECTOR(15 downto 0);
    signal codeh_out           : STD_LOGIC_VECTOR(2 downto 0);
    
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

    component comparator2b is
        Port (
        clk, rst        : in STD_LOGIC;
        input1          : in STD_LOGIC_VECTOR(15 downto 0);
        input2          : in STD_LOGIC_VECTOR(15 downto 0);
        code_A          : in STD_LOGIC_VECTOR (2 downto 0);
        code_out        : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    
begin
    -- Instance of comparator for frequency 697 and 770 Hz
    comp_high: component comparator1a
        port map(
            clk     => clk ,
            rst     => rst ,
            input1  => corr_1209,
            input2  => corr_1336,
            output1a=> out_high,
            code    => codeh_out
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
end Behavioral;