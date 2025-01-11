library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decision is
    Port (
        clk, rst : in STD_LOGIC;
        in_valid_low    : in STD_LOGIC;
        in_valid_high   : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        in_ready    : out STD_LOGIC;
        out_valid   : out STD_LOGIC;
        code_low, code_high : in STD_LOGIC_VECTOR (2 downto 0);
        dtmf_code : out STD_LOGIC_VECTOR (3 downto 0)
    );
end decision;

architecture Behavioral of decision is
    type state_type is (IDLE, COMPUTE, STORE);
    signal state    : state_type;
    signal code_temp: STD_LOGIC_VECTOR(3 downto 0);
    
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
    process(state)
    begin
        if state = IDLE then
            in_ready <= '1';
        else
            in_ready <= '0';
        end if;
    end process;
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset state
            dtmf_code <= "0000";
            code_temp <= "0000";
        elsif rising_edge(clk) then
            state <= state;
            case state is
                when IDLE =>
                    if in_valid_low = '1' and in_valid_high = '1' then
                        out_valid<= '0';
                        state <= COMPUTE;
                    else
                        state <= IDLE;
                    end if;
                    
                when COMPUTE =>
                    -- Normal operation
                    if code_low = "001" and code_high = "001" then
                        code_temp <= "1000"; -- DTMF 1

                    elsif code_low = "001" and code_high = "010" then
                        code_temp <= "1001"; -- DTMF 2

                    elsif code_low = "010" and code_high = "001" then
                        code_temp <= "1010"; -- DTMF 4

                    elsif code_low = "010" and code_high = "010" then
                        code_temp <= "1011"; -- DTMF 5

                    elsif code_low = "011" and code_high = "001" then
                        code_temp <= "1100"; -- DTMF 7

                    elsif code_low = "011" and code_high = "010" then
                        code_temp <= "1101"; -- DTMF 8

                    elsif code_low = "100" and code_high = "001" then
                        code_temp <= "1110"; -- DTMF *

                    elsif code_low = "100" and code_high = "010" then
                        code_temp <= "1111"; -- DTMF 0
                    else
                        code_temp <= "0000";
                    end if;
                    state <= STORE;

                when STORE =>
                    dtmf_code <= code_temp;
                    out_valid <= '1';
                    if out_ready = '1' then
                        state <= IDLE;
                    end if;
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;
