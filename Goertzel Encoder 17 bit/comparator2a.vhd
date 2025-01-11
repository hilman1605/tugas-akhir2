library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator2a is
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
end comparator2a;

architecture Behavioral of comparator2a is
    type state_type is (IDLE, COMPUTE, STORE);
    signal temp1, temp2 : STD_LOGIC_VECTOR(16 downto 0);
    signal state    : state_type;
    signal code_temp: STD_LOGIC_VECTOR(2 downto 0);
    
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
            temp1 <= (others => '0');
            temp2 <= (others => '0');        
            code_out <= "000";
            code_temp <= "000";
        elsif rising_edge(clk) then
            state <= state;
            case state is
                when IDLE =>
                    temp1 <= input1;
                    temp2 <= input2;
                    out_valid<= '0';
                    if in_valid1 = '1' and in_valid2 = '1' then
                        state <= COMPUTE;
                    else
                        state <= IDLE;
                    end if;
                
                when COMPUTE =>
                    -- Normal operation
                    if temp1 > temp2 then
                        code_temp <= code_A; -- input1 is greater than input2
                    elsif temp1 < temp2 then
                        code_temp <= code_B; -- input2 is greater than input1
                    else
                        code_temp <= "000"; -- input1 equals input2, could set to default or handle differently
                    end if;
                    state <= STORE;

                when STORE =>
                    code_out <= code_temp;
                    out_valid<= '1';
                    if out_ready = '1' then
                        state <= IDLE;
                    end if;
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;
    