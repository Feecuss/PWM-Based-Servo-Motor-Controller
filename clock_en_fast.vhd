library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;  
use IEEE.std_logic_unsigned.all;

----------------------------------------------------------------------------------

entity clock_enable_fast is

    generic(
            PERIOD : integer := 200000 -- 500Hz
            );

    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           pulse_fast    : out STD_LOGIC);
end clock_enable_fast;

----------------------------------------------------------------------------------

architecture Behavioral of clock_enable_fast is

    constant BITS_NEEDED : integer := integer(ceil(log2(real(PERIOD+1))));
    signal sig_count : std_logic_vector(BITS_NEEDED - 1 downto 0);

begin
    --! Generate clock enable signal. By default, enable signal
    --! is low and generated pulse is always one clock long.
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            -- if high-active reset then
            if (rst = '1') then

                -- Clear all bits of local counter
                sig_count <= (others => '0'); 
                -- Set output `pulse` to low
                pulse_fast <= '0';
            -- elsif sig_count is PERIOD-1 then
            elsif (sig_count = PERIOD-1) then 
                -- Clear all bits of local counter
                sig_count <= (others => '0');
                -- Set output `pulse` to high
                pulse_fast <= '1';
            -- else
            else 
                -- Increment local counter
                sig_count <= sig_count +1;
                -- Set output `pulse` to low
                pulse_fast <= '0';
            -- Each `if` must end by `end if`
            end if;
        end if;

    end process p_clk_enable;

end architecture behavioral;