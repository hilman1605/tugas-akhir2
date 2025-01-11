library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity delay1477 is
    Port (
        clk, rst    : in STD_LOGIC;
        in_valid    : in STD_LOGIC;
        out_ready   : in STD_LOGIC;
        out_valid   : out STD_LOGIC;
        input1477   : in STD_LOGIC_VECTOR(16 downto 0);
        output1477  : out STD_LOGIC_VECTOR(16 downto 0)
    );
end delay1477;

architecture Behavioral of delay1477 is
    type state_type is (IDLE, COMPUTE, STORE);
    signal state    : state_type;
    signal temp_input, temp_output : std_logic_vector(16 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset state
            state <= IDLE;
            temp_input <= (others => '0');
            temp_output <= (others => '0');
        elsif rising_edge(clk) then
            state <= state;
            case state is
                when IDLE =>
                    out_valid<= '0';
                    if in_valid = '1' then 
                        temp_input <= input1477;
                        state <= COMPUTE;
                    else
                        state <= IDLE;
                    end if;
                -- Normal operation
                when COMPUTE =>
                    temp_output <= temp_input;
                    
                    state <= STORE;

                when STORE =>
                    output1477 <= temp_output;
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
    