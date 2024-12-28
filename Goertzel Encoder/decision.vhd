library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decision is
    Port (
        clk, rst : in STD_LOGIC;
        code_low, code_high : in STD_LOGIC_VECTOR (2 downto 0);
        dtmf_code : out STD_LOGIC_VECTOR (3 downto 0)
    );
end decision;

architecture Behavioral of decision is
-- Notes
-- DTMF 1 = 000
-- DTMF 2 = 001
-- DTMF 4 = 010
-- DTMF 5 = 011
-- DTMF 7 = 100
-- DTMF 8 = 101
-- DTMF * = 110
-- DTMF 0 = 111

begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset state
            dtmf_code <= "0000";
        elsif rising_edge(clk) then
            -- Normal operation
            if code_low = "001" and code_high = "001" then
                dtmf_code <= "1000"; -- DTMF 1

            elsif code_low = "001" and code_high = "010" then
                dtmf_code <= "1001"; -- DTMF 2

            elsif code_low = "010" and code_high = "001" then
                dtmf_code <= "1010"; -- DTMF 4

            elsif code_low = "010" and code_high = "010" then
                dtmf_code <= "1011"; -- DTMF 5

            elsif code_low = "011" and code_high = "001" then
                dtmf_code <= "1100"; -- DTMF 7

            elsif code_low = "011" and code_high = "010" then
                dtmf_code <= "1101"; -- DTMF 8

            elsif code_low = "100" and code_high = "001" then
                dtmf_code <= "1110"; -- DTMF *

            elsif code_low = "100" and code_high = "010" then
                dtmf_code <= "1111"; -- DTMF 0
            else
                dtmf_code <= "0000";
            end if;
        end if;
    end process;
end Behavioral;
