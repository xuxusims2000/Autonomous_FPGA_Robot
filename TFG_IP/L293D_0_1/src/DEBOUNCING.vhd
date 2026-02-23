----------------------------------------------------------------------------------

-- Create Date: 03.04.2024 18:54:36

-- Module Name: DEBOUNCING - Behavioral

--es basicament un registre que el q fara es pasar al seguent cada cop que li entri un flanc de pujada 
-- la idea es posarli un clk mes lent 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEBOUNCING is
  Port (
  
    CLK: in std_logic ;
    en: in std_logic ;
    D: in std_logic ;
    Q: out std_logic   
   );

end DEBOUNCING;

architecture Behavioral of DEBOUNCING is

begin

process(CLK) begin

    if(rising_edge(CLK)) then 
        if (en='1') then
            Q <= D;
        end if;
     end if;

end process ;

end Behavioral;



















