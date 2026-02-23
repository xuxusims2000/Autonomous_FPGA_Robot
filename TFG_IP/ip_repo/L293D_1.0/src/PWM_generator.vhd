
--Primera prova crean un architecture
--3/21/architecture
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
    duty_up: in std_logic; -- To increase the speed 
    duty_down: in std_logic; -- To decrease the speed
    PWM_OUT: out std_logic; -- Signal to atac the enable
    
   
    Direction: in std_logic:='1';  -- Signal that indicates the direction of rotation
    Forward: out std_logic ; -- Sinbol to atac the input1
    Backward: out std_logic  -- Simbol to atac the input2
        
);

end PWM_generator;

architecture Behavioral of PWM_generator is

component DEBOUNCING Port(

    CLK: in std_logic ;
    en: in std_logic ;
    D: in std_logic ;
    Q: out std_logic 
);
end component;



signal slow_clk_en: std_logic :='0'; -- enable for debouncing 
signal counter_slow: std_logic_vector (23 downto 0 ):= (others => '0'); -- to create slower clk
signal counter_PWM: std_logic_vector (19 downto 0):=(others => '0');

signal tmp1,tmp2,duty_inc: std_logic;-- temporary signals for deboucing
signal tmp3,tmp4,duty_dec: std_logic;-- temporary signals for deboucing 


signal DUTY_CYCLE: std_logic_vector(16 downto 0):= (others => '0'); --0 initialize to 0% duty
signal onek : std_logic_vector (16 downto 0):="11110100001001000"; --125000
signal ms_enable: std_logic_vector (23 downto 0):="101111101011110000100000";

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
       
   --Debouncing process 
   -- First generate slow clk enable for debouncing (10khz) it chenks the butons status everi 100ms
    slow_clk_en_process: process(clk)
    begin
        if(rising_edge(clk)) then
            counter_slow <= counter_slow + x"1" ;
           if(counter_slow = ms_enable) then
             --if(counter_slow = x"1") then   -- he de comptar fins a 6250 per fer un pols per obtindre una frequencia de 10hz  a de contar 31250
                counter_slow <= (others => '0');
            end if;       
        end if;                     
    end process;
    
    slow_clk_en <= '1' when counter_slow = ms_enable else '0'; -- comment when running on FPGA
    --slow_clk_en <= '1' when counter_slow = "1" else '0';-- for running simulation

 -- debounce part for duty increasing button --> sincronitzacio + deteccio flanc de pujada del boto up
 stage0: DEBOUNCING port map(clk,slow_clk_en , duty_up, tmp1);
 stage1: DEBOUNCING port map(clk,slow_clk_en , tmp1, tmp2); 
 duty_inc <=  tmp1 and (not tmp2) and slow_clk_en;

 -- debounce part for duty decreasing button --> sincronitzacio + deteccio flanc de pujada del boto down
 stage2: DEBOUNCING port map(clk,slow_clk_en , duty_down, tmp3);
 stage3: DEBOUNCING port map(clk,slow_clk_en , tmp3, tmp4); 
 duty_dec <=  tmp3 and (not tmp4) and slow_clk_en;

   PWM_frq: process(clk) -- we generate a signal of 1khz
   begin
    if(rising_edge(clk)) then
        
            counter_PWM <= counter_PWM + x"1";
            if(counter_PWM>= onek) then -- conetem fins a 12500 per treure 1khz
            counter_PWM <= (others => '0');
            end if;
       
    end if;
   end process;
    

    --per dividir en 10% haurem de sumar a duti cicle 12500 
    PWM_control: process(clk)
    begin
        if(rising_edge(clk)) then 
            if(duty_inc = '1' and DUTY_CYCLE <= x"1B774") then --112500 es lultim havans de 125000 que seria el 100%
                DUTY_CYCLE  <= DUTY_CYCLE + x"30D4"; -- sumem o restem 12500 q es el 10%
            elsif (duty_dec = '1' and DUTY_CYCLE >= x"30D4") then -- 12500 es el 10%
                DUTY_CYCLE <= DUTY_CYCLE -x"30D4"; 
            end if;         
        end if;        
    end process;
   
    
 PWM_OUT <= '1' when counter_PWM < DUTY_CYCLE else '0';
    

end Behavioral;


















