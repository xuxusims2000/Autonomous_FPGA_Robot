
-- Trigger generator 
-- This block is in charge to create a pulse of 10 us with every 20 ms
--10us is what the sensor needs to understand the order to send the sound wave
--20 ms is the max time that we wait the sound wave to return it is equivalent to say that is the 
-- fardes that the sensor can sense.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity TriggerGen is
    
    Port ( clk : in  STD_LOGIC;
            trigger : out  STD_LOGIC);
    end TriggerGen;

architecture Behavioral of TriggerGen is

    signal tick: std_logic_vector(19 downto 0) := (others =>'1'); --19 due has to be able to count to 1000000
    constant nclks: integer := 1000000;  --if we have 50MHz clk we neet to caunt thes to whati 20 ms 

    begin
        process (clk) begin
            if clk'event and clk = '1' then
                if tick < nclks-1 then
                    tick <= tick + 1;
                else
                    tick <= (others => '0');
                end if;
            end if;
        end process;
 
 trigger <= '1' when (tick < 500) else '0'; -- 500 is equivalent to 10 us that is the time that the pulse high 
 -- so the sensor understans to send the wave
end behavioral;