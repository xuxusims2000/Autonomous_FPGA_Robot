
-- description:
-- this block counts clk pulses of a clk signal of a 17kh signal the period of it is the time that 
-- the sound wave takes to do 1 cm


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Time_counter is

    Port ( clk : in  STD_LOGIC;      -- clk signal 125 Mhz 
           trigger : in  STD_LOGIC; --reset 
           echo : in  STD_LOGIC;--enable
           D : out  STD_LOGIC_VECTOR (8 downto 0)); --distance already calculated : max value (max distance) 400 cm
           
end Time_counter;

architecture Behavioral of Time_counter is


signal tick: std_logic_vector(8 downto 0):= (others=>'0'); -- variable used to count the distance  max value (max distance) 400 cm
signal counter : std_logic_vector (12 downto 0) := (others=>'0'); --variable used to generate 17Khz
signal clk17k: std_logic := '0' ;

begin

-- in this proces we are creating a ckl signal of 17Khz wich period is 58.823us wich is the time that a wave takes to sense 1cm 
-- this way we will already have the distance in cm at the output 

process (clk) begin

    if clk 'event and clk = '1' then
            counter <= counter +1; 
            clk17k <= '0';
            if counter  = "1110010111001" then --7353 the number of periods of 8ns that have to count to have a period of 17kkhz
                clk17k <= '1';
                counter <= (others => '0');
            end if;
         end if;       
                    
end process;

-- in this proces we count the distance 

process (clk17k) begin

	if trigger = '1' then
		tick <= (others => '0');
	elsif clk17k 'event and clk17k = '1' then
		if echo = '1' then
			tick <= tick + 1;
		end if;
	end if;
end process;

D <= tick;

end Behavioral;