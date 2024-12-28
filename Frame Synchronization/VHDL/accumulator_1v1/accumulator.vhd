library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

entity StateMachine is
    generic(
        dataA_INT_BITS: natural:= 2;
        dataA_FRAC_BITS: natural:= 14;

        dataC_INT_BITS: natural:= 5;
        dataC_FRAC_BITS: natural:= 11;
        
        accu_out_INT_BITS: natural:= 5;
        accu_out_FRAC_BITS: natural:= 11;

        storage_out_INT_BITS: natural:= 5;
        storage_out_FRAC_BITS: natural:= 11
        
    );
    Port (
        clk, reset : in STD_LOGIC;
        dataA : in SFIXED((dataA_INT_BITS-1) downto -dataA_FRAC_BITS);                  -- Format: 1.1.14
        accu_out : in SFIXED((accu_out_INT_BITS-1) downto -accu_out_FRAC_BITS)         -- Format: 1.4.11
    );
end StateMachine;

architecture Behavioral of StateMachine is
    type state_type is (START, LOAD, COMPUTE, STORE, NEXT_FUNCTION);
    signal current_state, next_state : state_type;
    signal sel : unsigned(1 downto 0); -- 2-bit input to select sel1, sel2, or sel3
    signal counter1, counter2, counter3 : unsigned(4 downto 0) := "00000";
    signal dataC : SFIXED((dataC_INT_BITS-1) downto -dataC_FRAC_BITS);                  -- Format: 1.4.11
    signal storage_C1, storage_C2, storage_C3 : SFIXED((storage_out_INT_BITS-1) downto -storage_out_FRAC_BITS); -- Format: 1.4.11
    signal accu_next : SFIXED((accu_out_INT_BITS-1) downto -accu_out_FRAC_BITS);          -- Format: 1.4.11
    
begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= START;
            accu_next <= (others => '0');
            counter1 <= (others => '0');
            counter2 <= (others => '0');
            counter3 <= (others => '0');
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, sel, dataA, dataC, counter1, counter2, counter3)
    begin
        case current_state is
            when START =>
                accu_next <= (others => '0');
                counter1 <= (others => '0');
                counter2 <= (others => '0');
                counter3 <= (others => '0');
                next_state <= LOAD;
                
            when LOAD =>                                    -- Untuk load data c dari register (storage) dan inisalisasi accu <= 0
                if sel = "01" then
                    dataC <= storage_C1;
                    next_state <= COMPUTE;
                elsif sel = "10" then
                    dataC <= storage_C2;
                    next_state <= COMPUTE;
                elsif sel = "10" then
                    dataC <= storage_C2;
                    next_state <= COMPUTE;
                else
                    next_state <= NEXT_FUNCTION;
                end if;
                
            when COMPUTE =>                                 -- Hitung
                accu_next <= resize(dataC + dataA, accu_next);
                next_state <= STORE;
            
            when STORE =>
                if sel = "01" then
                    if counter1 < 20 then
                        storage_C1 <= accu_next;
                        counter1 <= counter1 + 1;
                        sel <= "10";
                        next_state <= LOAD;
                    else
                        next_state <= NEXT_FUNCTION;
                    end if;
                elsif sel = "10" then
                    if counter2 < 20 then
                        storage_C2 <= accu_next;
                        counter2 <= counter2 + 1;
                        sel <= "11";
                        next_state <= LOAD;
                    else

                        next_state <= NEXT_FUNCTION;
                    end if;
                elseif sel = "11" then
                    if counter3 < 20 then
                        storage_C3 <= accu_next;
                        counter3 <= counter3 + 1;
                        sel <= "01";
                        next_state <= LOAD;
                    else
                        next_state <= NEXT_FUNCTION;
                    end if;
                end if;

            when NEXT_FUNCTION =>
                -- Placeholder for next function
                next_state <= START; -- Loop back to start or move to another state

            when others =>
                next_state <= START;
        end case;
    end process;

    accu_out <= accu_next; -- Output the accumulator value
end Behavioral;
