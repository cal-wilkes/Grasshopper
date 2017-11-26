
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SAWTOOTH_WAVE_GENERATOR is
	port(   clk: in std_logic; 
	          enable: in std_logic;
			reset: in std_logic;
			sam: in INTEGER;
			MEAS: out INTEGER;
			SAW_PWM: out std_logic);
end SAWTOOTH_WAVE_GENERATOR;

architecture Behavioural of SAWTOOTH_WAVE_GENERATOR is

component PWM_JENNY is			
		Port ( 
		          num_of_cycles: in integer;
				  clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  
				  PWM : out  STD_LOGIC
			);
			
end component;



signal amp, temp, ink, intv, s_rate: integer :=0;
signal counter, internal_counter: integer;



begin




saw_jenny: PWM_JENNY
        PORT MAP (
                  num_of_cycles => amp,
                  CLK => CLK,
                  reset => reset,
                  PWM => SAW_PWM
        );


 
 process(ENABLE)
 
 begin
 
                             if(rising_edge(CLK)) then 
                             
                             
                             
                             if( ENABLE = '1') then
                                      
                             s_rate <= sam;
                             
                                        if( sam = 10000000) then 
                                        
                                         ink <= 500;
                                         intv <= 500000;
                                        
                                        elsif (sam = 20000000) then 
                                         ink <= 500;
                                         intv <= 1000000;
                                        
                                        
                                        elsif(sam = 30000000) then
                                         ink <= 500;
                                         intv <= 1500000;
                                        
                                        end if;
                             
                             
                             else
                             
                              ink <= 7;
                              intv <= 70000;
                              s_rate <= 100000000;
                             
                             
                             
                             end if;
                             
                             
                             
                             
                             END IF;
 
        
 
 
 
 end process;

 
 
 
 
               
        
process (CLK)

begin 



                if(rising_edge(CLK)) then 
                
      
                                
                       if(RESET = '1') then               
                             counter <= 0;
                             internal_counter <= 0;
                             amp <= 0;
                                      
                
                       elsif((counter < s_rate) and (internal_counter = intv)) then 
                             amp <= amp + ink;
                     
                             counter <= counter+1;
                             internal_counter <= 0;
                             
                       
                       elsif(counter < s_rate) then                    
                             counter <= counter+1;
                   
                             internal_counter <= internal_counter +1;
                             
                       
                       else
                            amp <= 0;
                            counter <= 0;
                            internal_counter <= 0;
                             
                       end if;
       
                end if;
                
end process;  

        meas <= amp;


end behavioural;