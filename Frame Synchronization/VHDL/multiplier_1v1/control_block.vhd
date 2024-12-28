library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_block is
    Port (
        clk, reset, ready : in STD_LOGIC;
        sine_697, sine_941, sine_1477 : in std_logic_vector(15 downto 0);
        sin_out : out std_logic_vector(15 downto 0);
        address : out STD_LOGIC_VECTOR(9 downto 0)
    );
end control_block;

architecture Behavioral of control_block is
    type state_type is (IDLE, SELECTING, LOAD_DATA);
    signal state, next_state : state_type := IDLE;
    signal selector : INTEGER range 0 to 2 := 0;
    signal selected_input : std_logic_vector(15 downto 0);
    signal address_internal : INTEGER range 0 to 640 := 0;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            next_state <= IDLE;
            selector <= 0;
            address_internal <= 0;
            selected_input <= (others => '0');
        elsif rising_edge(clk) then
            state <= next_state;
            case state is
                when IDLE =>
                    if ready = '1' then
                        selector <= 0;
                        next_state <= SELECTING;
                    else
                        next_state <= IDLE;
                    end if;

                when LOAD_DATA =>
                    case selector is
                        when 0 =>
                            selected_input <= sine_697;
                            next_state <= SELECTING;
                        when 1 =>
                            selected_input <= sine_941;
                            next_state <= SELECTING;
                        when 2 =>
                            selected_input <= sine_1477;
                            next_state <= SELECTING;
                        when others =>
                            selected_input <= (others => '0'); -- Default case or hold previous value
                    end case;
                    next_state <= SELECTING;

                when SELECTING =>
                    if selector < 2 then
                        selector <= selector + 1;
                        next_state <= LOAD_DATA;
                    else
                        -- Update address
                        if address_internal < 640 then
                            address_internal <= address_internal + 1;
                        else
                            address_internal <= 0;
                        end if;
                        next_state <= IDLE;
                    end if;
            end case;
        end if;
    end process;

    -- Output assignments
    sin_out <= selected_input; -- Assign the selected input to output
    address <= std_logic_vector(to_unsigned(address_internal, 10)); -- Convert address to logic vector
end Behavioral;
