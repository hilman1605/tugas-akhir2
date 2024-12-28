library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator2b is
    Port (
        clk, rst          : in STD_LOGIC;
        input1            : in STD_LOGIC_VECTOR(15 downto 0);
        input2            : in STD_LOGIC_VECTOR(15 downto 0);
        code_A            : in STD_LOGIC_VECTOR (2 downto 0);
        code_out          : out STD_LOGIC_VECTOR (2 downto 0)
    );
end comparator2b;

architecture Behavioral of comparator2b is
    signal temp_input2 : std_logic_vector(15 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset state
            code_out <= "000";
        elsif rising_edge(clk) then
            temp_input2 <= input2;
            -- Normal operation
            if input1 > temp_input2 then
                code_out <= code_A; -- input1 is greater than input2
            elsif input1 < temp_input2 then
                code_out <= "011"; -- input2 is greater than input1
            else
                code_out <= "000"; -- input1 equals input2, could set to default or handle differently
            end if;
        end if;
    end process;
end Behavioral;
    