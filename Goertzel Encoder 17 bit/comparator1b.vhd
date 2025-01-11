library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator1b is
    Port (
        clk, rst            : in STD_LOGIC;
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        input1              : in STD_LOGIC_VECTOR(16 downto 0);
        input2             : in STD_LOGIC_VECTOR(16 downto 0);
        output1b            : out STD_LOGIC_VECTOR(16 downto 0);
        code                : out STD_LOGIC_VECTOR (2 downto 0)
    );
end comparator1b;

architecture Behavioral of comparator1b is
    type state_type is (IDLE, COMPUTE, STORE);
    signal temp1, temp2, out_temp : STD_LOGIC_VECTOR(16 downto 0);
    signal state    : state_type;
    signal code_temp: STD_LOGIC_VECTOR(2 downto 0);
    
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset state
            output1b <= (others => '0');
            temp1 <= (others => '0');
            temp2 <= (others => '0');
            out_temp <= (others => '0');
            code <= "000";
            code_temp <= "000";
        elsif rising_edge(clk) then
            state <= state;
            case state is
                when IDLE =>
                    temp1 <= input1;
                    temp2 <= input2;    
                    out_valid<= '0';
                    if in_valid = '1' then
                        state <= COMPUTE;
                    else
                        state <= IDLE;
                    end if;
                
                when COMPUTE =>
                    -- Normal operation
                    if temp1 > temp2 then
                        out_temp <= temp1;
                        code_temp <= "011"; -- input1 lebih besar dari input2
                    elsif temp1 < temp2 then
                        out_temp <= temp2;
                        code_temp <= "100"; -- input2 lebih besar dari input1
                    else
                        out_temp <= (others => '0'); -- Equal case, could also set to either input1 or input2
                        code_temp <= "000"; -- Code for equality
                    end if;
                    state <= STORE;

                when STORE =>
                    code <= code_temp;
                    out_valid <= '1';
                    if out_ready = '1' then
                        output1b <= out_temp;
                        state <= IDLE;
                    end if;
                
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;
