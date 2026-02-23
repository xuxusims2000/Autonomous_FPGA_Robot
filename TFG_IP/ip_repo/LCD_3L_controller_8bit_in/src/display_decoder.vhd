-- this module converts the distance calculated in bainary to the bits that represents the caracter in the LCD
--How does the LCD worck?
-- the LCD has 8 data bits and has a memory and a controler that links a simbol with a secuens of this 8 bits
--the otput has 128 bits thus is the 16 characters in a line times the 8 bits of the register that the LCD has to represent the simbol.

--Numbers in hex
--44 represents D 
--63 represents c 
--6D represents m 
--3A represents :
--20 represents blanc 
--30 represents 0 
--31 represents 1 
--32 represents 2  
--33 represents 3 
--34 represents 4  
--35 represents 5 
--36 represents 6
--37 represents 7 
--38 represents 8 
--39 represents 9 
--3E represents >

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity display_decoder is
    Port ( Distance : in  STD_LOGIC_VECTOR (8 downto 0);-- variable used to count the distance  max value (max distance) 400 cm
           display_out: out std_logic_vector (127 downto 0)); --- inizialize to blanck in the LCD
end display_decoder;

architecture Behavioral of display_decoder is
    
    signal display : std_logic_vector (127 downto 0) := x"20202020202020202020202020202020";

begin

display(127 downto 120) <= x"44"; -- D
display(119 downto 112) <= x"31"; -- 1
display(111 downto 104) <= x"3A"; -- :


display(79 downto 72) <= x"6D"; -- m

process(Distance)
    begin

    if Distance >  "1100011" then -- if the distance is more than 1m 
        display(87 downto 80) <= x"20"; -- blanck
        display(103 downto 96) <= x"3E"; -- >
        display(95 downto 88) <= x"31"; -- 1
           
        else
            
            case Distance is
            when "000000001" => display(103 downto 88) <= x"30" & x"31"; -- 1
            when "000000010" => display(103 downto 88) <= x"30" & x"32"; -- 2
            when "000000011" => display(103 downto 88) <= x"30" & x"33"; -- 3
            when "000000100" => display(103 downto 88) <= x"30" & x"34"; -- 4
            when "000000101" => display(103 downto 88) <= x"30" & x"35"; -- 5
            when "000000110" => display(103 downto 88) <= x"30" & x"36"; -- 6
            when "000000111" => display(103 downto 88) <= x"30" & x"37"; -- 7
            when "000001000" => display(103 downto 88) <= x"30" & x"38"; -- 8
            when "000001001" => display(103 downto 88) <= x"30" & x"39"; -- 9
            
            when "000001010" => display(103 downto 88) <= x"31" & x"30"; -- 10
            when "000001011" => display(103 downto 88) <= x"31" & x"31"; -- 11
            when "000001100" => display(103 downto 88) <= x"31" & x"32"; -- 12
            when "000001101" => display(103 downto 88) <= x"31" & x"33"; -- 13
            when "000001110" => display(103 downto 88) <= x"31" & x"34"; -- 14
            when "000001111" => display(103 downto 88) <= x"31" & x"35"; -- 15
            when "000010000" => display(103 downto 88) <= x"31" & x"36"; -- 16
            when "000010001" => display(103 downto 88) <= x"31" & x"37"; -- 17
            when "000010010" => display(103 downto 88) <= x"31" & x"38"; -- 18
            when "000010011" => display(103 downto 88) <= x"31" & x"38"; -- 19
            
            when "000010100" => display(103 downto 88) <= x"31" & x"39"; -- 20            
            when "000010101" => display(103 downto 88) <= x"32" & x"30"; -- 
            when "000010110" => display(103 downto 88) <= x"32" & x"31"; -- 
            when "000010111" => display(103 downto 88) <= x"32" & x"32"; -- 
            when "000011000" => display(103 downto 88) <= x"32" & x"33"; -- 
            when "000011001" => display(103 downto 88) <= x"32" & x"34"; -- 
            when "000011010" => display(103 downto 88) <= x"32" & x"35"; -- 
            when "000011011" => display(103 downto 88) <= x"32" & x"36"; -- 
            when "000011100" => display(103 downto 88) <= x"32" & x"37"; -- 
            when "000011101" => display(103 downto 88) <= x"32" & x"38"; --              
            
            when "000011110" => display(103 downto 88) <= x"32" & x"39"; --30             
            when "000011111" => display(103 downto 88) <= x"32" & x"39"; --  
            when "000100000" => display(103 downto 88) <= x"33" & x"31"; -- 
            when "000100001" => display(103 downto 88) <= x"33" & x"32"; -- 
            when "000100010" => display(103 downto 88) <= x"33" & x"33"; -- 
            when "000100011" => display(103 downto 88) <= x"33" & x"34"; -- 
            when "000100100" => display(103 downto 88) <= x"33" & x"35"; -- 
            when "000100101" => display(103 downto 88) <= x"33" & x"36"; -- 
            when "000100110" => display(103 downto 88) <= x"33" & x"37"; -- 
            when "000100111" => display(103 downto 88) <= x"33" & x"38"; -- 

            when "000101000" => display(103 downto 88) <= x"34" & x"39"; --40
            when "000101001" => display(103 downto 88) <= x"34" & x"39"; -- 
            when "000101010" => display(103 downto 88) <= x"34" & x"39"; --
            when "000101011" => display(103 downto 88) <= x"34" & x"39"; --
            when "000101100" => display(103 downto 88) <= x"34" & x"39"; --
            when "000101101" => display(103 downto 88) <= x"34" & x"39"; --
            when "000101110" => display(103 downto 88) <= x"34" & x"39"; --
            when "000101111" => display(103 downto 88) <= x"34" & x"39"; --
            when "000110000" => display(103 downto 88) <= x"34" & x"39"; --
            when "000110001" => display(103 downto 88) <= x"34" & x"39"; --

            when "000110010" => display(103 downto 88) <= x"35" & x"39"; --50
            when "000110011" => display(103 downto 88) <= x"35" & x"39"; --
            when "000110100" => display(103 downto 88) <= x"35" & x"39"; --
            when "000110101" => display(103 downto 88) <= x"35" & x"39"; --
            when "000110110" => display(103 downto 88) <= x"35" & x"39"; --
            when "000110111" => display(103 downto 88) <= x"35" & x"39"; --
            when "000111000" => display(103 downto 88) <= x"35" & x"39"; --
            when "000111001" => display(103 downto 88) <= x"35" & x"39"; --
            when "000111010" => display(103 downto 88) <= x"35" & x"39"; --
            when "000111011" => display(103 downto 88) <= x"35" & x"39"; --

            when "000111100" => display(103 downto 88) <= x"36" & x"39"; --60
            when "000111101" => display(103 downto 88) <= x"36" & x"39"; --
            when "000111110" => display(103 downto 88) <= x"36" & x"39"; --
            when "000111111" => display(103 downto 88) <= x"36" & x"39"; --
            when "001000000" => display(103 downto 88) <= x"36" & x"39"; --
            when "001000001" => display(103 downto 88) <= x"36" & x"39"; --
            when "001000010" => display(103 downto 88) <= x"36" & x"39"; --
            when "001000011" => display(103 downto 88) <= x"36" & x"39"; --
            when "001000100" => display(103 downto 88) <= x"36" & x"39"; --
            when "001000101" => display(103 downto 88) <= x"36" & x"39"; --

            when "001000110" => display(103 downto 88) <= x"37" & x"39"; --70
            when "001000111" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001000" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001001" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001010" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001011" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001100" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001101" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001110" => display(103 downto 88) <= x"37" & x"39"; --
            when "001001111" => display(103 downto 88) <= x"37" & x"39"; --

            when "001010000" => display(103 downto 88) <= x"38" & x"39"; --80
            when "001010001" => display(103 downto 88) <= x"38" & x"39"; --
            when "001010010" => display(103 downto 88) <= x"38" & x"39"; --
            when "001010011" => display(103 downto 88) <= x"38" & x"39"; --
            when "001010100" => display(103 downto 88) <= x"38" & x"39"; --
            when "001010101" => display(103 downto 88) <= x"38" & x"39"; --
            when "001010110" => display(103 downto 88) <= x"38" & x"39"; --
            when "001010111" => display(103 downto 88) <= x"38" & x"39"; --
            when "001011000" => display(103 downto 88) <= x"38" & x"39"; --
            when "001011001" => display(103 downto 88) <= x"38" & x"39"; --

            when "001011010" => display(103 downto 88) <= x"39" & x"39"; --90
            when "001011011" => display(103 downto 88) <= x"39" & x"39"; --
            when "001011100" => display(103 downto 88) <= x"39" & x"39"; --
            when "001011101" => display(103 downto 88) <= x"39" & x"39"; --
            when "001011110" => display(103 downto 88) <= x"39" & x"39"; --
            when "001011111" => display(103 downto 88) <= x"39" & x"39"; --
            when "001100000" => display(103 downto 88) <= x"39" & x"39"; --
            when "001100001" => display(103 downto 88) <= x"39" & x"39"; --
            when "001100010" => display(103 downto 88) <= x"39" & x"39"; --
            when "001100011" => display(103 downto 88) <= x"39" & x"39"; --
            
             when others => display(103 downto 88) <= x"2020"; -- blank
 
            
   
            
            end case;
        
        display(87 downto 80) <= x"63"; -- c
    end if;
    
    
end process;

display_out <= display;
				  

end Behavioral;