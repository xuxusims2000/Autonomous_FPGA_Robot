
--ths code generates a pwm signal to control the speed of the motors 
--It also atacs the L263D IC meaning tha will out singals to control de direction of the motors 
-- est pensat per a un clk de 125MHZ


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_generator is

port (
    clk: in std_logic; -- 125 MHz clk input
    gear: in std_logic_vector (2 downto 0); -- To increase the speed 
    PWM_OUT: out std_logic; -- Signal to atac the enable     
    Direction: in std_logic:='1';  -- Signal that indicates the direction of rotation
    Forward: out std_logic ; -- Sinbol to atac the input1
    Backward: out std_logic  -- Simbol to atac the input2
        
);

end PWM_generator;

architecture Behavioral of PWM_generator is

signal sgear: std_logic_vector (2 downto 0):=(others=>'0');
signal counter_PWM: std_logic_vector (19 downto 0):=(others => '0');
signal DUTY_CYCLE: std_logic_vector(16 downto 0):= (others => '0'); --0 initialize to 0% duty
signal onek : std_logic_vector (16 downto 0):="11110100001001000"; --125000

begin

    direction_proces: process(clk) --- these proces will select de direction of rotation of the motors 
    begin
    if rising_edge(clk) then
        if Direction = '1' then 
            Forward <= '1';
            Backward <= '0';
        else    
            Forward <= '0';
            Backward <= '1';        
        end if;     
    end if;
    end process;            
        
   PWM_frq: process(clk) -- we generate a signal of 1khz
   begin
    if(rising_edge(clk)) then
        
            counter_PWM <= counter_PWM + x"1";
            if(counter_PWM>= onek) then -- conetem fins a 125000 per treure 1khz
            counter_PWM <= (others => '0');
            end if;      
    end if;
   end process;
      
    PWM_control: process(gear)
    begin
        
        case gear is
            when "000" =>DUTY_CYCLE  <= (others => '0');
            when "001" =>DUTY_CYCLE  <= "01100001101010000"; --50000
            when "010" =>DUTY_CYCLE  <= "01111001000110000"; --62000
            when "011" =>DUTY_CYCLE  <= "10101010111001100"; --87500
            when "100" =>DUTY_CYCLE  <= "11011011101110100"; --112500
            when "101" =>DUTY_CYCLE  <= "11110100001001000"; --125000
            when others =>DUTY_CYCLE  <= (others => '0');
        end case;
                
    end process;
       
 PWM_OUT <= '1' when counter_PWM < DUTY_CYCLE else '0';
    
end Behavioral;


















