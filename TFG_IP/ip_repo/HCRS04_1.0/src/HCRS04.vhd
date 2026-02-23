
--Description HCRS04
-- This is the union of the diferent bloks that control the distance sensor
-- It is commposed by Counter , register , display decoder , trigger generator 


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity HCRS04 is
    Port ( clk : in  STD_LOGIC;
           echo : in  STD_LOGIC;
           Trigger : out  STD_LOGIC;			
           display_out : out  STD_LOGIC_VECTOR (127 downto 0):= (others=>'0'); -- this will input the LCD;  16 characters in a line times the 8 bits of the register that the LCD
           Distance : out std_logic_vector (8 downto 0) := (others=>'0'); -- distance in cm so the procesor can use it
           reset_n: out std_logic :='1');
end HCRS04;

architecture Behavioral of HCRS04 is

--Especification of every module

COMPONENT TriggerGen   -- create a pulse of 10 us with every 20 
	PORT(
		clk : IN std_logic;          
		trigger : OUT std_logic
		);
	END COMPONENT;

COMPONENT Time_counter --Caunts the time that the waves takes to go and bounce in an obstacle 
	PORT(
		clk : IN std_logic;
		trigger : IN std_logic;   --  it is like the reset
		echo: IN std_logic;    -- it is the enable of the counter       
		D : OUT std_logic_vector(8 downto 0) --max value (max distance) 400 cm
		);
	END COMPONENT;
	

COMPONENT display_decoder
	PORT(
		Q : IN std_logic_vector(8 downto 0);  --max value (max distance) 400 cm        
		display_out : OUT std_logic_vector(127 downto 0)  -- this will input the LCD;  16 characters in a line times the 8 bits of the register that the LCD
		);
	END COMPONENT;

signal Trigger_Gout: std_logic;  -- Signal that goes from the output of the trigger generator to the input of the time counter
signal D : STD_LOGIC_VECTOR (8 downto 0); -- Is the out of time counter the time that the signale tock to go an back
signal Q : STD_LOGIC_VECTOR (8 downto 0); -- is the signal after the register


begin

-- Declaration of the instances of every module

Inst_TriggerGen: TriggerGen PORT MAP(
		clk,
		Trigger_Gout 
	);
	
Inst_Time_counet: Time_counter PORT MAP(
		clk,
		Trigger_Gout,
		echo,
		D 
	);
	
	-- we use a register to atualize the output only every time tha we have a nwe calculation of distance
	process(echo) begin -- cada cop que deixi de contar actualitzarem la distancia en el display
		if falling_edge(echo) then
			Q <= D;
		end if;
	
	end process;
	
	Distance <= Q;
	
	
Inst_display_decoder: display_decoder PORT MAP(
		Q ,
		display_out 
	);

Trigger <= Trigger_Gout;



end Behavioral;
