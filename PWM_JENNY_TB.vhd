library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PWM_JENNY_TB is
end PWM_JENNY_TB;

ARCHITECTURE behavior OF PWM_JENNY_TB IS 


COMPONENT PWM_JENNY is				
	
		Port ( 
		          num_of_cycles: in integer;
				  clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  PWM : out  STD_LOGIC
			);
			
end COMPONENT;
 
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal num_of_cycles: INTEGER := 0;


	--Outputs
    signal PWM: STD_LOGIC;
    
    
    
    
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	
	UUT: PWM_JENNY 
            Port MAP ( 
                      num_of_cycles => num_of_cycles,
                      clk => clk,
                      reset => reset,
                      PWM => PWM
                );
                
	


   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '0';
      wait for 100 ns;	
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
		reset <= '0';
      wait for 100 ns;    
        num_of_cycles <= 10;
      wait for 100 ns;
        num_of_cycles <= 20;
      wait for 100 ns;    
        num_of_cycles <= 30;
      wait for 100 ns;
        num_of_cycles <= 40;
      wait for 100 ns;    
        num_of_cycles <= 50;
      wait for 100 ns;
        num_of_cycles <= 60;
                                
		
      wait;
   end process;

END behavior;