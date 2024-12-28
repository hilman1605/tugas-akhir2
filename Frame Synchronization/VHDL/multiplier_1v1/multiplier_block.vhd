library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

entity multiplier_block is
    generic(
        dataA_INT_BITS: natural := 2;
        dataA_FRAC_BITS: natural := 14;
        tempB_INT_BITS: natural := 1;
        tempB_FRAC_BITS: natural := 15;
        mult_INT_BITS: natural := 2;
        mult_FRAC_BITS: natural := 14
    );
    Port ( 
        clk, reset, start : in STD_LOGIC;
        ready : out STD_LOGIC;
        dataA : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);
        dataB : in std_logic_vector(15 downto 0);
        mult : out SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS)
    );
end multiplier_block;

architecture Behavioral of multiplier_block is
    type state_type is (IDLE, LOAD_DATA, COMPUTE);
    signal state, next_state : state_type;
    signal tempB: sfixed((tempB_INT_BITS-1) downto -tempB_FRAC_BITS);
    signal mult_internal : SFIXED((mult_INT_BITS-1) downto -mult_FRAC_BITS);

begin
    -- State transition and output process
    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            mult_internal <= (others => '0');
        elsif rising_edge(clk) then
            state <= next_state;
            case state is
                when IDLE =>
                    ready <= '1';
                    if start = '1' then
                        next_state <= LOAD_DATA;
                    else
                        next_state <= IDLE;
                    end if;

                when LOAD_DATA =>
						 tempB <= to_sfixed(dataB, tempB_INT_BITS-1, -tempB_FRAC_BITS);
						 next_state <= COMPUTE;

                when COMPUTE =>
                    mult_internal <= resize(dataA * tempB, mult_internal);
                    next_state <= IDLE;

                when others =>
                    next_state <= IDLE;
            end case;
        end if;
        mult <= mult_internal; -- Assign output only on clock edge
    end process;

end Behavioral;
