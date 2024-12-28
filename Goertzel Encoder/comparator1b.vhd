library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator1b is
    Port (
        clk, rst            : in STD_LOGIC;
        input1              : in STD_LOGIC_VECTOR(15 downto 0);
        input2             : in STD_LOGIC_VECTOR(15 downto 0);
        output1b            : out STD_LOGIC_VECTOR(15 downto 0);
        code                : out STD_LOGIC_VECTOR (2 downto 0)
    );
end comparator1b;

architecture Behavioral of comparator1b is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset state
            output1b <= (others => '0');
            code <= "000";
        elsif rising_edge(clk) then
            -- Normal operation
            if input1 > input2 then
                output1b <= input1;
                code <= "011"; -- input1 lebih besar dari input2
            elsif input1 < input2 then
                output1b <= input2;
                code <= "100"; -- input2 lebih besar dari input1
            else
                output1b <= (others => '0'); -- Equal case, could also set to either input1 or input2
                code <= "000"; -- Code for equality
            end if;
        end if;
    end process;
end Behavioral;
