LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lcd_controller_v2 IS
  PORT(
    clk        : IN    STD_LOGIC;  --system clock
    reset_n    : IN    STD_LOGIC;  --active low reinitializes lcd
    Distance1  : IN    std_logic_vector (8 downto 0);
    Distance2  : IN    std_logic_vector (8 downto 0);
    Distance3  : IN    std_logic_vector (8 downto 0);
    rw, rs, e  : OUT   STD_LOGIC;  --read/write, setup/data, and enable for lcd
    lcd_data   : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0) --data signals for lcd
    
	 );

END lcd_controller_v2;

ARCHITECTURE controller OF lcd_controller_v2 IS

  TYPE CONTROL IS(power_up, initialize, RESETLINE, line1, line2,line3, send);
  SIGNAL    state      : CONTROL;
  CONSTANT  freq       : INTEGER := 125; --system clock frequency in MHz
  SIGNAL 	ptr     	  : natural range 0 to 16 := 15; -- To keep track of what character we are up to
  SIGNAL 	line		  : std_logic_vector  (1 downto 0):= "00";  
  
  --the display that we use has 4 lines and 20 characters however the IC manage the info like it had 2 lines adn 40 characters
  
  signal line1_buffer : STD_LOGIC_VECTOR(127 downto 0); -- Data for the top line of the LCD
  signal line2_buffer : STD_LOGIC_VECTOR(127 downto 0); -- Data for the bottom line of the LCD
  signal line3_buffer : STD_LOGIC_VECTOR (127 downto 0);
  
  COMPONENT display_decoder
	PORT(
		Distance : IN std_logic_vector(8 downto 0);  --max value (max distance) 400 cm        
		display_out : OUT std_logic_vector(127 downto 0)  -- this will input the LCD;  16 characters in a line times the 8 bits of the register that the LCD
		);
	END COMPONENT;
  
BEGIN

    Instance_display_decoder1: display_decoder port map(
        Distance1,
        line1_buffer         
    );
    
    Instance_display_decoder2: display_decoder port map(
        Distance2,
        line2_buffer         
    );
    
    Instance_display_decoder3: display_decoder port map(
        Distance3,
        line3_buffer         
    );

  PROCESS(clk)
    VARIABLE clk_count : INTEGER := 0; --event counter for timing
  BEGIN
  IF(clk'EVENT and clk = '1') THEN
    
      CASE state IS
        
        --wait 50 ms to ensure Vdd has risen and required LCD wait is met
        WHEN power_up =>
          IF(clk_count < (50000 * freq)) THEN    --wait 50 ms
            clk_count := clk_count + 1;
            state <= power_up;
          ELSE                                   --power-up complete
            clk_count := 0;
            rs <= '0';
            rw <= '0';
            lcd_data <= "00110000";
            state <= initialize;
          END IF;
          
        --cycle through initialization sequence  
        WHEN initialize =>
          clk_count := clk_count + 1;
          IF(clk_count < (10 * freq)) THEN       --function set
            lcd_data <= "00111100";      --2-line mode, display on
            e <= '1';
            state <= initialize;
          ELSIF(clk_count < (60 * freq)) THEN    --wait 50 us
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
          ELSIF(clk_count < (70 * freq)) THEN    --display on/off control
            lcd_data <= "00001100";      --display on, cursor off, blink off      
            e <= '1';
            state <= initialize;
          ELSIF(clk_count < (120 * freq)) THEN   --wait 50 us
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
          ELSIF(clk_count < (130 * freq)) THEN   --display clear
            lcd_data <= "00000001";
            e <= '1';
            state <= initialize;
          ELSIF(clk_count < (2130 * freq)) THEN  --wait 2 ms
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
          ELSIF(clk_count < (2140 * freq)) THEN  --entry mode set
            lcd_data <= "00000110";      --increment mode, entire shift off
            e <= '1';
            state <= initialize;
          ELSIF(clk_count < (2200 * freq)) THEN  --wait 60 us
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
          ELSE                                   --initialization complete
            clk_count := 0;
            state <= RESETLINE;
          END IF;    
			 
		  WHEN resetline =>
			 ptr <= 16;
			 if line = "00" then
			     lcd_data <= "10000000";
                rs <= '0';
                rw <= '0';
                clk_count := 0; 
                state <= send;
			 elsif line = "01" then
			   lcd_data <= "11000000";
                rs <= '0';
                rw <= '0';
                clk_count := 0; 
                state <= send;
             elsif line = "10" then
			   lcd_data <= "10010100";
                rs <= '0';
                rw <= '0';
                clk_count := 0; 
                state <= send;
			 end if;
       
        WHEN line1 =>
			line <= "00";
			lcd_data <= line1_buffer(ptr*8 + 7 downto ptr*8);
            rs <= '1';
            rw <= '0';
            clk_count := 0; 				
            state <= send;
				
		  WHEN line2 =>
			line <= "01";
			lcd_data <= line2_buffer(ptr*8 + 7 downto ptr*8);			
            rs <= '1';
            rw <= '0';
            clk_count := 0;            
            state <= send;
          
          WHEN line3 =>
			line <= "10";
			lcd_data <= line3_buffer(ptr*8 + 7 downto ptr*8);			
            rs <= '1';
            rw <= '0';
            clk_count := 0;            
            state <= send;  
      
		  
        --send instruction to lcd        
        WHEN send =>
			  IF(clk_count < (50 * freq)) THEN  --do not exit for 50us
				  IF(clk_count < freq) THEN      --negative enable
					e <= '0';
				  ELSIF(clk_count < (14 * freq)) THEN  --positive enable half-cycle
					e <= '1';
				  ELSIF(clk_count < (27 * freq)) THEN  --negative enable half-cycle
					e <= '0';
				  END IF;
				  clk_count := clk_count + 1;
				  state <= send;
			  ELSE
			  	  clk_count := 0;
				  if line = "00" then
					   if ptr = 0 then
							line <= "01";
							state <= resetline;
						else
							ptr <= ptr - 1;
							state <= line1;
						end if;
				  elsif line = "01" then 
						if ptr = 0 then
							line <= "10";
							state <= resetline;
						else
							ptr <= ptr - 1;
							state <= line2;
						end if;
				  elsif line = "10" then
				        if ptr = 0 then
							line <= "00";
							state <= resetline;
						else
							ptr <= ptr - 1;
							state <= line3;
						end if;
				  end if;
			  END IF;

      END CASE;    
    
      --reset
      IF(reset_n = '0') THEN
          state <= power_up;
      END IF;
    
    END IF;
  END PROCESS;
END controller;