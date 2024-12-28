library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_add is
    Port (
        clk         : in  std_logic; -- Clock signal
        reset       : in  std_logic; -- Reset signal
        input3      : in  std_logic_vector(3 downto 0); -- Input signal
        output32    : out std_logic_vector(23 downto 0) -- Output signal
    );
end shift_add;

architecture Behavioral of shift_add is
    signal counter   : integer range 0 to 8 := 0;
    signal temp_sig  : std_logic_vector(23 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all signals
            temp_sig <= (others => '0');
            counter <= 0;
            output32 <= (others => '0');
        elsif rising_edge(clk) then
            if input3(3) = '1' then
                temp_sig <= std_logic_vector(shift_left(unsigned(temp_sig), 3));
                temp_sig(2 downto 0) <= input3(2 downto 0);
                if counter < 8 then
                    counter <= counter + 1;
                else
                    -- Output the temp_sig when counter is 8 or more
                    output32 <= temp_sig;
                    counter <= 1;
                end if;
            else
                temp_sig <= temp_sig;
                counter <= counter;
            end if;
            -- If input3(3) = '0', do nothing, just wait
        end if;
    end process;
end Behavioral;
